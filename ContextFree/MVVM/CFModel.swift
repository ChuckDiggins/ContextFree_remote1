//
//  CFDriver.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation
import JumpLinguaHelpers

//this is where every little thing is constructed

struct CFModel{
    
    var grammarLibrary = CFGrammarLibrary()
    var frenchGrammarLibrary = GnosticGrammarLibrary(language: .French)
    var spanishGrammarLibrary = GnosticGrammarLibrary(language: .Spanish)
    var englishGrammarLibrary = GnosticGrammarLibrary(language: .English)
    
  
    var m_currentLanguage : LanguageType
    
    var tenseManager = TenseManager()
    
    private var m_disambiguation = Disambiguation()
    private var m_tenseList = Array<Tense>()

    private var currentTenseString : String = ""
    private var currentVerbPhrase : String = ""
    private var preposition : String = ""
    private var currentTense : Tense = .present
    private var m_currentPerson : Person = .S1

    private var bReconstructVerbModels = false
    private var bUseJsonStarterFiles = false   //this will reconstruct json words from user-supplied files, any other words will be lost
    private var m_randomSentence : RandomSentence!
    private var m_randomWordLists : RandomWordLists!

    var m_wsp : WordStringParser!
    
    var jsonPhraseManager = JsonPhraseManager()
    var jsonBundleManager = JSONBundleManager()
    var jsonClauseManager = JsonClauseManager()
    var jsonWordCollectionManager = JSONCollectionManager()
    var m_jsonDictionaryManager = JSONDictionaryManager()
    
    var phraseManager = dPhraseManager()
    var bundleManager = dBundleManager()
    var m_spanishVerbModelConjugation = RomanceVerbModelConjugation()
    var m_frenchVerbModelConjugation = RomanceVerbModelConjugation()
    var m_englishVerbModelConjugation = EnglishVerbModelConjugation()
    
    var m_currentTenseIndex = 0
    
    var m_verbModelManager = VerbModelManager()
    
    init(language: LanguageType){
        m_currentLanguage = language
        
        m_spanishVerbModelConjugation.setLanguage(language: .Spanish)
        m_frenchVerbModelConjugation.setLanguage(language: .French)
        m_wsp = WordStringParser(language:m_currentLanguage,
                                 span:m_spanishVerbModelConjugation,
                                 french:m_frenchVerbModelConjugation,
                                 english: m_englishVerbModelConjugation)
        
        m_disambiguation.setWordStringParser(wsp: m_wsp)
        createVerbModels()
        buildSomeStuff()
        m_tenseList = tenseManager.getActiveTenseList()
        
        m_jsonDictionaryManager.setWordStringParser(wsp: m_wsp)
        m_jsonDictionaryManager.loadJsonWords()
        m_wsp.getWordCounts()
        
        //loadJsonWords()
        
        m_randomWordLists = RandomWordLists(wsp: m_wsp)
        m_randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleClause)

