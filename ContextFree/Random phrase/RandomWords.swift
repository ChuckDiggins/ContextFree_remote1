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
    var m_nouns = Array<Word>()
    var m_objects = Array<Word>()
    
    var m_determiners = Array<Word>()
    var m_adjectives = Array<Word>()
    var m_prepositions = Array<Word>()
    var m_pronouns = Array<Word>()
    
    var sentenceData = Array<SentenceData>()
    
    init(wsp: WordStringParser){
        m_wsp = wsp
        m_language = wsp.getLanguage()
        createListOfAgnosticSubjects()
        createListOfAgnosticVerbs()
        createListOfAgnosticObjects()
        createListOfAgnosticDeterminers()
        createListOfAgnosticAdjectives()
        createListOfAgnosticPrepositions()
        createListOfPronouns()
    }
    
    mutating func createListOfAgnosticAdjectives(){
        m_adjectives.removeAll()
        for i in 0 ..< m_wsp!.getAdjectiveCount() {
            m_adjectives.append( m_wsp!.getAgnosticWordFromDictionary(wordType:.adjective, index: i))
        }
    }
    
    mutating func createListOfAgnosticDeterminers(){
        m_determiners.removeAll()
        for i in 0 ..< m_wsp!.getDeterminerCount() {
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.determiner, index: i)
            let det = w as! Determiner
            if (det.type == .interrogative || det.type == .partative){continue}
            m_determiners.append(det)
        }
    }
    
    mutating func createListOfAgnosticSubjects(){
        m_subjects.removeAll()
        for i in 0 ..< m_wsp!.getNounCount() {
            //get language-converted noun from dictionary
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.noun, index: i)
            let noun = w as! Noun
            if (noun.nounType == .person || noun.nounType == .animal ){
                m_subjects.append(w)
            }
        }
    }
    
    mutating func createListOfAgnosticObjects(){
        m_objects.removeAll()
        for i in 0 ..< m_wsp!.getNounCount() {
            //get language-converted noun from dictionary
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.noun, index: i)
            let noun = w as! Noun
            if (noun.nounType == .plant || noun.nounType == .thing || noun.nounType == .place){
                m_objects.append(noun)
            }
        }
    }
    
    
    mutating func createListOfAgnosticVerbs(){
        for i in 0 ..< m_wsp!.getVerbCount() {
            m_verbs.append(m_wsp!.getAgnosticWordFromDictionary(wordType:.verb, index: i))
        }
    }
    
    mutating func createListOfAgnosticPrepositions(){
        m_prepositions.removeAll()
        for i in 0 ..< m_wsp!.getPrepositionCount() {
            //get language-converted noun from dictionary
            m_prepositions.append(m_wsp!.getAgnosticWordFromDictionary(wordType:.preposition,  index: i))
        }
    }
    
    
    mutating func createListOfAdjectives(){
        m_adjectives.removeAll()
        for i in 0 ..< m_wsp!.getAdjectiveCount() {
            //get language-converted noun from dictionary
            let adj = m_wsp!.getAdjectiveFromDictionary(language: m_language, index: i)
            switch m_language {
            case .Spanish:
                let sa = adj as! SpanishAdjective
                sa.createOtherForms()
            case .French:
                let sa = adj as! FrenchAdjective
                sa.createOtherForms()
                print("createListOfAdjectives: sa.plural = \(sa.plural)")
            case .English, .Italian, .Portuguese, .Agnostic:
                break
            }
            m_adjectives.append(adj)
        }
    }
    
   
    mutating func createListOfPronouns(){
        m_pronouns.removeAll()
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
        case .Agnostic: break
        }
    }


    func getAgnosticRandomWordAsSingle(wordType : WordType, isSubject:Bool)->dSingle{
        var word = Word()
        var i = 0
        var single = dSingle()
        
        switch wordType{
        
        case .ambiguous:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            i = Int.random(in: 0 ..< m_determiners.count)
            word = m_determiners[i]
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
            else if wsd.language == .English {
                let newArt = EnglishArticle(word: word.word, def: "", type: .definite)
                single = dArticleSingle(word: newArt, data: wsd)
            }
        case .determiner:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            i = Int.random(in: 0 ..< m_determiners.count)
            word = m_determiners[i]
            let det = word as! Determiner
            wsd.word = word
            wsd.determinerType = det.type
            
            //gender and number will be reconciled to their associated noun, but set them anyway
            var number = Int.random(in: 1 ..< 3)
            if ( number == 1 ) { wsd.gender = .masculine}
            else {wsd.gender = .feminine}
            wsd.gender = .masculine
            number = Int.random(in: 1 ..< 3)
            if ( number == 1 ) { wsd.number = .singular}
            else {wsd.number = .plural}
            
            wsd.wordType = .determiner
            single = dDeterminerSingle(word: word, data: wsd)
        case .adjective:
            i = Int.random(in: 0 ..< m_adjectives.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_adjectives[i]
            let adj = word as! Adjective
            wsd.word = word
            wsd.adjectiveType = adj.type
            wsd.wordType = .adjective
            
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
            let noun = word as! Noun
            wsd.gender = noun.spanishGender
            wsd.nounType = noun.nounType
            
            
            wsd.wordType = .noun
            single = dNounSingle(word: word, data: wsd)
            let ns = single as! dNounSingle
            ns.setIsSubject(flag: isSubject)
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
            single = dVerbSingle(word: word, data: wsd)
        default:
            break
        }
        
        return single
    }
    

}

