//
//  JSONstuff.swift
//  JSONstuff
//
//  Created by Charles Diggins on 9/14/21.
//

import Foundation


struct JSONDictionaryManager {

    var m_wsp : WordStringParser!
    
    var jsonVerbManager = JsonVerbManager()
    var jsonNounManager = JsonNounManager()
    var jsonAdjectiveManager = JsonAdjectiveManager()
    var jsonAdverbManager = JsonAdverbManager()
    var jsonConjunctionManager = JsonConjunctionManager()
    var jsonDeterminerManager = JsonDeterminerManager()
    var jsonPrepositionManager = JsonPrepositionManager()
    var jsonPronounManager = JsonPronounManager()
//    var jsonPhraseManager = JsonPhraseManager()
//    var jsonClauseManager = JsonClauseManager()
    let bUseJsonStarterFiles = true
    var verbModelManager = VerbModelManager()
    var jsonWordCollection = JSONWordCollection()
    var jsonWordCollectionManager = JSONCollectionManager()
    
    
    mutating func setWordStringParser(wsp: WordStringParser){
        m_wsp = wsp
    }
    
    mutating func loadJsonWords(){
        if bUseJsonStarterFiles {
            //jsonNounManager.encodeWords()  //this should wipe out existing jsonVerbs
            jsonNounManager.encodeInternalWords(collectionType: .All, total: 2000)
            
            //jsonVerbManager.encodeVerbs()  //this should wipe out existing jsonVerbs
            jsonVerbManager.encodeInternalVerbs(collectionType: .All, total: 2000)
            jsonAdjectiveManager.encodeInternalWords(collectionType: .All, total: 2000)
            jsonPrepositionManager.encodeInternalWords(collectionType: .All, total: 2000)
            jsonAdverbManager.encodeInternalWords(collectionType: .All, total: 2000)
            jsonConjunctionManager.encodeInternalWords(total: 2000)
            jsonDeterminerManager.encodeInternalWords(total: 2000)
            jsonPronounManager.encodeInternalWords(total: 2000)
           
            
        }
        jsonVerbManager.decodeVerbs()
        createDictionaryFromJsonWords(wordType: .verb)
        
        jsonNounManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .noun)
        
        jsonAdjectiveManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .adjective)
        
        jsonPrepositionManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .preposition)
        
        jsonDeterminerManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .determiner)
        
        jsonAdverbManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .adverb)
        
        jsonConjunctionManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .conjunction)
        
        jsonPronounManager.decodeWords()
        createDictionaryFromJsonWords(wordType: .pronoun)
        
        jsonWordCollectionManager.encodeWordCollections(total: 2000)
        createWordCollectionsFromJsonWordCollectionManager()
    }
    