        loadJsonPhrasesAndClauses()
        loadJsonBundles()
    }

    func getRandomWordLists()->RandomWordLists{
        return m_randomWordLists
    }

    func getWordStringParser()->WordStringParser{
        return m_wsp
    }
    
    mutating func getVerbModel(language: LanguageType)->VerbModelConjugation{
        switch language{
        case .Spanish: return m_spanishVerbModelConjugation
        case .French: return m_frenchVerbModelConjugation
        case .English: return m_englishVerbModelConjugation
        default: return RomanceVerbModelConjugation()
        }
    }
    
    mutating func createVerbModels(){
        //this will recreate the json verbs if they need recreating
        
        if bReconstructVerbModels {
            m_spanishVerbModelConjugation.createVerbModels(mode: .both)
            m_spanishVerbModelConjugation.createVerbModels(mode: .json)
            m_frenchVerbModelConjugation.createVerbModels(mode: .both)
            m_frenchVerbModelConjugation.createVerbModels(mode: .json)
            m_englishVerbModelConjugation.createVerbModels()
        }
        else {
            m_spanishVerbModelConjugation.createVerbModels(mode: .json)
            m_frenchVerbModelConjugation.createVerbModels(mode: .json)
            m_englishVerbModelConjugation.createVerbModels()
        }
    }
    
    mutating func loadJsonPhrasesAndClauses(){
//        if bUseJsonStarterFiles {
            jsonPhraseManager.encodeInternalPhrases(total: 2000)
//        }
        createPhrasesFromJsonPhrases()
        print("phraseManager phrase count = \(phraseManager.getClusterCount())")
    }
    mutating func loadJsonBundles(){
        //if bUseJsonStarterFiles {
            jsonBundleManager.encodeBundles(total: 2000)
        //}
        createBundlesFromJsonBundles()
        print("bundleManager bundle count = \(bundleManager.getBundleCount())")
    }

    mutating func createBundlesFromJsonBundles(){
        for jsonBundle in jsonBundleManager.myBundleList {
            let bundleName = jsonBundle.bundleName
            let idNum = jsonBundle.idNum
            let teacher = jsonBundle.teacher
            var tenseList = [Tense]()
            for str in jsonBundle.tenseList{
                let tense = getTenseFromString(str: str)
                tenseList.append(tense)
            }
            //look for phrases in phraseManager
            
            var phraseList = [dCluster]()
            for jsonPhrase in jsonBundle.phraseList{
                let name = jsonPhrase.phraseName
                let phrase = phraseManager.getClusterByName(clusterName: name)
                phraseList.append(phrase)
            }
            var wordCollectionList = [dWordCollection]()
            for jsonCollection in jsonBundle.collectionList{
                let name = jsonCollection.collectionName
                let collection = m_wsp.wordCollectionManager.getCollectionByName(collectionName: name)
                wordCollectionList.append(collection)
            }
            let bundle = dBundle(idNum: idNum, teacher: teacher, bundleName: bundleName, tenseList: tenseList, collectionList: wordCollectionList, phraseList: phraseList)
            bundleManager.appendBundle(bundle: bundle)
        }
    }

    mutating func createPhraseFromJsonPhrase(jsonPhrase: JSONNamedLoadedPhrase)->dCluster{
    let clusterType = getClusterTypeFromString(str: jsonPhrase.phraseType)
        let np = dPhrase(randomWord: m_randomWordLists!, phraseName: jsonPhrase.phraseName, phraseType: clusterType)
        //rebuild all of the member clusters from the jsonPhrase cluster list
        for jsonCluster in jsonPhrase.clusterList {
            np.appendCluster(cluster: m_randomWordLists.getAgnosticRandomWordAsSingle(wordType: getClusterTypeFromString(str: jsonCluster.wordType), isSubject:false))
            if jsonPhrase.wordListCount() > 0 {
                for jsonWord in jsonPhrase.wordList{
                    let word = m_jsonDictionaryManager.getExistingWord(jsonWord: jsonWord)
                    np.appendWordToAssociatedWordList(word: word)
                }
            }
        }
        return np
    }

    mutating func createPhrasesFromJsonPhrases(){
        var np = dPhrase()
        
        for jsonPhrase in jsonPhraseManager.myList {
            let clusterType = getClusterTypeFromString(str: jsonPhrase.phraseType)
            //if rebuilding a phrase ...
            if (clusterType != .AMB){
                np = dPhrase(randomWord: m_randomWordLists!, phraseName: jsonPhrase.phraseName, phraseType: clusterType)
                //rebuild all of the member clusters from the jsonPhrase cluster list
                for jsonCluster in jsonPhrase.clusterList {
                    np.appendCluster(cluster: m_randomWordLists.getAgnosticRandomWordAsSingle(wordType: getClusterTypeFromString(str: jsonCluster.wordType), isSubject:false))
                    if jsonPhrase.wordListCount() > 0 {
                        for jsonWord in jsonPhrase.wordList{
                            let word = m_jsonDictionaryManager.getExistingWord(jsonWord: jsonWord)
                            np.appendWordToAssociatedWordList(word: word)
                        }
                    }
                }
                phraseManager.appendCluster(cluster: np)
            }
            //not legitimate phrase type
            else {
                
            }
        }
    }

    func getRandomSentenceObject()->RandomSentence?{
        return m_randomSentence
    }
    