/*
func getRandomWordAsSingle(wordType : WordType, isSubject:Bool)->dSingle{
    var word = Word()
    var i = 0
    var single = dSingle()
    
    switch wordType{
case .ambiguous:   //article
        let wsd = WordStateData()
        wsd.language = m_wsp!.getLanguage()
        i = Int.random(in: 0 ..< m_determiners.count)
        word = m_determiners[i]
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
        single = dArticleSingle(word: word, data: wsd)
        
        create a new instance of this article
        if wsd.language == .Spanish {
            let newArt = SpanishArticle()
            single = dArticleSingle(word: newArt, data: wsd)
        }
        else if wsd.language == .French {
            let newArt = FrenchArticle()
            single = dArticleSingle(word: newArt, data: wsd)
        }
        else if wsd.language == .English {
            let newArt = EnglishArticle(word: word.word, def: "", type: .definite)
            single = dArticleSingle(word: newArt, data: wsd)
        }

    case .determiner:
        let wsd = WordStateData()
        wsd.language = m_wsp!.getLanguage()
        i = Int.random(in: 0 ..< m_determiners.count)
        word = m_determiners[i]
        wsd.word = word
        wsd.determinerType = .definite
        var number = Int.random(in: 1 ..< 3)
        if ( number == 1 ) { wsd.gender = .masculine}
        else {wsd.gender = .feminine}
        wsd.gender = .masculine
        number = Int.random(in: 1 ..< 3)
        if ( number == 1 ) { wsd.number = .singular}
        else {wsd.number = .plural}
        wsd.wordType = .determiner
        single = dDeterminerSingle(word: word, data: wsd)

    case .adjective:
        i = Int.random(in: 0 ..< m_adjectives.count)
        let wsd = WordStateData()
        wsd.language = m_wsp!.getLanguage()
        word = m_adjectives[i]
        let adj = word as! Adjective
        wsd.word = word
        wsd.adjectiveType = adj.type
        wsd.wordType = .adjective
        
        //create a new instance of this adjective single

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
        
        //for testing
        //word = m_subjects[0]
        
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
        let noun = word as! Noun  //set the sentenceData gender
        wsd.gender = noun.spanishGender
        wsd.nounType = noun.nounType

        print("getRandomWordAsSingle: new noun: \(wsd.word.word)")
        
        wsd.wordType = .noun
        single = dNounSingle(word: word, data: wsd)
        let ns = single as! dNounSingle
        ns.setIsSubject(flag: isSubject)
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
        single = dVerbSingle(word: word, data: wsd)
        
     switch wsd.language {
        case .Spanish:
            single = dSpanishVerbSingle(word: word, data: wsd)
        case .French: single = dFrenchVerbSingle(word: word, data: wsd)
        case .English: single = dVerbSingle(word: word, data: wsd)
        default: single = dVerbSingle(word: word, data: wsd)
        }

    default:
        break
    }
    
    return single
}
 */
