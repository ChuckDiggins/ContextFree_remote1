//
//  RandomWordsForPersonalPronounGames.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/2/21.
//

import Foundation

//
//  RandomWords.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/30/21.
//

import Foundation

struct RandomWordListsForPersonalPronounGames{
    var m_wsp : WordStringParser?
    var m_subjects = Array<Word>()
    var m_verbs = Array<Word>()
    var m_nouns = Array<Word>()
    var m_directObjectNouns = Array<Word>()
    var m_indirectObjectNouns = Array<Word>()
    
    var m_adverbs = Array<Word>()
    var m_conjunctions = Array<Word>()
    var m_determiners = Array<Word>()
    var m_adjectives = Array<Word>()
    var m_prepositions = Array<Word>()
    var m_pronouns = Array<Word>()
    
    var sentenceData = Array<SentenceData>()
    
    //these should work for all languages
    let bestVerbs = ["comprar",
                     "contar",
                     "dar",
                     "decir",
                     "escribir",
                     "mandar",
                     "mostrar",
                     "pedir",
                     "quitar",
                     "robar",
                     "servir",
                     "traer"]
    let bestPrepositions = ["a", "para" ]
    let bestDirectObjects = ["libro", "cuenta", "casa", "verdad", "carta", "foto", "pregunta", "comida", "regalo", "sombrero"]
    let bestIndirectObjects = ["me", "te", "niño", "niña", "fat", "les"]  //personal stuff
    
    //use proper nouns - "Bob", "Lisa", etc.
    
    
    init(wsp: WordStringParser){
        m_wsp = wsp
        createListOfPersonalPronouns() //personal nouns
        createListOfBestVerbs()  //comprar, mostrar, etc.
        createListOfBestDirectObjects()
        createListOfBestIndirectObjects()
        createListOfBestSubjects()
        //createListOfBestPrepositionalObjects()  //you, him, her, etc.
        createListOfAgnosticDeterminers()
        createListOfAgnosticAdjectives()
        createListOfAgnosticAdverbs()
        createListOfAgnosticConjunctions()
        createListOfBestPrepositions()
        createListOfPersonalPronouns()
    }
    
