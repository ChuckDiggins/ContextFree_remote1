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
    case subjectPronounVerb
    case simpleNoun
    case simplePreposition
    case simpleVerb
    case complexNoun
    case simpleClause
    case simpleAdjectiveRegular
    case simpleAdjectivePossessive
    case simpleAdjectiveInterrogative
    case simpleAdjectiveDemonstrative
}

struct RandomSentence {
    var m_wsp : WordStringParser!
    var m_randomWord : RandomWordLists!
    var m_rft = RandomPhraseType.simpleNoun
    
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
        case .simpleAdjectiveRegular:
            phrase = createSimpleNounPhrase()
        case .simpleAdjectivePossessive:
            phrase = createSimpleNounPhrase()
        case .simpleAdjectiveInterrogative:
            phrase = createSimpleNounPhrase()
        case .simpleAdjectiveDemonstrative:
            phrase = createSimpleNounPhrase()
        case .simpleNoun:
            phrase = createSimpleNounPhrase()
        case .simplePreposition:
            phrase = createSimplePrepositionPhrase()
        case .simpleVerb:
            phrase = createSimpleVerbPhrase()
        case .complexNoun:
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
    
    mutating func createSimpleNounPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        return NP1
    }
    
    mutating func createSimplePrepositionPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .preposition, isSubject:false))
        PP1.appendCluster(cluster: NP1)
        return PP1
    }
    
    mutating func createComplexNounPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:true))
        NP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))

        let NP2 = dNounPhrase()
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        
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
        NP1.setNumber(value: .singular)
        NP1.setPerson(value: .S3)
        NP1.processInfo()
        
        let NP2 = dNounPhrase()
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP2.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .adjective, isSubject:false))
        NP2.setNumber(value: .singular)
        NP2.setPerson(value: .S3)
        NP2.processInfo()
        
        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .preposition, isSubject:false))
        PP1.appendCluster(cluster: NP2)
        
        let NP3 = dNounPhrase()
        NP3.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .article, isSubject:false))
        NP3.appendCluster(cluster: m_randomWord.getRandomWordAsSingle(wordType: .noun, isSubject:false))
        NP3.setNumber(value: .singular)
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