//    mutating func getAgnosticRandomSubjPronounSentence()->dIndependentAgnosticClause{
//        m_randomSentence = RandomSentence(wsp: m_wsp, rft: .subjectPronounVerb)
//        return m_randomSentence.createAgnosticSubjectPronounVerbClause()
//    }

    mutating func getRandomAgnosticSentence()->dIndependentAgnosticClause{
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .twoArticles)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simplePrepositionPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleVerbPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .complexNounPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleNounPhrase)
        if m_currentLanguage == .English {
            m_randomSentence.setRandomPhraseType(rft: .simpleEnglishClause)
            return m_randomSentence.createRandomAgnosticPhrase(phraseType: .simpleEnglishClause)
        }
        else {
            //m_randomSentence.setRandomPhraseType(rft: .simpleClause)
            //m_randomSentence.setRandomPhraseType(rft: .simpleNounPhrase)
            //return m_randomSentence.createRandomAgnosticPhrase(phraseType: .simpleVerbAdverbPhrase)
            return m_randomSentence.createRandomAgnosticPhrase(phraseType: .subjectPronounVerb)
        }
    }
    
    mutating func getRandomAgnosticSentence(clause: dIndependentAgnosticClause, rft: RandomPhraseType){
        m_randomSentence.createRandomAgnosticPhrase(clause: clause, phraseType: rft)
    }
    
    mutating func createDictionaryFromJsonWords(wordType: WordType){
        m_jsonDictionaryManager.createDictionaryFromJsonWords(wordType: wordType)
    }
        

   
    mutating func append(spanishVerb: RomanceVerb, frenchVerb: RomanceVerb){
        switch m_currentLanguage {
        case .Spanish:
            if m_wsp.isNewVerb(verb: spanishVerb) { m_wsp.addVerbToDictionary(verb: spanishVerb)}
        case .French:
            if m_wsp.isNewVerb(verb: frenchVerb) {m_wsp.addVerbToDictionary(verb: frenchVerb)}
        default:
            break
        }
    }


    mutating func  analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
        return m_verbModelManager.analyzeAndCreateBVerb_SPIFE(language: language, verbPhrase: verbPhrase)
    }
    

    func getParser()->WordStringParser{
        return m_wsp
    }
    
    func getRandomPerson()->Person{
        return Person.allCases[Int.random(in: 0 ..< 6)]
    }
    
    func getNextPerson(currentPerson: Person)->Person{
        var personIndex = currentPerson.rawValue
        personIndex += 1
        if personIndex > 5 {personIndex = 0}
        return Person.allCases[personIndex]
    }
    
        
    func getRandomTense()->Tense{
        return tenseManager.getRandomTense()
    }
    
    mutating func getNextTense()->Tense {
        m_currentTenseIndex += 1
        if ( m_currentTenseIndex >= m_tenseList.count ){
            m_currentTenseIndex = 0
        }
        return m_tenseList[m_currentTenseIndex]
    }
    
    mutating func getPreviousTense()->Tense {
        m_currentTenseIndex -= 1
        if ( m_currentTenseIndex <= 0 ){
            m_currentTenseIndex = m_tenseList.count-1
        }
        return m_tenseList[m_currentTenseIndex]
    }
    
    
    func getModifierList(wordType: WordType)->Array<Word>{
        switch m_currentLanguage {
        case .Spanish:
            return m_wsp.getSpanishWords().adjectiveList
        case .English:
            return m_wsp.getEnglishWords().adjectiveList
        case .French:
            return m_wsp.getFrenchWords().adjectiveList
        case .Italian: break
        case .Portuguese: break
        case .Agnostic: break
        }
        return Array<Word>()
    }
    
    func getNounList()->Array<Word>{
        return m_wsp.getNounList()
    }
    
    func getVerbList()->Array<Word>{
        return m_wsp.getVerbList()
    }
    
    func getVerbCount()->Int{
        return m_wsp.getVerbCount()
    }
    
    mutating func buildSomeStuff(){
        
        let wordList = VerbUtilities().getListOfWords(characterArray: "ls sddd a principios  de dddddd  a principios    de fff    fffff ddd")
        let prepList = VerbUtilities().getListOfWords(characterArray: "a principios de")
        var startIndex = 0
        var wordIndex = 1
        while  wordIndex > 0 {
            wordIndex = VerbUtilities().doesStringListContainSubstringList(inputStringList: wordList, subStringList: prepList, startIndex : startIndex)
            if ( wordIndex > 0 ){
                print("substring found at index \(wordIndex)")
            }
            
            startIndex = wordIndex + prepList.count  //jump startIndex past this "find" and look for another
        }
        
        var cfgc = ContextFreeGrammarConstruction()
        grammarLibrary.nounPhraseGrammar = cfgc.createSomeNounPhraseGrammar()
        grammarLibrary.verbPhraseGrammar = cfgc.createSomeVerbPhraseGrammar()
        grammarLibrary.prepositionalPhraseGrammar = cfgc.createSomePrepositionalPhraseGrammar()
        grammarLibrary.adjectivePhraseGrammar = cfgc.createSomeAdjectivePhraseGrammar()
        
    }
    
    func getGrammarLibrary()->CFGrammarLibrary{
        return grammarLibrary
    }
    
