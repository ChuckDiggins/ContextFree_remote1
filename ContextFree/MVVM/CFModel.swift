//
//  CFDriver.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

//this is where every little thing is constructed

struct CFModel{
    
    var grammarLibrary = CFGrammarLibrary()
    
    //var m_currentLanguage = LanguageType.French
    var m_currentLanguage : LanguageType
    
    var tenseManager = TenseManager()
    
    private var m_disambiguation = Disambiguation()
    private var m_tenseList = Array<Tense>()
    private var m_verbStringList: [String] = []
    private var m_masterVerbList: [BVerb] = []
    
    private var currentVerbString : String = ""
    private var currentTenseString : String = ""
    private var currentVerbPhrase : String = ""
    private var preposition : String = ""
    private var currentTense : Tense = .present
    private var m_currentPerson : Person = .S1

    private var bReconstructVerbModels = false
    private var bUseJsonStarterFiles = true   //this will reconstruct json words from user-supplied files, any other words will be lost
    private var m_randomSentence : RandomSentence!
    var m_morphForm = [String]()
    var m_morphComment = [String]()
    var m_verbForm = [String]()
    var m_wsp : WordStringParser!
    var jsonVerbManager = JsonVerbManager()
    var jsonNounManager = JsonNounManager()
    var jsonAdjectiveManager = JsonAdjectiveManager()
    var jsonDeterminerManager = JsonDeterminerManager()
    var jsonPrepositionManager = JsonPrepositionManager()
    
