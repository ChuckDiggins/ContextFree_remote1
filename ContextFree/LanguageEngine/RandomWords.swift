//
//  RandomWords.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/30/21.
//

import Foundation

struct RandomWordLists{
    var m_wsp : WordStringParser?
    var m_language = LanguageType.Spanish
    var m_subjects = Array<Word>()
    var m_verbs = Array<Word>()
    var m_objects = Array<Word>()
    
    var m_articles = Array<Word>()
    var m_adjectives = Array<Word>()
    var m_prepositions = Array<Word>()
    var m_pronouns = Array<Word>()
    
    var sentenceData = Array<SentenceData>()
    
    init(wsp: WordStringParser){
        m_wsp = wsp
        m_language = wsp.getLanguage()
        createListOfSubjects()
        createListOfVerbs()
        createListOfObjects()
        createListOfArticles()
        createListOfAdjectives()
        createListOfPrepositions()
        createListOfPronouns()
    }
    
    mutating func createListOfAdjectives(){
        switch m_language {
        case .Spanish:
            for word in m_wsp!.getSpanishWords().adjectiveList{
                let adj = word as! Adjective
                if (adj.preferredPosition == .following ){m_adjectives.append(adj)}
            }
        case .English:
            for adj in m_wsp!.getEnglishWords().adjectiveList{
                m_adjectives.append(adj)
            }
        case .French:
            for word in m_wsp!.getFrenchWords().adjectiveList{
                let adj = word as! Adjective
                if (adj.preferredPosition == .following ){m_adjectives.append(adj)}
            }
        case .Italian: break
        case .Portuguese: break
        }
    }
    
    mutating func createListOfArticles(){
        switch m_language {
        case .Spanish:
            for art in m_wsp!.getSpanishWords().articleList{
                m_articles.append(art)
            }
        case .English:
            for art in m_wsp!.getEnglishWords().articleList{
                m_articles.append(art)
            }
        case .French:
            for art in m_wsp!.getFrenchWords().articleList{
                m_articles.append(art)
            }
        case .Italian: break
        case .Portuguese: break
        }
    }
    
    mutating func createListOfPrepositions(){
        switch m_language {
        case .Spanish:
            for prep in m_wsp!.getSpanishWords().prepositionList{
                m_prepositions.append(prep)
            }
        case .English:
            for prep in m_wsp!.getEnglishWords().prepositionList{
                m_prepositions.append(prep)
            }
        case .French:
            for prep in m_wsp!.getFrenchWords().prepositionList{
                m_prepositions.append(prep)
            }
        case .Italian: break
        case .Portuguese: break
        }
    }
    
    mutating func createListOfSubjects(){
        switch m_language {
        case .Spanish:
            for noun in m_wsp!.getSpanishWords().nounList{
                if (noun.type == .person || noun.type == .animal){m_subjects.append(noun)}
            }
        case .English:
            for noun in m_wsp!.getEnglishWords().nounList{
                if (noun.type == .person || noun.type == .animal){m_subjects.append(noun)}
            }
        case .French:
            for noun in m_wsp!.getFrenchWords().nounList{
                if (noun.type == .person || noun.type == .animal){m_subjects.append(noun)}
            }
        case .Italian: break
        case .Portuguese: break
        }

    }
    
    mutating func createListOfVerbs(){
        for i in 0 ..< m_wsp!.getVerbCount() {
            //get language-converted verb from dictionary
            m_verbs.append(m_wsp!.getVerbFromDictionary(language: m_language, index: i))
        }
    }
    
    mutating func createListOfObjects(){
        switch m_language {
        case .Spanish:
            for noun in m_wsp!.getSpanishWords().nounList{
                if (noun.type == .plant || noun.type == .thing || noun.type == .place){m_objects.append(noun)}
            }
        case .English:
            for noun in m_wsp!.getEnglishWords().nounList{
                if (noun.type == .plant || noun.type == .thing){m_objects.append(noun)}
            }
        case .French:
            for noun in m_wsp!.getFrenchWords().nounList{
                if (noun.type == .plant || noun.type == .thing){m_objects.append(noun)}
            }
        case .Italian: break
        case .Portuguese: break
        }
    }
    