    mutating func createListOfAgnosticAdjectives(){
        m_adjectives.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .adjective) {
            m_adjectives.append( m_wsp!.getAgnosticWordFromDictionary(wordType:.adjective, index: i))
        }
    }
    
    mutating func createListOfAgnosticAdverbs(){
        m_adverbs.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .adverb) {
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.adverb, index: i)
            let adv = w as! Adverb
            if (adv.type == .manner || adv.type == .time){
                m_adverbs.append(w)
            }
        }
    }
    
    mutating func createListOfAgnosticConjunctions(){
        m_conjunctions.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .conjunction) {
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.conjunction, index: i)
            let conj = w as! Conjunction
            if (conj.type == .and){
                m_conjunctions.append(w)
            }
        }
    }
    

    mutating func createListOfAgnosticDeterminers(){
        m_determiners.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .determiner) {
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.determiner, index: i)
            let det = w as! Determiner
            if (det.type == .interrogative || det.type == .partative){continue}
            m_determiners.append(det)
        }
    }
    
    mutating func createListOfBestDirectObjects(){
        m_directObjectNouns.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .noun) {
            //get language-converted noun from dictionary
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.noun, index: i)
            for bv in bestDirectObjects {
                if w.spanish == bv {
                    m_directObjectNouns.append(w)
                    break
                }
            }
        }
    }
    
    //let's use only people at this point
    
    mutating func createListOfBestIndirectObjects(){
        m_indirectObjectNouns.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .noun) {
            //get language-converted noun from dictionary
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.noun, index: i)
            let noun = w as! Noun
            if (noun.nounType == .person){
                m_indirectObjectNouns.append(w)
            }
        }
    }
    
    mutating func createListOfBestSubjects(){
        m_subjects.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .noun) {
            //get language-converted noun from dictionary
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.noun, index: i)
            let noun = w as! Noun
            if (noun.nounType == .person || noun.nounType == .animal ){
                m_subjects.append(w)
            }
        }
    }

    
    mutating func createListOfPersonalPronouns(){
        m_pronouns.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .pronoun) {
            m_pronouns.append(m_wsp!.getAgnosticWordFromDictionary(wordType:.pronoun,  index: i))
        }
    }
    
    //
    mutating func createListOfBestVerbs(){
        //only accept a "best verb"
        for i in 0 ..< m_wsp!.getWordCount(wordType: .verb) {
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.verb, index: i)
            for bv in bestVerbs {
                if w.spanish == bv {
                    m_verbs.append(w)
                    break
                }
            }
        }
    }
    
    mutating func createListOfBestPrepositions(){
        m_prepositions.removeAll()
        for i in 0 ..< m_wsp!.getWordCount(wordType: .preposition) {
            let w = m_wsp!.getAgnosticWordFromDictionary(wordType:.preposition, index: i)
            for bv in bestPrepositions {
                if w.spanish == bv {
                    m_prepositions.append(w)
                    break
                }
            }
        }
    }

    func getAgnosticRandomWordAsSingle(wordType : ContextFreeSymbol, functionType: ContextFreeFunction)->dSingle{
        var word = Word()
        var i = 0
        var single = dSingle()
        
        switch wordType{
        case .Det:
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
            
            wsd.wordType = .Det
            single = dDeterminerSingle(word: word, data: wsd)
        case .Adj:
            i = Int.random(in: 0 ..< m_adjectives.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_adjectives[i]
            let adj = word as! Adjective
            wsd.word = word
            wsd.adjectiveType = adj.type
            wsd.wordType = .Adj
            single = dAdjectiveSingle(word: word, data: wsd)
        case .Adv:
            i = Int.random(in: 0 ..< m_adverbs.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_adverbs[i]
            let adv = word as! Adverb
            wsd.word = word
            wsd.adverbType = adv.type
            wsd.wordType = .Adv
            single = dAdverbSingle(word: word, data: wsd)
        case .C:
            i = Int.random(in: 0 ..< m_conjunctions.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_conjunctions[i]
            let conj = word as! Conjunction
            wsd.word = word
            wsd.conjunctionType = conj.type
            wsd.wordType = .C
            single = dConjunctionSingle(word: word, data: wsd)
        case .P:
            i = Int.random(in: 0 ..< m_prepositions.count)
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            word = m_prepositions[i]
            wsd.word = word
            let prep = word as! Preposition
            wsd.prepositionType = prep.type
            wsd.wordType = .P
            single = dPrepositionSingle(word: word, data: wsd)
        case .N:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            switch functionType{
            case .Subject:
                i = Int.random(in: 0 ..< m_subjects.count)
                word = m_subjects[i]
            case .DirectObject:
                i = Int.random(in: 0 ..< m_directObjectNouns.count)
                word = m_directObjectNouns[i]
            case .IndirectObject, .None:
                i = Int.random(in: 0 ..< m_subjects.count)
                word = m_subjects[i]
            case .Prepositional:
                i = Int.random(in: 0 ..< m_directObjectNouns.count)
                word = m_directObjectNouns[i]
            default:
                break
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
            wsd.wordType = .N
            single = dNounSingle(word: word, data: wsd)
            let ns = single as! dNounSingle
            if functionType == .Subject {ns.setIsSubject(flag: true)}
        case .Pronoun:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            if functionType == .Subject {
                for i in 0 ..< m_pronouns.count{
                    word = m_pronouns[i]
                    wsd.word = word
                    wsd.wordType = .Pronoun
                    wsd.pronounType = .SUBJECT
                    let personIndex = Int.random(in: 0 ..< 6)
                    wsd.person = Person.all[personIndex]
                    let genderIndex = Int.random(in: 0 ..< 2)
                    wsd.gender = Gender.all[genderIndex]
                    single = dPersonalPronounSingle(word: word, data: wsd)
                }
            }
            else if functionType == .IndirectObject {
                for i in 0 ..< m_pronouns.count{
                    word = m_pronouns[i]
                    wsd.word = word
                    wsd.wordType = .Pronoun
                    wsd.pronounType = .INDIRECT_OBJECT
                    let personIndex = Int.random(in: 0 ..< 6)
                    wsd.person = Person.all[personIndex]
                    let genderIndex = Int.random(in: 0 ..< 2)
                    wsd.gender = Gender.all[genderIndex]
                    single = dPersonalPronounSingle(word: word, data: wsd)
                }
            }
        case .V:
            let wsd = WordStateData()
            wsd.language = m_wsp!.getLanguage()
            i = Int.random(in: 0 ..< m_verbs.count)
            word = m_verbs[i]
            wsd.word = word
            let verb = word as! Verb
            wsd.verbType = verb.typeList[0]
            wsd.wordType = .V
            single = dVerbSingle(word: word, data: wsd)
        default:
            break
        }
        
        single.setClusterFunction(fn: functionType)
        return single
    }
    

}
