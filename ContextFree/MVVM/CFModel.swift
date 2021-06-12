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
    //private var m_verbModelConjugation = RomanceVerbModelConjugation()
    private var m_spanishVerbModelConjugation = RomanceVerbModelConjugation()
    private var m_frenchVerbModelConjugation = RomanceVerbModelConjugation()
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

    
    var m_morphForm = [String]()
    var m_morphComment = [String]()
    var m_verbForm = [String]()
    var m_wsp : WordStringParser!
    var jsonVerbManager = JsonVerbManager()
    
    var m_currentVerbIndex = 0
    var m_currentTenseIndex = 0
    var m_currentVerb =  BRomanceVerb()
    
    
    
    init(language: LanguageType){
        m_currentLanguage = language
        m_wsp = WordStringParser(language:m_currentLanguage)
        m_spanishVerbModelConjugation.setLanguage(language: .Spanish)
        m_frenchVerbModelConjugation.setLanguage(language: .French)
        m_disambiguation.setWordStringParser(wsp: m_wsp)
        createVerbModels()
        buildSomeStuff()
        m_tenseList = tenseManager.getActiveTenseList()
        loadJsonVerbs()
        
        //m_cfcg = ContextFreeConstructionGrammar(wsp: m_wsp)

        for tense in m_tenseList {
            print("active tense: \(tense.rawValue)")
        }
        
    }

    mutating func getVerbModel(language: LanguageType)->RomanceVerbModelConjugation{
        switch language{
        case .Spanish: return m_spanishVerbModelConjugation
        case .French: return m_frenchVerbModelConjugation
        default: return RomanceVerbModelConjugation()
        }
    }
    
    mutating func createVerbModels(){
        //this will recreate the json verbs if they need recreating
        //m_verbModelConjugation.createVerbModels(mode: .both)
        //m_verbModelConjugation.createVerbModels(mode: .json)
        m_spanishVerbModelConjugation.createVerbModels(mode: .json)
        m_frenchVerbModelConjugation.createVerbModels(mode: .json)
    }
    mutating func loadJsonVerbs(){
        let loadInternalJsonVerbs = false
        if loadInternalJsonVerbs {
            jsonVerbManager.encodeVerbs()  //this should wipe out existing jsonVerbs
            jsonVerbManager.encodeInternalVerbs(total: 2000)
            print("after encodeInternalVerbs -- Json verb count = \(jsonVerbManager.getVerbCount())")
        }
        jsonVerbManager.decodeVerbs()
        print("Json verb count = \(jsonVerbManager.getVerbCount())")
        createVerbDictionaryFromJsonVerbs()
        print("Spanish dictionary verb count = \(m_wsp.getSpanishVerbCount())")
        print("French dictionary verb count = \(m_wsp.getFrenchVerbCount())")
        
    }
    
    mutating func createJsonVerb(verb: Verb, bNumber: Int){
        let jv = verb.createJsonVerb(bNumber: bNumber)
        appendJsonVerb(jsonVerb: jv)
    }

    mutating func appendJsonVerb(jsonVerb: JsonVerb){
        jsonVerbManager.appendVerb(verb: jsonVerb)
        createAndAppendVerbFromJsonVerb(jv: jsonVerb)
        jsonVerbManager.printVerbs()
    }
    
    mutating func createVerbDictionaryFromJsonVerbs(){
        for i in 0..<jsonVerbManager.getVerbCount() {
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
        
        let verbStuff = analyzeAndCreateNewBVerb(verbPhrase: bVerbString)
        if ( verbStuff.isValid ){
            let bVerb = verbStuff.verb
            
            switch m_currentLanguage {
            case .Spanish:
                let verb = SpanishVerb(jsonVerb: jv)
                verb.setBVerb(bVerb: bVerb)
                verbListCount = m_wsp.addSpanishVerbToDictionary(verb: verb)
            case .French:
                let verb = FrenchVerb(jsonVerb: jv)
                verb.setBVerb(bVerb: bVerb)
                verbListCount = m_wsp.addFrenchVerbToDictionary(verb: verb)
            default:
                break
            }
        }
    }
    
    /*
    mutating func append(romanceVerb: RomanceVerb)->Int{
        var verbListCount = 0
        
        switch m_currentLanguage {
        case .Spanish:
            verbListCount = m_wsp.addSpanishVerbToDictionary(verb: romanceVerb)
        case .French:
            verbListCount = m_wsp.addFrenchVerbToDictionary(verb: romanceVerb)
        default:
            break
        }
        return verbListCount
    }
    */
    
    mutating func analyzeAndCreateNewBVerb(verbPhrase: String)->(isValid: Bool, verb: BVerb){
        var util = VerbUtilities()
        let verbStuff = util.analyzeWordPhrase(testString: verbPhrase)
        let reconstructedVerbPhrase = util.reconstructVerbPhrase(verbWord: verbStuff.verbWord, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
        
        if !bVerbDoesExist(verbString: reconstructedVerbPhrase){
            if verbStuff.verbWord.count>1 {
                let verb = createNewBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                          residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
                m_currentVerb = verb
                return (true, verb)
            }
        }
        return (false, BVerb())
    }
    
    mutating func append(language: LanguageType, romanceVerb: RomanceVerb)->Int{
        var verbListCount = 0
        
        switch language {
        case .Spanish:
            if ( m_wsp.isNewVerb(language: language, verb: romanceVerb) ){ verbListCount = m_wsp.addSpanishVerbToDictionary(verb: romanceVerb)}
        case .French:
            if ( m_wsp.isNewVerb(language: language, verb: romanceVerb) ){ verbListCount =  m_wsp.addSpanishVerbToDictionary(verb: romanceVerb)}
        default:
            break
        }
        return verbListCount
    }
    

    mutating func  analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
        var util = VerbUtilities()
        let verbStuff = util.analyzeWordPhrase(testString: verbPhrase)
        let reconstructedVerbPhrase = util.reconstructVerbPhrase(verbWord: verbStuff.verbWord, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
        
        if !bVerbDoesExist(verbString: reconstructedVerbPhrase){
            if verbStuff.verbWord.count>1 {
                var verb = BVerb()
                switch language {
                case .Spanish:
                    verb = createSpanishBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                          residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
                    return (true, verb)
                case .French:
                    verb = createFrenchBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                          residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
                    return (true, verb)
                default:
                    return (false, verb)
                }
            }
        }
        return (false, BVerb())
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
    
    mutating func getRandomSentence()->dIndependentClause{
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .twoArticles)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simplePrepositionPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleVerbPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .complexNounPhrase)
        //var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleNounPhrase)
        var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleClause)
        return randomSentence.createRandomSentenceNew()     
    }
    
    mutating func getRandomSubjPronounSentence()->dIndependentClause{
        var randomSentence = RandomSentence(wsp: m_wsp, rft: .subjectPronounVerb)
        return randomSentence.createRandomSentenceNew()
    }
    
    func getRandomPhraseForAdjectives(type: AdjectiveType)->dIndependentClause{
        var randomSentence = RandomSentence(wsp: m_wsp, rft: .simpleAdjectiveRegular)
        return randomSentence.createRandomSentenceNew()
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
        return m_wsp.getVerbList(language: m_currentLanguage)
    }
    
    func getVerbCount()->Int{
        return m_wsp.getVerbListCount(language: m_currentLanguage)
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
        
        let spVerb = word as! Verb
        let span = spVerb.getWordAtLanguage(language: .Spanish)
        let fr = spVerb.getWordAtLanguage(language: .French)
        let eng = spVerb.getWordAtLanguage(language: .English)
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
            }
        case .verb:
            return m_wsp.getVerbList(language: m_currentLanguage)
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