    mutating func createListOfPronouns(){
        switch m_language {
        case .Spanish:
            for pronoun in m_wsp!.getSpanishWords().pronounList{
                let p = pronoun as! SpanishPronoun
                if (p.type == .SUBJECT ){m_pronouns.append(pronoun)}
            }
        case .English:
            for pronoun in m_wsp!.getEnglishWords().pronounList{
                let p = pronoun as! EnglishPronoun
                if (p.type == .SUBJECT ){m_pronouns.append(pronoun)}
            }
        case .French:
            for pronoun in m_wsp!.getFrenchWords().pronounList{
                let p = pronoun as! FrenchPronoun
                if (p.type == .SUBJECT ){m_pronouns.append(pronoun)}
            }
        case .Italian: break
        case .Portuguese: break
        }
    }

    
    func getRandomWordAsSingle(wordType : WordType, isSubject:Bool)->dSingle{
        var word = Word()
        var i = 0
        var single = dSingle()
        
        switch wordType{
        case .article:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            i = Int.random(in: 0 ..< m_articles.count)
            word = m_articles[i]
            wsd.word = word
            wsd.articleType = .definite
            var number = Int.random(in: 1 ..< 3)
            if ( number == 1 ) { wsd.gender = .masculine}
            else {wsd.gender = .feminine}
            wsd.gender = .masculine
            number = Int.random(in: 1 ..< 3)
            if ( number == 1 ) { wsd.number = .singular}
            else {wsd.number = .plural}
            wsd.wordType = .article
            //create a new instance of this article
            if wsd.language == .Spanish {
                let newArt = SpanishArticle()
                single = dArticleSingle(word: newArt, data: wsd)
            }
            else if wsd.language == .French {
                let newArt = FrenchArticle()
                single = dArticleSingle(word: newArt, data: wsd)
            }
        case .adjective:
            i = Int.random(in: 0 ..< m_adjectives.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_adjectives[i]
            let adj = word as! Adjective
            wsd.word = word
            wsd.adjectiveType = adj.type
            wsd.wordType = .adjective
            
            //create a new instance of this adjective

            single = dAdjectiveSingle(word: word, data: wsd)
                
        case .preposition:
            i = Int.random(in: 0 ..< m_prepositions.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_prepositions[i]
            wsd.word = word
            let prep = word as! Preposition
            wsd.prepositionType = prep.type
            wsd.wordType = .preposition
            single = dPrepositionSingle(word: word, data: wsd)
        case .noun:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            if isSubject {
                i = Int.random(in: 0 ..< m_subjects.count)
                word = m_subjects[i]
            }else{
                i = Int.random(in: 0 ..< m_objects.count)
                word = m_objects[i]
            }
            let number = Int.random(in: 1 ..< 3)
            
            if ( number == 1 ) {
                wsd.number = .singular
                wsd.person = .S3
            }
            else {
                wsd.number = .plural
                wsd.person = .P3
            }
            
            wsd.word = word
            let noun = word as! RomanceNoun
            wsd.nounType = noun.type
            wsd.gender = noun.gender
            wsd.wordType = .noun
            single = dNounSingle(word: word, data: wsd)
        case .pronoun:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            i = Int.random(in: 0 ..< m_pronouns.count)
            word = m_pronouns[i]
            wsd.word = word
            let pronoun = word as! Pronoun
            wsd.pronounType = pronoun.type
            wsd.wordType = .pronoun
            single = dSubjectPronounSingle(word: word, data: wsd)
        case .verb:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            i = Int.random(in: 0 ..< m_verbs.count)
            word = m_verbs[i]
            wsd.word = word
            let verb = word as! Verb
            wsd.verbType = verb.typeList[0]
            wsd.wordType = .verb
            switch wsd.language {
            case .Spanish:
                single = dSpanishVerbSingle(word: word, data: wsd)
            case .French: single = dFrenchVerbSingle(word: word, data: wsd)
            default: single = dVerbSingle(word: word, data: wsd)
            }
        default:
            break
        }
        
        return single
    }
    
    
}
