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
    private var m_verbModelConjugation = RomanceVerbModelConjugation()
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
    //var m_randomWord : RandomWordLists!
    
    var m_currentVerbIndex = 0
    var m_currentTenseIndex = 0
    var m_currentVerb =  BRomanceVerb()
    
    
    
    init(language: LanguageType){
        m_currentLanguage = language
        m_wsp = WordStringParser(language:m_currentLanguage)
        
        buildSomeStuff()
        if ( m_currentLanguage == .Spanish ){
            loadSpanishVerbStuff()
        }
        
        //m_randomWord = RandomWordLists(wsp: m_wsp)
        
        //m_cfcg = ContextFreeConstructionGrammar(wsp: m_wsp)

        for tense in m_tenseList {
            print("active tense: \(tense.rawValue)")
        }
        
        createJsonVerb()
    }

    mutating func getRandomSentence()->dIndependentClause{
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
        
        
        var str = "abcdefghíndomelos"
        let subString = "índo"
        let result = VerbUtilities().doesWordContainSubstring(inputString: str, subString: subString)
        if result.0 {
            let suffixCount = str.count - result.2
            let suffix = str.suffix(suffixCount)
            print ("str \(str), suffix \(suffix)")
            //remove the suffix
            str.removeLast(suffixCount)
            //remove the accented progressiveEnding
            str.removeLast(subString.count)
            //attach the unaccented progressiveEnding
            str += "indo"
            print ("residual string = \(str)")
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
        wo = prescreen(sdList: wo)
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
    
    //mutating func parseWordListIntoWordObjects(wordList: Array<String>)->Array<Word>{
    //    return getWordObjects(language: .Spanish, wordList: wordList)
    //}
    mutating func prescreen(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = sdList
        
        sentenceDataList = lookForProgressivePlusattachedPronouns(sdList: sdList)
        
        //printSentenceDataList(msg: "After prescreen", sdList : sentenceDataList)
        return sentenceDataList
    }
    
    mutating func lookForCompoundVerbs(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = sdList
        var compoundVerbFound = true
        var tense = Tense.present
        while compoundVerbFound {
            for sdIndex in 0 ..< sdList.count-1 {
                compoundVerbFound = false
                let sd = sdList[sdIndex]
                
                //first word should be a progressiveVerb
                let wordData = m_wsp.getVerb(wordString: sd.word.word)
                
                //if the verb is auxiliary, check to see if the next word is either progressive or perfect
                if wordData.data.verbType == .auxiliary {
                    let nextSD = sdList[sdIndex+1]
                    var nextWordData : SentenceData
                    //if this word has already been determined to be a verb and is a present or past participle, then use as is
                    
                    let wordType = nextSD.data.wordType
                    let tense = nextSD.data.tense
                    
                    if  wordType == .verb && tense == .presentParticiple {
                        nextWordData = nextSD
                    }
                    else if wordType == .verb && tense == .pastParticiple {
                        nextWordData = nextSD
                    }
                    //else scan for it
                    else { nextWordData = m_wsp.getVerb(wordString: nextSD.word.word) }
                    
                    //if a participle, then combine the two verbs into a single verb using nextSD and convert the tense appropriately
                    
                    if nextWordData.data.tense == .pastParticiple {
                        var newSD = nextSD
                        newSD.data.tense = wordData.data.tense.getPerfectTense()
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.insert(newSD, at: sdIndex)
                        compoundVerbFound = true
                    }
                    else if nextWordData.data.tense == .presentParticiple {
                        var newSD = nextSD
                        newSD.data.tense = wordData.data.tense.getProgressiveTense()
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.insert(newSD, at: sdIndex)
                        compoundVerbFound = true
                    }
                }
            }
        }
        return sentenceDataList
    }
    
    mutating func lookForProgressivePlusattachedPronouns(sdList : Array<SentenceData>)->Array<SentenceData>{
    var sentenceDataList = sdList
    //handle object pronouns of various sorts, detaching them from other words
    //such as vendiéndomelos = viendo + me + los
    
    var workingIndex = 0
    for sd in sdList {
        let newWordList = m_wsp.handleObjectPronouns(wordString: sd.word.word)
        if ( newWordList.count > 0 ){
            //first word should be a progressiveVerb
            var wordData = m_wsp.getVerb(wordString: newWordList[0])
            sentenceDataList.remove(at: workingIndex)
            sentenceDataList.insert(wordData, at: workingIndex)
            workingIndex += 1
            
            //if 3 words, then the second word is an indirect object pronoun and the third is a direct object pronoun
            if (newWordList.count == 3){
                wordData = m_wsp.getObjectPronoun(wordString: newWordList[1], type : .INDIRECT_OBJECT)
                sentenceDataList.insert(wordData, at: workingIndex)
                workingIndex += 1
                wordData = m_wsp.getObjectPronoun(wordString: newWordList[2], type : .DIRECT_OBJECT)
                sentenceDataList.insert(wordData, at: workingIndex)
                workingIndex += 1
            }
            else if ( newWordList.count == 2){
                wordData = m_wsp.getObjectPronoun(wordString: newWordList[1], type : .DIRECT_OBJECT)
                sentenceDataList.insert(wordData, at: workingIndex)
                workingIndex += 1
            }
        }
        else {
            workingIndex += 1
        }
    }
    return sentenceDataList
    
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
    
    mutating func loadSpanishVerbStuff(){
        m_tenseList = tenseManager.getActiveTenseList()
        loadCurrentVerbStringListFromCurrentDictionary()
        createMasterVerbListFromVerbStrings()
        
        //if Spanish, then load all the bSpVerbs into the Verb dictionary
        
        if ( m_currentLanguage == .Spanish){
            for bVerb in m_masterVerbList {
                let bSpVerb = bVerb as! BSpanishVerb
                let verb = SpanishVerb(bVerb: bSpVerb)
                m_wsp.addSpanishVerbToDictionary(verb: verb)
            }
        }
        
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
            
            let verbModel = m_verbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        case .French:
            let brv = BFrenchVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                   languageType: m_currentLanguage,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            let verbModel = m_verbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        default:
            return BRomanceVerb()
        }
        
    }

    mutating func getCurrentDictionary()->[String:String]{
        
        //return SpanishVerbList().getVerbs(svl: spanishVerbList.tenerOnly)
        return SpanishVerbList().getVerbs(svl: spanishVerbList.popular100)
    }
    
    mutating func loadCurrentVerbStringListFromCurrentDictionary(){
        let dictionary = getCurrentDictionary()
        
        for ( key, _ ) in dictionary {
            m_verbStringList.append(key)
            print("\(key)")
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
        
        let verb = m_masterVerbList[m_currentVerbIndex]
        m_currentVerb = verb as! BSpanishVerb
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