    var m_currentVerbIndex = 0
    var m_currentTenseIndex = 0
    var m_currentVerb =  BRomanceVerb()
    
    
    
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
        loadJsonWords()
        m_randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleClause)

        for tense in m_tenseList {
            print("active tense: \(tense.rawValue)")
        }
        
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
    
    mutating func loadJsonWords(){
        if bUseJsonStarterFiles {
            //jsonNounManager.encodeWords()  //this should wipe out existing jsonVerbs
            jsonNounManager.encodeInternalWords(total: 2000)
            
            //jsonVerbManager.encodeVerbs()  //this should wipe out existing jsonVerbs
            jsonVerbManager.encodeInternalVerbs(total: 2000)
            jsonAdjectiveManager.encodeInternalWords(total: 2000)
            jsonPrepositionManager.encodeInternalWords(total: 2000)
            jsonDeterminerManager.encodeInternalWords(total: 2000)
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
    }
    
    func getRandomSentenceObject()->RandomSentence{
        return m_randomSentence
    }
    
    mutating func getAgnosticRandomSubjPronounSentence()->dIndependentAgnosticClause{
        m_randomSentence = RandomSentence(wsp: m_wsp, rft: .subjectPronounVerb)
        return m_randomSentence.createAgnosticSubjectPronounVerbClause()
    }
    
    
    mutating func getRandomSubjPronounSentence()->dIndependentClause{
        m_randomSentence = RandomSentence(wsp: m_wsp, rft: .subjectPronounVerb)
        return m_randomSentence.createRandomSentenceNew()
    }
    
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
            return m_randomSentence.createRandomAgnosticPhrase(phraseType: .simpleClause)
        }
    }


    mutating func getRandomSentence()->dIndependentClause{
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .twoArticles)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simplePrepositionPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleVerbPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .complexNounPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleNounPhrase)
        if m_currentLanguage == .English {
            m_randomSentence.setRandomPhraseType(rft: .simpleEnglishClause)
            return m_randomSentence.createRandomSentenceNew()
        }
        else {
            m_randomSentence.setRandomPhraseType(rft: .simpleClause)
            //m_randomSentence.setRandomPhraseType(rft: .simpleClause)
            return m_randomSentence.createRandomSentenceNew()
        }
    }

   
    
    mutating func createDictionaryFromJsonWords(wordType: WordType){
        switch wordType{
        case .verb:
            for i in 0 ..< jsonVerbManager.getVerbCount() {
                let jsonWord = jsonVerbManager.getVerbAt(index: i)
                createAndAppendVerbFromJsonVerb(jv: jsonWord)
            }
        case .noun:
            for i in 0 ..< jsonNounManager.getWordCount() {
                let jsonWord = jsonNounManager.getWordAt(index: i)
                createAndAppendNounFromJsonNoun(jn: jsonWord)
            }
        case .adjective:
            for i in 0 ..< jsonAdjectiveManager.getWordCount() {
                let jsonWord = jsonAdjectiveManager.getWordAt(index: i)
                createAndAppendAdjectiveFromJsonAdjective(jn: jsonWord)
            }
        case .preposition:
            for i in 0 ..< jsonPrepositionManager.getWordCount() {
                let jsonWord = jsonPrepositionManager.getWordAt(index: i)
                createAndAppendPrepositionFromJsonPreposition(jn: jsonWord)
            }
        case .determiner:
            for i in 0 ..< jsonDeterminerManager.getWordCount() {
                let jsonWord = jsonDeterminerManager.getWordAt(index: i)
                createAndAppendDeterminerFromJsonDeterminer(jn: jsonWord)
            }
        default:
            break
        }
    }

    mutating func createAndAppendNounFromJsonNoun(jn: JsonNoun){
        var nounListCount = 0
        
        switch m_currentLanguage {
        case .Spanish:
            let noun = SpanishNoun(jsonNoun: jn)
            nounListCount = m_wsp.addNounToDictionary(noun: noun)
        case .French:
            let noun = FrenchNoun(jsonNoun: jn)
            nounListCount = m_wsp.addNounToDictionary(noun: noun)
        case .English:
            let noun = EnglishNoun(jsonNoun: jn)
            nounListCount = m_wsp.addNounToDictionary(noun: noun)
        case .Agnostic:
            let noun = Noun(jsonNoun: jn, language: .Agnostic)
            nounListCount = m_wsp.addNounToDictionary(noun: noun)
        default:
            break
        }
    }
    
    mutating func createAndAppendAdjectiveFromJsonAdjective(jn: JsonAdjective){
        var adjListCount = 0
        
        switch m_currentLanguage {
        case .Spanish:
            let adj = SpanishAdjective(jsonAdjective: jn)
            adjListCount = m_wsp.addAdjectiveToDictionary(adj: adj)
        case .French:
            let adj = FrenchAdjective(jsonAdjective: jn)
            adjListCount = m_wsp.addAdjectiveToDictionary(adj: adj)
        case .English:
            let adj = EnglishAdjective(jsonAdjective: jn, language: .English)
            adjListCount = m_wsp.addAdjectiveToDictionary(adj: adj)
        case .Agnostic:
            let adj = Adjective(jsonAdjective: jn, language: .Agnostic)
            adjListCount = m_wsp.addAdjectiveToDictionary(adj: adj)
        default:
            break
        }
    }
    
    mutating func createAndAppendPrepositionFromJsonPreposition(jn: JsonPreposition){
        var listCount = 0
        
        switch m_currentLanguage {
        case .Spanish:
            let p = SpanishPreposition(json: jn)
            listCount = m_wsp.addPrepositionToDictionary(wd: p)
        case .French:
            let p = FrenchPreposition(json: jn)
            listCount = m_wsp.addPrepositionToDictionary(wd: p)
        case .English:
            let p = EnglishPreposition(json: jn, language: .English)
            listCount = m_wsp.addPrepositionToDictionary(wd: p)
        case .Agnostic:
            let p = Preposition(json: jn, language: .Agnostic)
            listCount = m_wsp.addPrepositionToDictionary(wd: p)
        default:
            break
        }
    }
   
    mutating func createAndAppendDeterminerFromJsonDeterminer(jn: JsonDeterminer){
        var listCount = 0
        
        switch m_currentLanguage {
        case .Spanish:
            let p = SpanishDeterminer(json: jn)
            listCount = m_wsp.addDeterminerToDictionary(wd: p)
        case .French:
            let p = FrenchDeterminer(json: jn)
            listCount = m_wsp.addDeterminerToDictionary(wd: p)
        case .English:
            let p = EnglishDeterminer(json: jn, language: .English)
            listCount = m_wsp.addDeterminerToDictionary(wd: p)
        case .Agnostic:
            let p = Determiner(json: jn, language: .Agnostic)
            listCount = m_wsp.addDeterminerToDictionary(wd: p)
        default:
            
            break
        }
    }
   
    mutating func createJsonNoun(noun: Noun){
        appendJsonNoun(jsonNoun: noun.createJsonNoun())
    }

    mutating func appendJsonNoun(jsonNoun: JsonNoun)->Int{
        jsonNounManager.appendWord(verb: jsonNoun)
        createAndAppendNounFromJsonNoun(jn: jsonNoun)
        //jsonNounManager.printWords()
        return jsonNounManager.getWordCount()
    }
    
    mutating func createJsonVerb(verb: Verb){
        appendJsonVerb(jsonVerb: verb.createJsonVerb())
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
        var verbListCount = 0
        
        //creates a BVerb from the jsonVerb.word
        
        var bVerbString = ""
        switch m_currentLanguage {
        case .Spanish:
            bVerbString = jv.spanish
        case .French:
            bVerbString = jv.french
        case .English:
            bVerbString = jv.english
        default: break
        }
        
        let spanishVerbStuff = analyzeAndCreateBVerb_SPIFE(language: .Spanish, verbPhrase: jv.spanish)
        let frenchVerbStuff = analyzeAndCreateBVerb_SPIFE(language: .French, verbPhrase: jv.french)
        let englishVerbStuff = analyzeAndCreateBVerb_SPIFE(language: .English, verbPhrase: jv.english)
        if ( spanishVerbStuff.isValid && frenchVerbStuff.isValid && englishVerbStuff.isValid){
            switch m_currentLanguage {
            case .Spanish:
                let verb = SpanishVerb(jsonVerb: jv)
                verb.setBVerb(bVerb: spanishVerbStuff.verb)
                verbListCount = m_wsp.addVerbToDictionary(verb: verb)
            case .French:
                let verb = FrenchVerb(jsonVerb: jv)
                verb.setBVerb(bVerb: frenchVerbStuff.verb)
                verbListCount = m_wsp.addVerbToDictionary(verb: verb)
            case .English:
                let verb = EnglishVerb(jsonVerb: jv)
                verb.setBVerb(bVerb: englishVerbStuff.verb)
                verbListCount = m_wsp.addVerbToDictionary(verb: verb)
            case .Agnostic:
                let verb = Verb(jsonVerb: jv, language: .Agnostic)
                verbListCount = m_wsp.addVerbToDictionary(verb: verb)
            default:
                break
            }
        }
    }
    
    
   
    mutating func append(spanishVerb: RomanceVerb, frenchVerb: RomanceVerb)->Int{
        var verbListCount = 0
        switch m_currentLanguage {
        case .Spanish:
            if m_wsp.isNewVerb(verb: spanishVerb) { verbListCount = m_wsp.addVerbToDictionary(verb: spanishVerb)}
        case .French:
            if m_wsp.isNewVerb(verb: frenchVerb) { verbListCount = m_wsp.addVerbToDictionary(verb: frenchVerb)}
        default:
            break
        }
        return verbListCount
    }

    mutating func  analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
        var verb = BVerb()
        var util = VerbUtilities()
        let verbStuff = util.analyzeWordPhrase(testString: verbPhrase)
        var reconstructedVerbPhrase = util.reconstructVerbPhrase(verbWord: verbStuff.verbWord, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
        
        switch language {
        case .Spanish:
            verb = createSpanishBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                      residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
            return (true, verb)
        case .French:
            verb = createFrenchBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                     residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
            return (true, verb)
        case .English:
            var verb = BVerb()
            verb = createEnglishBVerb(verbWord:verbPhrase)
            return (true, verb)
        default:
            return (false, BVerb())
        }
    }


    mutating func bVerbDoesExist(verbString: String)->Bool{
        for bVerb in m_masterVerbList {
            if verbString == bVerb.m_verbPhrase {return true}
        }
        return false
    }

    func getParser()->WordStringParser{
        return m_wsp
    }
    
        
    func getRandomTense()->Tense{
        return tenseManager.getRandomTense()
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
    
    func getNounList()->Array<NounComponent>{
        var words = Array<NounComponent>()
        words.append(NounComponent(word: "casa", plural: "rojos"))
        words.append(NounComponent(word: "perro", plural: "perros"))
        words.append(NounComponent(word: "gato", plural: "gatos"))
        words.append(NounComponent(word: "niño", plural: "niños"))
        words.append(NounComponent(word: "niña", plural: "niñas"))
        return words
    }
    
    func getVerbList()->Array<Word>{
        return m_wsp.getVerbList()
    }
    
    func getVerbCount()->Int{
        return m_wsp.getVerbCount()
    }
    
    /*
    func getVerbList()->Array<VerbComponent>{
        var words = Array<VerbComponent>()
        words.append(VerbComponent(word: "venir", pastParticiple: "venido", presentParticiple: "veniendo"))
        words.append(VerbComponent(word: "comer", pastParticiple: "comido", presentParticiple: "comiendo"))
        words.append(VerbComponent(word: "tomar", pastParticiple: "tomado", presentParticiple: "tomando"))
        words.append(VerbComponent(word: "tener", pastParticiple: "tenido", presentParticiple: "teniendo"))
        words.append(VerbComponent(word: "andar", pastParticiple: "andado", presentParticiple: "andando"))
        words.append(VerbComponent(word: "estar", pastParticiple: "estado", presentParticiple: "estando"))
        words.append(VerbComponent(word: "hacer", pastParticiple: "hecho", presentParticiple: "haciendo"))
        return words
    }
    */
    
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
    
    mutating func createIndependentClause(clauseString: String)->dIndependentClause{
        //convert sentence string into array of word strings
        
        var wordList = Array<Word>()
        
        let stringList = VerbUtilities().getListOfWordsIncludingPunctuation(characterArray: clauseString)
        for wordString in stringList {
            let word = Word(word: wordString, def: "", wordType : .unknown)
            wordList.append(word)
        }
        
        //find and decompose contractions
        
        wordList = m_wsp.handleContractions(wordList: wordList)
        
        //search for and compress compound prepositions
        
        for word in m_wsp.getPrepositions() {
            let prepList = VerbUtilities().getListOfWords(characterArray: word.word)
            if prepList.count > 1 {
                //print("createSentence - prep: \(word.word)")
                let result = m_wsp.handleCompoundExpressionInWordList(wordList: wordList, inputWordList: prepList)
                if result.0 {
                    wordList = result.1
                }
            }
        }
        
        //search for and compress compound prepositions
        
        for word in m_wsp.getConjunctions()  {
            let list = VerbUtilities().getListOfWords(characterArray: word.word)
            if list.count > 1 {
                //print("createSentence - prep: \(word.word)")
                let result = m_wsp.handleCompoundExpressionInWordList(wordList: wordList, inputWordList: list)
                if result.0 {
                    wordList = result.1
                }
            }
        }
              
        
        //print("after handleCompoundExpressions - word string \(wordList)")
        
        //convert the word strings into array of Word objects
        
        var cr = ClusterResolution(m_language: m_currentLanguage, m_wsp : m_wsp)
        var wo = convertListOfWordsToEmptyDataStructs(wordList: wordList)
        //printSentenceDataList(msg: "before prescreen", sdList : wo)
        wo = m_disambiguation.prescreen(sdList: wo)
        //printSentenceDataList(msg: "after prescreen", sdList : wo)
        wo = cr.lookForCompoundVerbs(sdList: wo)
        printSentenceDataList(msg: "after - lookForCompoundVerbs", sdList : wo)
        wo = resolveRemainingClusterWordTypes(sdList: wo)
        wo = cr.resolveAmbiguousSingles(sentenceData: wo)
        //wo = cr.resolveCompoundVerbs(sentenceData: wo)
        
        for sd in wo{
            printSentenceDataStruct(msg: "After disambiguation", sd: sd)
        }
        
        return  dIndependentClause(language: m_currentLanguage, sentenceString: clauseString, data: wo)
    }
    
       
    //sentenceData stores a copy of the Word itself, plus the data associated with it (tense, gender, wordType, etc)
    
    mutating func convertListOfWordsToEmptyDataStructs(wordList: Array<Word>)->Array<SentenceData>{
        var sentenceData = Array<SentenceData>()
        for word in wordList {
            var wordData = SentenceData()
            wordData.word = word
            wordData.data.wordType = .unknown
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
            if sd.data.wordType == .unknown { sd = m_wsp.getNoun(wordString: wordData.word.word)}
            if sd.data.wordType == .unknown { sd = m_wsp.getArticle(wordString: wordData.word.word) }
            if sd.data.wordType == .unknown { sd = m_wsp.getPronoun(wordString: wordData.word.word) }
            if sd.data.wordType == .unknown { sd = m_wsp.getPunctuation(wordString: wordData.word.word) }
            if sd.data.wordType == .unknown { sd = m_wsp.getAdjective(wordString: wordData.word.word)}
            if sd.data.wordType == .unknown { sd = m_wsp.getDeterminer(wordString: wordData.word.word)}
            if sd.data.wordType == .unknown { sd = m_wsp.getConjunction(wordString: wordData.word.word)  }
            if sd.data.wordType == .unknown { sd = m_wsp.getPreposition(wordString: wordData.word.word)  }
            if sd.data.wordType == .unknown { sd = m_wsp.getVerb(wordString: wordData.word.word) }
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
    
    func getWorkingVerbList()->[BVerb]{
        return m_masterVerbList
    }

    mutating func addVerbToWorkingList(verb : BVerb){
        m_masterVerbList.append(verb)
    }
    
    func isValidVerbEnding(language: LanguageType, verbEnding: VerbEnding )->Bool {
        switch language {
        case .Spanish: if verbEnding == .RE {return false}
        case .French: if verbEnding == .AR {return false}
        default: break
        }
        return true
    }
    
    mutating func analyzeAndCreateNewVerb(verbPhrase: String)->(isValid: Bool, verb: BRomanceVerb){
        let verbStuff = VerbUtilities().analyzeWordPhrase(testString: verbPhrase)
        
        if ( isValidVerbEnding(language: m_currentLanguage, verbEnding: verbStuff.verbEnding)){
            if verbStuff.verbWord.count>1 {
                let verb = createNewBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
                m_currentVerb = verb
                return (true, verb)
            }
            else {
                return (false, BRomanceVerb())
            }
        }
        return (false, BRomanceVerb())
    }

    mutating func createEnglishBVerb(verbWord: String) -> BEnglishVerb {
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        
        let brv = BEnglishVerb(verbPhrase : constructedVerbPhrase, verbWord: verbWord)
        
        let verbModel = m_englishVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setModel(verbModel : verbModel)

        return brv
    }

    mutating func createSpanishBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BSpanishVerb {
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        let brv = BSpanishVerb(verbPhrase : constructedVerbPhrase,
                               verbWord: verbWord,
                               verbEnding: verbEnding,
                               languageType: m_currentLanguage,
                               preposition: residualPhrase, isReflexive: isReflexive)
        
        let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setPatterns(verbModel : verbModel)
        return brv
    }
    
    mutating func createFrenchBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BFrenchVerb {
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        let brv = BFrenchVerb(verbPhrase : constructedVerbPhrase,
                               verbWord: verbWord,
                               verbEnding: verbEnding,
                               languageType: m_currentLanguage,
                               preposition: residualPhrase, isReflexive: isReflexive)
        
        let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setPatterns(verbModel : verbModel)
        return brv
    }
    
    mutating func createNewBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BRomanceVerb {
        
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        switch m_currentLanguage {
        case .Spanish:
            let brv = BSpanishVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                   languageType: m_currentLanguage,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            
            let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        case .French:
            let brv = BFrenchVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                   languageType: m_currentLanguage,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        default:
            return BRomanceVerb()
        }
        
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

    mutating func loadCurrentVerbStringListFromCurrentDictionary(){
        var dictionary = [String]()
        switch (m_currentLanguage){
        case .Spanish:
            dictionary = SpanishVerbList().getVerbList(svl: spanishVerbList.orthoPresent)
        case .French:
            dictionary = FrenchVerbList().getVerbList(svl: frenchVerbList.irregular )
        default:  break
        }
        
        m_verbStringList.removeAll()
        
        for str in dictionary {
            m_verbStringList.append(str)
        }
    }

    
    

    mutating func createMasterVerbListFromVerbStrings(){
        for testVerbPhrase in m_verbStringList {
            
            let verbStuff = analyzeAndCreateNewVerb(verbPhrase: testVerbPhrase)
            if ( verbStuff.isValid ){
                addVerbToMasterList(verb: verbStuff.verb)
                print("VM new verb added to active list: \(verbStuff.verb.m_verbPhrase), activeVerbCount = \(m_masterVerbList.count)")
            }
            else {
                print("\(testVerbPhrase) could not be processed as a legal verb")
            }
            
        }
        
        var i=0
        
        for bVerb in m_masterVerbList {
            print("VM active verb \(i) = \(bVerb.m_verbPhrase)")
            i += 1
        }
        
        m_currentVerb = m_masterVerbList[m_currentVerbIndex] as! BRomanceVerb
        conjugateCurrentVerb()
        
    }
    
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
    
    mutating func addVerbToMasterList(verb: BRomanceVerb){
        m_masterVerbList.append(verb)
        m_currentVerb = verb
        m_currentVerbIndex = m_masterVerbList.count-1
    }
    
    /*
    func unConjugate(verbForm : String)->( BSpanishVerb, Tense, Person)  {
        var conjugateForm = ""
        //var verb = BSpanishVerb()
        
        var count = 0
        for v in m_masterVerbList {
            let verb = v as! BSpanishVerb
            for tense in Tense.indicativeAll {
                for person in Person.all {
                    conjugateForm = verb.getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : false ).finalVerbForm()
                    conjugateForm = Utilities().removeLeadingOrFollowingBlanks(characterArray: conjugateForm)
                    if conjugateForm == verbForm {
                        print("\(count) verb forms were searched")
                        return (verb, tense, person)
                    }
                    count += 1
                }
            }
            
            for tense in Tense.subjunctiveAll {
                for person in Person.all {
                    conjugateForm = verb.getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : false ).finalVerbForm()
                    conjugateForm = Utilities().removeLeadingOrFollowingBlanks(characterArray: conjugateForm)
                    if conjugateForm == verbForm {
                        print("\(count) verb forms were searched")
                        return (verb, tense, person)
                    }
                    count += 1
                }
            }
        }
        print("\(count) verb forms were searched")
        return (BSpanishVerb(), .present, .S1)
    }
 */
}