//    mutating func loadJsonWordCollections()->dWordCollectionManager{
////        jsonWordCollection.decodeWords()
////        createWordGroupFromJsonWordCollection()
////        if bUseJsonStarterFiles {
////            jsonWordCollection.encodeInternalWords(total: 2000)
////        }
//
//        //encodes the already existing word collections
//        if bUseJsonStarterFiles {
//            jsonWordCollectionManager.encodeWordCollections(total: 2000)
//        }
//
//        //decodes and parses existing json word collections
//        let wordCollections = jsonWordCollectionManager.getWordCollections()
//        print("jsonWordCollectionManager.getWordCollections returned \(wordCollections.count)")
//        return createWordCollectionsFromJsonWordCollectionManager()
//    }
    
    func getExistingWord(jsonWord: JSONWord)->Word{
        let word = jsonWord.getWord()
        return m_wsp.findWordInDictionary(word: word)
    }
    
    mutating func createWordCollectionsFromJsonWordCollectionManager(){
        
        for i in 0 ..< jsonWordCollectionManager.getCollectionCount() {
            var wordList = [Word]()
            let jsonCollectionStruct = jsonWordCollectionManager.getJSONCollectionAt(index: i)
            for jsonWord in jsonCollectionStruct.wordList {
                let word = jsonWord.getWord()
                let existingWord = m_wsp.findWordInDictionary(word: word)
                if !existingWord.word.isEmpty {
//                    print("Matched:  jsonWord \(jsonWord.wordType): \(jsonWord.spanish) - \(jsonWord.french) - \(jsonWord.english)")
                    wordList.append(existingWord)
                } else {
//                    print("Not matched: jsonWord \(jsonWord.wordType): \(jsonWord.spanish) - \(jsonWord.french) - \(jsonWord.english)")
                }
            }
            let jlingWordCollection = dWordCollection(idNum: jsonCollectionStruct.idNum,
                                                          collectionName: jsonCollectionStruct.collectionName,
                                                          wordList: wordList)
//            print("createWordCollectionsFromJsonWordCollectionManager:  appending collection \(jlingWordCollection.collectionName), word count = \(wordList.count)")
            m_wsp.wordCollectionManager.append(collection: jlingWordCollection)
        }
        
//        print("createWordCollectionsFromJsonWordCollectionManager: jsonCollectionCount\(jsonWordCollectionManager.getCollectionCount())")
//        print("createWordCollectionsFromJsonWordCollectionManager: wordCollectionManager collection count =\(wcm.getCount())")
    }
      
    //use json-constructed word to find the existing word in the dictionaries
    
    mutating func createWordGroupFromJsonWordCollection(){
        for i in 0 ..< jsonWordCollection.getWordCount() {
            let jsonWord = jsonWordCollection.getWordAt(index: i)
            let existingWord = m_wsp.findWordInDictionary(word: jsonWord)
            if !existingWord.word.isEmpty {
//                print("Matched:  jsonWord \(jsonWord.wordType): \(jsonWord.spanish) - \(jsonWord.french) - \(jsonWord.english)")
                m_wsp.addWordToWorkingDictionary(wd: existingWord)
            } else {
//                print("Not matched: jsonWord \(jsonWord.wordType): \(jsonWord.spanish) - \(jsonWord.french) - \(jsonWord.english)")
                }
        }
        print("Working noun count = \(m_wsp.getWorkingListOfType(wordType: .noun).count)")
        print("Working verb count = \(m_wsp.getWorkingListOfType(wordType: .verb).count)")
        print("Working adverb count = \(m_wsp.getWorkingListOfType(wordType: .adverb).count)")
        print("Working adjective count = \(m_wsp.getWorkingListOfType(wordType: .adjective).count)")
        print("Working preposition count = \(m_wsp.getWorkingListOfType(wordType: .preposition).count)")
        print("createWordGroupFromJsonWordCollection: working word count =\(m_wsp.getWorkingList().count)")
    }
      
    
    
    mutating func createDictionaryFromJsonWords(wordType: WordType){
        switch wordType{
        case .adjective:
            for i in 0 ..< jsonAdjectiveManager.getWordCount() {
                let jsonWord = jsonAdjectiveManager.getWordAt(index: i)
                createAndAppendAdjectiveFromJsonAdjective(jn: jsonWord)
            }
        case .adverb:
            for i in 0 ..< jsonAdverbManager.getWordCount() {
                let jsonWord = jsonAdverbManager.getWordAt(index: i)
                createAndAppendAdverbFromJsonAdverb(jn: jsonWord)
            }
        case .conjunction:
            for i in 0 ..< jsonConjunctionManager.getWordCount() {
                let jsonWord = jsonConjunctionManager.getWordAt(index: i)
                createAndAppendConjunctionFromJsonConjunction(jn: jsonWord)
            }
        case .determiner:
            for i in 0 ..< jsonDeterminerManager.getWordCount() {
                let jsonWord = jsonDeterminerManager.getWordAt(index: i)
                createAndAppendDeterminerFromJsonDeterminer(jn: jsonWord)
            }
        case .noun:
            for i in 0 ..< jsonNounManager.getWordCount() {
                let jsonWord = jsonNounManager.getWordAt(index: i)
                createAndAppendNounFromJsonNoun(jn: jsonWord)
            }
        case .preposition:
            for i in 0 ..< jsonPrepositionManager.getWordCount() {
                let jsonWord = jsonPrepositionManager.getWordAt(index: i)
                createAndAppendPrepositionFromJsonPreposition(jn: jsonWord)
            }
        case .pronoun:
            for i in 0 ..< jsonPronounManager.getWordCount() {
                let jsonWord = jsonPronounManager.getWordAt(index: i)
                createAndAppendPronounFromJsonPronoun(jn: jsonWord)
            }
        case .verb:
            for i in 0 ..< jsonVerbManager.getVerbCount() {
                let jsonWord = jsonVerbManager.getVerbAt(index: i)
                createAndAppendVerbFromJsonVerb(jv: jsonWord)
            }
        default:
            break
        }
    }
    
