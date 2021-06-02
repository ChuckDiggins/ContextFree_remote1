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
            for adj in m_wsp!.getSpanishWords().adjectiveList{
                m_adjectives.append(adj)
            }
        case .English:
            for adj in m_wsp!.getEnglishWords().adjectiveList{
                m_adjectives.append(adj)
            }
        case .French:
            for adj in m_wsp!.getFrenchWords().adjectiveList{
                m_adjectives.append(adj)
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
        switch m_language {
        case .Spanish:
            for verb in m_wsp!.getSpanishWords().verbList{
                //let sv = verb as! SpanishVerb
                m_verbs.append(verb)
            }
        case .English:
            for verb in m_wsp!.getEnglishWords().verbList{
                let sv = verb as! EnglishVerb
                if (sv.type == .normal ){m_verbs.append(verb)}
            }
        case .French:
            for verb in m_wsp!.getFrenchWords().verbList{
                let sv = verb as! FrenchVerb
                if (sv.type == .normal ){m_verbs.append(verb)}
            }
        case .Italian: break
        case .Portuguese: break
        }

    }
    
    mutating func createListOfObjects(){
        switch m_language {
        case .Spanish:
            for noun in m_wsp!.getSpanishWords().nounList{
                if (noun.type == .plant || noun.type == .thing){m_objects.append(noun)}
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
        var wsd = WordStateData()
        wsd.language = m_wsp!.getLanguage()
        switch wordType{
        case .article:
            i = Int.random(in: 0 ..< m_articles.count)
            word = m_articles[i]
            wsd.articleType = .definite
            wsd.gender = .masculine
            wsd.number = .singular
            single = dArticleSingle(word: word, data: wsd)
        case .adjective:
            i = Int.random(in: 0 ..< m_adjectives.count)
            word = m_adjectives[i]
            let adj = word as! Adjective
            wsd.adjectiveType = adj.type
            single = dAdjectiveSingle(word: word, data: wsd)
        case .preposition:
            i = Int.random(in: 0 ..< m_prepositions.count)
            word = m_prepositions[i]
            let prep = word as! Preposition
            wsd.prepositionType = prep.type
            single = dPrepositionSingle(word: word, data: wsd)
        case .noun:
            if isSubject {
                i = Int.random(in: 0 ..< m_subjects.count)
                word = m_subjects[i]
            }else{
                i = Int.random(in: 0 ..< m_objects.count)
                word = m_objects[i]
            }
            let noun = word as! RomanceNoun
            wsd.nounType = noun.type
            wsd.gender = noun.gender
            single = dNounSingle(word: word, data: wsd)
        case .pronoun:
            i = Int.random(in: 0 ..< m_pronouns.count)
            word = m_pronouns[i]
            let pronoun = word as! Pronoun
            wsd.pronounType = pronoun.type
            single = dSubjectPronounSingle(word: word, data: wsd)
        case .verb:
            i = Int.random(in: 0 ..< m_verbs.count)
            word = m_verbs[i]
            let verb = word as! Verb
            wsd.verbType = verb.type
            single = dVerbSingle(word: word, data: wsd)
        default:
            break
        }
        
        return single
    }
    
    func getRandomWordAsSingleA(wordType : WordType, inWsd: WordStateData)->dSingle{
        var word = Word()
        var i = 0
        var single = dSingle()
        var wsd = inWsd
        switch wordType{
        case .article:
            i = Int.random(in: 0 ..< m_articles.count)
            word = m_articles[i]
            wsd.articleType = .definite
            wsd.gender = .masculine
            wsd.number = .singular
            single = dArticleSingle(word: word, data: wsd)
        case .adjective:
            i = Int.random(in: 0 ..< m_adjectives.count)
            word = m_adjectives[i]
            let adj = word as! Adjective
            wsd.adjectiveType = adj.type
            single = dAdjectiveSingle(word: word, data: wsd)
        case .preposition:
            i = Int.random(in: 0 ..< m_prepositions.count)
            word = m_prepositions[i]
            let prep = word as! Preposition
            wsd.prepositionType = prep.type
            single = dPrepositionSingle(word: word, data: wsd)
        case .noun:
            i = Int.random(in: 0 ..< m_objects.count)
            word = m_objects[i]
            let noun = word as! Noun
            wsd.nounType = noun.type
            single = dNounSingle(word: word, data: wsd)
        case .pronoun:
            i = Int.random(in: 0 ..< m_pronouns.count)
            word = m_pronouns[i]
            let pronoun = word as! Pronoun
            wsd.pronounType = pronoun.type
            single = dSubjectPronounSingle(word: word, data: wsd)
        case .verb:
            i = Int.random(in: 0 ..< m_verbs.count)
            word = m_verbs[i]
            let verb = word as! Verb
            wsd.verbType = verb.type
            single = dVerbSingle(word: word, data: wsd)
        default:
            break
        }
        
        return single
    }
    
}
