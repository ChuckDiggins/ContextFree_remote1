//
//  CFSentenceGeneratorRule.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/2/21.
//

import Foundation

//handles create templates that will guide
//  in creating sentences of various complexity of random words

struct ContextFreeConstructionGrammar {
    var m_wsp : WordStringParser?
    var name = ""
    var description = ""
    var m_randomWord : RandomWordLists?
    
    init(wsp: WordStringParser){
        m_wsp = wsp
        m_randomWord = RandomWordLists(wsp: m_wsp!)
    }
 
    var cfRuleList = Array<ContextFreeRule>()
    
    mutating func addRule(cfr: ContextFreeRule){
        cfRuleList.append(cfr)
    }
    
    func getRuleCount()->Int{
        return cfRuleList.count
    }
    
    func getRuleName(index: Int)->String{
        return cfRuleList[index].getRuleName()
    }
    
    func getRuleAt(index: Int)->ContextFreeRule{
        return cfRuleList[index]
    }
    
}

enum RandomPhraseType{
    case twoArticles
    case subjectPronounVerb
    case simpleNounPhrase
    case simplePrepositionPhrase
    case simpleVerbPhrase
    case complexNounPhrase
    case simpleClause
    case simpleAdjectiveRegular
    case simpleAdjectivePossessive
    case simpleAdjectiveInterrogative
    case simpleAdjectiveDemonstrative
}

struct RandomSentence {
    var m_wsp : WordStringParser!
    var m_randomWord : RandomWordLists!
    var m_rft = RandomPhraseType.simpleNounPhrase
    var m_wordList = [Word]()
    
    init (wsp : WordStringParser, rft:RandomPhraseType){
        self.m_wsp = wsp
        self.m_randomWord = RandomWordLists(wsp: m_wsp)
        self.m_rft = rft
    }
    
    mutating func createRandomSentenceNew()->dIndependentClause{
        return createRandomPhrase(phraseType: m_rft)

    }
    
    mutating func createRandomPhrase(phraseType: RandomPhraseType)->dIndependentClause {
        var phrase = dPhrase()
        
        switch phraseType{
        case .twoArticles:
            phrase = createTwoArticles()
        case .simpleAdjectiveRegular:
            phrase = createSimpleNounPhrase()
        case .simpleAdjectivePossessive:
            phrase = createSimpleNounPhrase()
        case .simpleAdjectiveInterrogative:
            phrase = createSimpleNounPhrase()
        case .simpleAdjectiveDemonstrative:
            phrase = createSimpleNounPhrase()
        case .simpleNounPhrase:
            phrase = createSimpleNounPhrase()
        case .simplePrepositionPhrase:
            phrase = createSimplePrepositionPhrase()
        case .simpleVerbPhrase:
            phrase = createSimpleVerbPhrase()
        case .complexNounPhrase:
            phrase = createComplexNounPhrase()
        case .simpleClause:
            return createSimpleClause()
        case .subjectPronounVerb:
            return createSubjectPronounVerbClause()
        }
        
        let clause = dIndependentClause(language: m_wsp.getLanguage())
        clause.appendCluster(cluster: phrase)
        clause.setHeadNounAndHeadVerb()
        return clause
    }
    
    mutating func createTwoArticles()->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP1.processInfo()
        return NP1
    }
    
    mutating func createSimpleNounPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP1.processInfo()
        return NP1
    }
    
    mutating func createSimplePrepositionPhrase()->dPhrase{
        let NP1 = dNounPhrase()

        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP1.processInfo()
        
        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .preposition, isSubject:false))
        PP1.appendCluster(cluster: NP1)
        return PP1
    }
    
    mutating func createComplexNounPhrase()->dPhrase{
        /*
        let single1 = m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false)
        let single2 = m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false)
        let adj1 = single1 as! dAdjectiveSingle
        let adj2 = single2 as! dAdjectiveSingle
        adj1.setState(gender: .feminine, number: .singular)
        adj2.setState(gender: .masculine, number: .plural)
        var adjStr1 = adj1.getWordString()
        var adjStr2 = adj2.getWordString()
        print("Before ... Adj1 = \(adjStr1), Adj2 = \(adjStr2)")
        
        adj2.setState(gender: .feminine, number: .singular)
        adjStr1 = adj1.getWordString()
        adjStr2 = adj2.getWordString()
        print("After 1 ... Adj1 = \(adjStr1), Adj2 = \(adjStr2)")
        
        adj1.setState(gender: .masculine, number: .plural)
        adjStr1 = adj1.getWordString()
        adjStr2 = adj2.getWordString()
        print("After 2 ... Adj1 = \(adjStr1), Adj2 = \(adjStr2)")
        */
        
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        var single1 = m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false)
        NP1.appendCluster(cluster: single1)
        
        
        let NP2 = dNounPhrase()
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        var single2 = m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false)
        NP2.appendCluster(cluster: single2)
        
        let adj1 = single1 as! dAdjectiveSingle
        let adj2 = single2 as! dAdjectiveSingle
        adj1.setState(gender: .feminine, number: .singular)
        adj2.setState(gender: .masculine, number: .plural)
        let adjStr1 = adj1.getWordString()
        let adjStr2 = adj2.getWordString()
        print("Before ... Adj1 = \(adjStr1), Adj2 = \(adjStr2)")
        NP1.processInfo()
        NP2.processInfo()
        print("After processInfo ... Adj1 = \(adjStr1), Adj2 = \(adjStr2)")
        let sd1 = adj1.getWordStateData()
        let sd2 = adj2.getWordStateData()
        
        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .preposition, isSubject:false))
        PP1.appendCluster(cluster: NP2)
        
        let NP3 = dNounPhrase()
        NP3.appendCluster(cluster: NP1)
        NP3.appendCluster(cluster: PP1)
        
        return NP3
    }
    
    mutating func createSimpleVerbPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP1.processInfo()
        let VP = dVerbPhrase()
        VP.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .verb, isSubject:false))
        VP.appendCluster(cluster: NP1)
        return VP
    }
    
    mutating func createSubjectPronounVerbClause()->dIndependentClause{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .pronoun, isSubject:false))
        let VP = dVerbPhrase()
        VP.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .verb, isSubject:false))
        
        let clause = dIndependentClause(language: m_wsp.getLanguage())
        clause.appendCluster(cluster: NP1)
        clause.appendCluster(cluster: VP)
        
        clause.setHeadNounAndHeadVerb()
        
        return clause
        
    }
    
    mutating func createSimpleClause()->dIndependentClause{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP1.setPerson(value: .S3)
        NP1.processInfo()
        
        let NP2 = dNounPhrase()
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP2.setPerson(value: .S3)
        NP2.processInfo()
        
        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .preposition, isSubject:false))
        PP1.appendCluster(cluster: NP2)
        
        let NP3 = dNounPhrase()
        NP3.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP3.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP3.setPerson(value: .S3)
        NP3.processInfo()
        
        let VP = dVerbPhrase()
        VP.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .verb, isSubject:false))
        VP.appendCluster(cluster: NP3)
        VP.appendCluster(cluster: PP1)
        let clause = dIndependentClause(language: m_wsp.getLanguage())
        clause.appendCluster(cluster: NP1)
        clause.appendCluster(cluster: VP)
        
        // should be like "la hombre alto comer el perro de la casa negro"
        
        clause.setHeadNounAndHeadVerb()
        
        
        return clause
    }
    
    
    
}