//    mutating func createIndependentClause(clauseString: String)->dIndependentClause{
//        //convert sentence string into array of word strings
//
//        var wordList = Array<Word>()
//
//        let stringList = VerbUtilities().getListOfWordsIncludingPunctuation(characterArray: clauseString)
//        for wordString in stringList {
//            let word = Word(word: wordString, wordType : .unknown)
//            wordList.append(word)
//        }
//
//        //find and decompose contractions
//
//        wordList = m_wsp.handleContractions(wordList: wordList)
//
//        //search for and compress compound prepositions
//
//        for word in m_wsp.getPrepositions() {
//            let prepList = VerbUtilities().getListOfWords(characterArray: word.word)
//            if prepList.count > 1 {
//                //print("createSentence - prep: \(word.word)")
//                let result = m_wsp.handleCompoundExpressionInWordList(wordList: wordList, inputWordList: prepList)
//                if result.0 {
//                    wordList = result.1
//                }
//            }
//        }
//
//        //search for and compress compound prepositions
//
//        for word in m_wsp.getConjunctions()  {
//            let list = VerbUtilities().getListOfWords(characterArray: word.word)
//            if list.count > 1 {
//                //print("createSentence - prep: \(word.word)")
//                let result = m_wsp.handleCompoundExpressionInWordList(wordList: wordList, inputWordList: list)
//                if result.0 {
//                    wordList = result.1
//                }
//            }
//        }
//
//
//        //print("after handleCompoundExpressions - word string \(wordList)")
//
//        //convert the word strings into array of Word objects
//
//        var cr = ClusterResolution(m_language: m_currentLanguage, m_wsp : m_wsp)
//        var wo = convertListOfWordsToEmptyDataStructs(wordList: wordList)
//        //printSentenceDataList(msg: "before prescreen", sdList : wo)
//        wo = m_disambiguation.prescreen(sdList: wo)
//        //printSentenceDataList(msg: "after prescreen", sdList : wo)
//        wo = cr.lookForCompoundVerbs(sdList: wo)
//        printSentenceDataList(msg: "after - lookForCompoundVerbs", sdList : wo)
//        wo = resolveRemainingClusterWordTypes(sdList: wo)
//        wo = cr.resolveAmbiguousSingles(sentenceData: wo)
//        //wo = cr.resolveCompoundVerbs(sentenceData: wo)
//
//        for sd in wo{
//            printSentenceDataStruct(msg: "After disambiguation", sd: sd)
//        }
//
//        return  dIndependentClause(language: m_currentLanguage, sentenceString: clauseString, data: wo)
//    }
//
//
    //sentenceData stores a copy of the Word itself, plus the data associated with it (tense, gender, wordType, etc)
    
    mutating func convertListOfWordsToEmptyDataStructs(wordList: Array<Word>)->Array<SentenceData>{
        var sentenceData = Array<SentenceData>()
        for word in wordList {
            var wordData = SentenceData()
            wordData.word = word
            wordData.data.wordType = .UNK
            sentenceData.append(wordData)
        }
        return sentenceData
    }
    
    //SentenceData comprises Word and 
    mutating func resolveRemainingClusterWordTypes(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = Array<SentenceData>()

        var sd : SentenceData
        for wordData in sdList {
            sd = wordData
            if sd.data.wordType == .UNK { sd = m_wsp.getNoun(wordString: wordData.word.word)}
            if sd.data.wordType == .UNK { sd = m_wsp.getArticle(wordString: wordData.word.word) }
            if sd.data.wordType == .UNK { sd = m_wsp.getPronoun(wordString: wordData.word.word) }
            if sd.data.wordType == .UNK { sd = m_wsp.getPunctuation(wordString: wordData.word.word) }
            if sd.data.wordType == .UNK { sd = m_wsp.getAdjective(wordString: wordData.word.word)}
            if sd.data.wordType == .UNK { sd = m_wsp.getDeterminer(wordString: wordData.word.word)}
            if sd.data.wordType == .UNK { sd = m_wsp.getConjunction(wordString: wordData.word.word)  }
            if sd.data.wordType == .UNK { sd = m_wsp.getPreposition(wordString: wordData.word.word)  }
            if sd.data.wordType == .UNK { sd = m_wsp.getVerb(wordString: wordData.word.word) }
            //append word here, even if it is unknown
            sentenceDataList.append(sd)
            printSentenceDataStruct(msg: "During convertWordStringsToSentenceDataStructs", sd: sd)
            }
        return sentenceDataList
    }
 
    func printSentenceDataStruct(msg: String, sd : SentenceData){
        if (sd.word.wordType == .verb ){
            print("\(msg): \(sd.word.word) - word.wordType: \(sd.word.wordType), data.wordType= \(sd.data.wordType), tense = \(sd.data.tense) ")
        } else {
            print("\(msg): \(sd.word.word) - word.wordType: \(sd.word.wordType), data.wordType= \(sd.data.wordType) ")
        }
    }
    
    func printSentenceDataList(msg: String, sdList : Array<SentenceData>){
        for sd in sdList{
            printSentenceDataStruct(msg: msg, sd : sd)
        }
    }
    
       
    //-------------------------------------------------------------------------------------------
    //
    //logic for handling the more advanced BVerb
    //
    //-------------------------------------------------------------------------------------------
    
    func isValidVerbEnding(language: LanguageType, verbEnding: VerbEnding )->Bool {
        switch language {
        case .Spanish: if verbEnding == .RE {return false}
        case .French: if verbEnding == .AR {return false}
        default: break
        }
        return true
    }
    
    
    
    func getListWord(index: Int, wordType: WordType)->Word{
        var word = Word()
        
        let wordList = getWordList(wordType: wordType)
        let wordIndex = index % wordList.count
        word = wordList[wordIndex]
        
        let v = word as! Verb
        let span = v.getWordAtLanguage(language: .Spanish)
        let fr = v.getWordAtLanguage(language: .French)
        let eng = v.getWordAtLanguage(language: .English)
        print("\(span) - \(fr) - \(eng)")
       
        return word
    }

    func getWordCount(wordType: WordType)->Int{
        return getWordList(wordType: wordType).count
    }
    
    func getWordList(wordType: WordType)->Array<Word>{
        switch(wordType){
        case .adjective:
            switch m_currentLanguage {
            case .Spanish:
                return m_wsp.getSpanishWords().adjectiveList
            case .English:
                return m_wsp.getEnglishWords().adjectiveList
            case .French:
                return m_wsp.getFrenchWords().adjectiveList
            case .Italian: break
            case .Portuguese: break
            case .Agnostic: break
            }
        case .noun:
            switch m_currentLanguage {
            case .Spanish:
                return m_wsp.getSpanishWords().nounList
            case .English:
                return m_wsp.getEnglishWords().nounList
            case .French:
                return m_wsp.getFrenchWords().nounList
            case .Italian: break
            case .Portuguese: break
            case .Agnostic: break
            }
        case .preposition:
            switch m_currentLanguage {
            case .Spanish:
                return m_wsp.getSpanishWords().prepositionList
            case .English:
                return m_wsp.getEnglishWords().prepositionList
            case .French:
                return m_wsp.getFrenchWords().prepositionList
            case .Italian: break
            case .Portuguese: break
            case .Agnostic: break
            }
        case .verb:
            return m_wsp.getVerbList()
        case .adverb:
            switch m_currentLanguage {
            case .Spanish:
                return m_wsp.getSpanishWords().adverbList  //work on this
            case .English:
                return m_wsp.getEnglishWords().adverbList
            case .French:
                return m_wsp.getFrenchWords().adverbList
            case .Italian: break
            case .Portuguese: break
            case .Agnostic: break
            }
        default:
            break
        }
        return Array<Word>()
    }
    
    func getAgnosticWordList(wordType: WordType)->Array<Word>{
        return m_wsp.getWordList(wordType: wordType)
    }
    
    func getAgnosticWorkingWordList(wordType: WordType)->Array<Word>{
        return m_wsp.getWorkingListOfType(wordType: wordType)
    }
    
    
    /*
    mutating func conjugateCurrentVerb(){
        currentTense = m_tenseList[m_currentTenseIndex]
        currentTenseString = currentTense.rawValue
        currentVerbPhrase = m_currentVerb.getPhrase()
        //let fvf = m_currentVerb.getFinalVerbForm(person: Person.S1)
        
        m_morphForm.removeAll()
        m_verbForm.removeAll()
        
        for p in 0..<6 {
            let person = Person.allCases[p]
            _ = m_currentVerb.getConjugatedMorphStruct(tense: currentTense, person: person, conjugateEntirePhrase : false )
            m_morphForm.append(m_currentVerb.getFinalVerbForm(person : person))
            m_verbForm.append(m_currentVerb.getFinalVerbForm(person : person))
            print("Tense: \(currentTense), Person: \(person) - verbForm = \(m_verbForm[p])")
        }
    }
*/
    
}


