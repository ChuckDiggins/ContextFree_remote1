//
//  ContextFreePronouns.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/2/21.
//

import Foundation

//handles create templates that will guide
//  in creating sentences of various complexity of random words


enum PPFunctionType : String {
    case none = "No function"
    case subject = "Subject"
    case directObject = "Direct object phrase"
    case indirectObject = "Indirect object phrase"
    case prepositionalObject = "Prepositional object phrase"
}

struct RandomPersonalPronounPhrase {
    
    var m_wsp : WordStringParser!
    var m_randomWord : RandomWordListsForPersonalPronounGames!
    var m_rft = RandomPhraseType.simpleNounPhrase
    var m_wordList = [Word]()
    
    init (wsp : WordStringParser, rft:RandomPhraseType){
        self.m_wsp = wsp
        self.m_randomWord = RandomWordListsForPersonalPronounGames(wsp: m_wsp)
        self.m_rft = rft
    }

    mutating func setRandomPhraseType(rft: RandomPhraseType){
        m_rft = rft
    }
    
    mutating func createRandomAgnosticPronounPhrase(subject: Bool, directObject: Bool, indirectObject: Bool, prepositional: Bool)->dIndependentAgnosticClause {
        let agnosticClause = dIndependentAgnosticClause()
        
        //if subject pronoun is active, then create a noun phrase to convert into a subject pronoun
        var NP1 = dNounPhrase()
        
        //if subject requested, then a article/noun subject NP is created
        if subject {
            NP1 = createArticleNoun( functionType: .subject) as! dNounPhrase
            NP1.setClusterFunction(fn: .Subject)
        }
        //otherwise, the subject pronoun is created as a noun phrase
        else {
            let subj = m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Pronoun, functionType: .subject)
            NP1.appendCluster(cluster: subj)
            NP1.setClusterFunction(fn: .Subject)
        }
        agnosticClause.appendCluster(cluster: NP1)
        
        //create a verb phrase and append whatever comes next
        
        let VP1 = createVerbOnly()
        
        if directObject {
            let dirObj = createSimpleNounPhrase(functionType: .directObject)
            dirObj.setClusterFunction(fn: .DirectObject)
            VP1.appendCluster(cluster: dirObj)
        }
        //this needs to be an indirect object phrase -- should start with "to"/"for" ... for now
        
        if indirectObject {
            let indirObj = createSimpleIndirectObjectPhrase()
            indirObj.setClusterFunction(fn: .IndirectObject)
            VP1.appendCluster(cluster: indirObj)
        }
        
        //this needs to be an general prepositional phrase ("in the green house")
        
        if prepositional {
            let prep = createSimplePrepositionPhrase()
            prep.setClusterFunction(fn: .Prepositional)
            VP1.appendCluster(cluster:prep )
        }
        
        agnosticClause.appendCluster(cluster: VP1)
        agnosticClause.setHeadNounAndHeadVerb()
        return agnosticClause
    }
    
    mutating func createArticleNoun(functionType: PPFunctionType)->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Det, functionType: .none))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .N, functionType: functionType))
        NP1.processInfo()
        return NP1
    }
    
    mutating func createSimpleNounPhrase(functionType: PPFunctionType)->dPhrase{
        let NP1 = dNounPhrase()
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Det, functionType: .none))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .N, functionType: functionType))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Adj, functionType: .none))
        NP1.processInfo()
        return NP1
    }
    
    mutating func createVerbOnly()->dPhrase{
        let verbPhrase = dVerbPhrase()
        let vs = m_randomWord.getAgnosticRandomWordAsSingle(wordType: .V, functionType: .none)
        verbPhrase.appendCluster(cluster: vs)
        return verbPhrase
    }
    
    mutating func createSimpleIndirectObjectPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        let NP2 = dNounPhrase()
        
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Art, functionType: .none))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .N, functionType: .indirectObject))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Adj, functionType: .none))
        NP1.processInfo()

        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .P, functionType: .none))
        PP1.appendCluster(cluster: NP1)
        PP1.processInfo()
        
        //create a PP2 and attach it to PP1
        let PP2 = dPrepositionPhrase()
        PP2.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .P, functionType: .none))
        NP2.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Art, functionType: .none))
        NP2.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .N, functionType: .none))
        NP2.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Adj, functionType: .none))
        NP2.processInfo()
        PP2.appendCluster(cluster: NP2)
        PP2.processInfo()
        
        PP1.appendCluster(cluster: PP2)
        
        return PP1

    }
    mutating func createSimplePrepositionPhrase()->dPhrase{
        let NP1 = dNounPhrase()
        
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Art, functionType: .none))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .N, functionType: .prepositionalObject))
        NP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .Adj, functionType: .none))
        NP1.processInfo()
        
        let PP1 = dPrepositionPhrase()
        PP1.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: .P, functionType: .none))
        PP1.appendCluster(cluster: NP1)
        PP1.processInfo()
        return PP1
    }
}