//    mutating func createAndAppendAgnosticWordFromJsonWord(jn: JSONWord){
//        var wordType = WordType.ambiguous
//        switch jn.wordType {
//        case "noun": wordType = WordType.noun
//        case "verb": wordType = WordType.verb
//        case "adjective": wordType = WordType.adjective
//        case "adverb": wordType = WordType.adverb
//        case "preposition": wordType = WordType.preposition
//        case "conjunction": wordType = WordType.conjunction
//        default: break
//        }
//        let word = Word(word: jn.english, spanish: jn.spanish, french: jn.french, english: jn.english, wordType: wordType)
//        m_wsp.addNounToDictionary(noun: noun)
//    }

    mutating func createAndAppendNounFromJsonNoun(jn: JsonNoun){
        let noun = Noun(jsonNoun: jn, language: .Agnostic)
        m_wsp.addNounToDictionary(noun: noun)
    }
    
    mutating func createAndAppendAdjectiveFromJsonAdjective(jn: JsonAdjective){
        let adj = Adjective(jsonAdjective: jn, language: .Agnostic)
        m_wsp.addAdjectiveToDictionary(adj: adj)
    }
    
    mutating func createAndAppendAdverbFromJsonAdverb(jn: JsonAdverb){
        let adv = Adverb(json: jn, language: .Agnostic)
        m_wsp.addAdverbToDictionary(wd: adv)
    }
    
    mutating func createAndAppendPrepositionFromJsonPreposition(jn: JsonPreposition){
        let p = Preposition(json: jn, language: .Agnostic)
        m_wsp.addPrepositionToDictionary(wd: p)

    }
    
    mutating func createAndAppendPronounFromJsonPronoun(jn: JsonPronoun){
        let p = Pronoun(json: jn, language: .Agnostic)
        m_wsp.addPronounToDictionary(wd: p)
        
    }
    
    mutating func createAndAppendConjunctionFromJsonConjunction(jn: JsonConjunction){
        let wd = Conjunction(json: jn, language: .Agnostic)
        m_wsp.addConjuctionToDictionary(wd: wd)
        
    }
    
    mutating func createAndAppendDeterminerFromJsonDeterminer(jn: JsonDeterminer){
        let p = Determiner(json: jn, language: .Agnostic)
        m_wsp.addDeterminerToDictionary(wd: p)
    }
    
    mutating func createJsonNoun(noun: Noun){
        appendJsonNoun(jsonNoun: noun.createJsonNoun())
    }
    
    mutating func appendJsonNoun(jsonNoun: JsonNoun){
        jsonNounManager.appendWord(verb: jsonNoun)
        createAndAppendNounFromJsonNoun(jn: jsonNoun)
    }
    
    mutating func createJsonVerb(verb: Verb)->Int{
        return appendJsonVerb(jsonVerb: verb.createJsonVerb())
    }
    
    mutating func appendJsonVerb(jsonVerb: JsonVerb)->Int{
        jsonVerbManager.appendVerb(verb: jsonVerb)
        createAndAppendVerbFromJsonVerb(jv: jsonVerb)
        jsonVerbManager.printVerbs()
        return jsonVerbManager.getVerbCount()
    }
    
    mutating func createVerbDictionaryFromJsonVerbs(){
        for i in 0 ..< jsonVerbManager.getVerbCount() {
            let jsonVerb = jsonVerbManager.getVerbAt(index: i)
            createAndAppendVerbFromJsonVerb(jv: jsonVerb)
        }
    }
    
    mutating func createAndAppendVerbFromJsonVerb(jv: JsonVerb){
        //var cfModelTemp = cfModel
        
        //determine if this is a legitimate verb in all three languages
        
       let spanishVerbStuff = verbModelManager.analyzeAndCreateBVerb_SPIFE(language: .Spanish, verbPhrase: jv.spanish)
       let frenchVerbStuff = verbModelManager.analyzeAndCreateBVerb_SPIFE(language: .French, verbPhrase: jv.french)
       let englishVerbStuff = verbModelManager.analyzeAndCreateBVerb_SPIFE(language: .English, verbPhrase: jv.english)
       if ( spanishVerbStuff.isValid && frenchVerbStuff.isValid && englishVerbStuff.isValid){
            let verb = Verb(jsonVerb: jv, language: .Agnostic)
            m_wsp.addVerbToDictionary(verb: verb)
       }
    }

    
    func appendAgnosticWord(wordType: WordType, spanishWord : String, frenchWord : String, englishWord: String){
        
    }
    
    func analyzeAgnosticWord(wordType: WordType, spanishWord : String, frenchWord : String, englishWord: String)->Bool {
        return true
    }
}

