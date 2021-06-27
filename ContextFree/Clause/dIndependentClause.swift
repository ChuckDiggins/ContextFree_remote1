//
//  dIndependentClause.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/18/21.
//

import Foundation

class dIndependentClause : dClause {
    var m_language : LanguageType
    var grammarLibrary = CFGrammarLibrary()
    var originalSentenceString = String()
    var processedSentenceString = ""
    var dataList = Array<SentenceData>()
    var clauseList = Array<WordRuleManager>()
    var currentWordRuleIndex = 0
    var sentence = dSentence()
    var headNoun = dCluster(word: Word(), clusterType: .UNK)
    var headVerb = dCluster(word: Word(), clusterType: .UNK)
    
    //var wordObjectList = Array<Word>()
    //var sentenceWordData = Array<SentenceWordData>()  //current information about each word
    
    /*
     Agnostic Clause Stuff here
     */
    
    func createAgnosticClauses(){
        
    }
    
    init(language: LanguageType, sentenceString: String, data: Array<SentenceData>){
        self.originalSentenceString = sentenceString
        self.dataList = data
        self.m_language = language
        super.init(word: Word(), clusterType: .InDCls)
    }
    
    init(language: LanguageType){
        self.m_language = language
        super.init(word: Word(), clusterType: .InDCls)
    }
    
    func setLanguage(language: LanguageType){
        self.m_language = language
        getSentenceData().language = language
    }
    
    
    func setGrammarLibrary(cfLib : CFGrammarLibrary){
        grammarLibrary = cfLib
    }
    
    override func getPerson()->Person{
        setHeadNounAndHeadVerb()
        getSentenceData().person = headNoun.getPerson()
        return getSentenceData().person
    }
    
    func getCurrentRuleManager()->WordRuleManager{
        return clauseList[currentWordRuleIndex]
    }
    
    func setCurrentWordRuleManager(mgr : WordRuleManager){
        clauseList[currentWordRuleIndex] = mgr
    }
    
    override func appendCluster(cluster: dCluster){
        sentence.appendCluster(cluster: cluster)
    }
    
    func appendWord(data: SentenceData){
        dataList.append(data)
    }
    
    func getWordList()-> (Array<Word>){
        var wordList = Array<Word>()
        
        for data in dataList {
            wordList.append( data.word )
        }
        return wordList
    }
    
    func getCurrentCFRuleListCount()->Int{
        return getCurrentRuleManager().ruleList.count
    }
    
    func getCurrentCFRuleList()->Array<ContextFreeRule>{
        return getCurrentRuleManager().ruleList
    }
    
    func analyze(){
        if clauseList.isEmpty{
            print("ClauseList is empty")
        }
        else{
            print("\nStep 1 - noun phrase parsing")
            checkForNounPhrases()
            printClusters()
            
            print("\nStep 2 - prepositional phrase parsing")
            checkForPrepositionPhrases()
            printClusters()
            
            print("\nStep 3 - noun phrase parsing")
            checkForNounPhrases()
            printClusters()
            
            print("\nStep 4 - prepositional phrase parsing")
            checkForPrepositionPhrases()
            
            print("\nStep 5 - noun phrase parsing")
            checkForNounPhrases()
            
            print("\nStep 6 - verb phrase parsing")
            checkForVerbPhrases()
            
            printClusters()
            
            setHeadNounAndHeadVerb()
            
            let sentenceString = getReconstructedSentenceString()
            processedSentenceString = VerbUtilities().makeSentenceByEliminatingExtraBlanksAndDoingOtherStuff(characterArray: sentenceString)
            
            print("Reconstructed Sentence: \(processedSentenceString)")
            
        }
    }
    
    func setHeadNounAndHeadVerb(){
        
        for cluster in sentence.getClusterList(){
            
            //for now assume that the first NP is the head noun
            //let hct = headNoun.getClusterType()
            if cluster.getClusterType() == .NP && headNoun.getClusterType() == .UNK {
                //print("setting head noun phrase")
                headNoun = cluster
            }
            //let hcv = headVerb.getClusterType()
            if cluster.getClusterType() == .VP && headVerb.getClusterType() == .UNK {
                //print("setting head verb phrase")
                headVerb = cluster
            }
        }
        informHeadVerb()
    }
    
    func setTenseAndPersonAndCreateNewSentenceString(tense: Tense, person: Person)->String{
        if ( headVerb.getClusterType() != .UNK){
            let hvp = headVerb as! dVerbPhrase
            hvp.setTense(value: tense)
            hvp.setPerson(value: person)
        }
        
        if ( headNoun.getClusterType() != .UNK){
            let hnp = headNoun as! dNounPhrase
            hnp.setPerson(value: person)
        }
        return createNewSentenceString()
    }
    
    func createNewSentenceString()->String{
        var sentenceString = getReconstructedSentenceString()
        sentenceString = VerbUtilities().makeSentenceByEliminatingExtraBlanksAndDoingOtherStuff(characterArray: sentenceString)
        return sentenceString
    }
    
    func modifyClauseWord(newWord: dSingle){
        
    }
    
    func setHeadVerbTense(tense: Tense){
        let hv = headVerb as! dVerbPhrase
        hv.setTense(value: tense)
    }
    
    func getProcessedSentenceString()->String{
        return processedSentenceString
    }
    
    //this has the head NP inform the head VP about person
    
    func hasHeadVerb()->Bool{
        if headVerb.getClusterType() == .V || headVerb.getClusterType() == .VP {return true}
        return false
        
    }
    
    func hasHeadNoun()->Bool{
        if headNoun.getClusterType() == .N || headNoun.getClusterType() == .NP {return true}
        return false
    }
    
    func informHeadVerb(){
        if hasHeadVerb() && hasHeadNoun() {
            let hvp = headVerb as! dVerbPhrase
            if  headNoun.getClusterType() == .N || headNoun.getClusterType() == .SubjP {hvp.setPerson(value: headNoun.getPerson())}
            else if headNoun.getClusterType() == .NP {
                let hnp = headNoun as! dNounPhrase
                let npPerson = hnp.getPerson()
                hvp.setPerson(value: hnp.getPerson())
                let vpPerson = hvp.getPerson()
                print("InformHeadVerb: npPerson \(npPerson) ... vpPerson \(vpPerson)")
                print("... tense = \(hvp.getTense())")
            }
        }
    }
    
    func findNextLocationOfSymbolInClusterList(sym : ContextFreeSymbol, startIndex : Int)->Int{
        let clusterList = sentence.getClusterList()
        for i in startIndex ..< sentence.getClusterCount() {
            let clusterSym = clusterList[i].getClusterType()
            if  clusterSym == sym{
                return i
            }
        }
        return -1
    }
    
    func clauseHasOptionalMultipleRule(cfRule : ContextFreeRule, startIndex : Int)->Int{
        let cfSymbolStructCount = cfRule.getSymbolStructCount()
        var minMatchCount = 0
        var matchCount = 0
        
        let symStrList = cfRule.getSymbolStrList()
        let headWordStruct = cfRule.getHeadCFSymbolStruct()
        let clusterCount = sentence.getClusterCount()
        let clusterList = sentence.getClusterList()
        var newPhrase : dPhrase
        
        //first, find location of the head struct
        //also, get minimum match count, considering optionals
        
        var headLocation = 0
        
        for j in 0 ..< cfSymbolStructCount{
            let str = symStrList[j]
            if !str.isOptional(){
                minMatchCount += 1
            }
            
            if ( str.isHead() ){
                headLocation = j
                matchCount = 1
            }
            
            
        }
        
        //find the start location in the cluster list that matches the headWordStruct
        
        
        let clusterHeadLocation = findNextLocationOfSymbolInClusterList(sym: cfRule.getHeadSymbol(), startIndex : 0)
        
        //if no symbol found in cluster for this rule, then exit
        if ( clusterHeadLocation < 0 ){return -1}
        
        let offset = clusterHeadLocation - headLocation
        if ( offset < 0 ){return -1}
        let headCluster = clusterList[clusterHeadLocation]
        
        
        matchCount = 0
        var clusterIndex = 0
        var firstClusterIndex = 0
        for symIndex in 0 ..< symStrList.count {
            clusterIndex = symIndex + offset
            if ( clusterIndex < clusterCount)
            {
                let ruleSymbol = symStrList[symIndex].getSymbol()
                let clusterSymbol = clusterList[clusterIndex].getClusterType()
                if ruleSymbol == clusterSymbol {
                    if ( matchCount == 0 ){  firstClusterIndex = clusterIndex      }
                    matchCount += 1
                }
            }
            else { break }
        }
        
        
        if ( matchCount >= minMatchCount){
            switch headWordStruct.getSymbol(){
            case .NP:
                newPhrase = dNounPhrase(word: headWordStruct.getWord(), data: headCluster.getSentenceData())
            case .VP:
                newPhrase = dVerbPhrase(word: headWordStruct.getWord(), data: headCluster.getSentenceData())
            case .PP:
                newPhrase = dPrepositionPhrase(word: headWordStruct.getWord(), data: headCluster.getSentenceData())
            default:
                newPhrase = dPhrase()
            }
            
            for j in 0 ..< matchCount{
                let c = clusterList[firstClusterIndex+j]
                newPhrase.appendCluster(cluster: c)
            }
            
            //inform the component singles (if any) of the noun phrase's number and gender
            if ( newPhrase.getClusterType() == .NP ){
                let np = newPhrase as! dNounPhrase
                np.reconcile()
            }
            
            let lastIndex = firstClusterIndex + matchCount-1
            sentence.replaceClusterRange(firstIndex: firstClusterIndex, lastIndex: lastIndex , cluster: newPhrase)
            return firstClusterIndex + 1
        }
        return -1
    }
    
    
    func printClusters(){
        print("Clause - analyze - Cluster count = \(sentence.getClusterCount())")
        for  cluster in sentence.getClusterList() {
            if cluster.getClusterType().isSingle()
            {
                let single = cluster as! dSingle
                let clusterType = cluster.getClusterType()
                let singleString = single.getString()
                print("single: \(singleString) - single wordType: \(clusterType)")
            }
            else if cluster.getClusterType().isPhrase()
            {
                let phrase = cluster as! dPhrase
                print("phrase: \(phrase.getString()) - phrase wordType: \(cluster.getClusterType())")
            }
        }
        print(" ")
        print(" ")
    }
    
    func checkForNounPhrases(){
        let grammar = grammarLibrary.nounPhraseGrammar
        var startIndex = 0
        
        for rule in grammar.cfRuleList {
            var index = 0
            while index >= 0 && index < sentence.getClusterCount() {
                index = clauseHasOptionalMultipleRule(cfRule: rule, startIndex:startIndex)
                if ( index > 0 ){startIndex = index}
            }
        }
        print("Sentence.Analyze: after noun phrase rule count = \(sentence.getClusterCount())")
    }
    
    func checkForVerbPhrases(){
        let grammar = grammarLibrary.verbPhraseGrammar
        var startIndex = 0
        
        for rule in grammar.cfRuleList {
            var index = 0
            while index >= 0 && index < sentence.getClusterCount() {
                index = clauseHasOptionalMultipleRule(cfRule: rule, startIndex:startIndex)
                if ( index > 0 ){startIndex = index}
            }
        }
        print("Sentence.Analyze: after verb phrase rule count = \(sentence.getClusterCount())")
    }
    
    func checkForPrepositionPhrases(){
        let grammar = grammarLibrary.prepositionalPhraseGrammar
        var startIndex = 0
        
        for rule in grammar.cfRuleList {
            var index = 0
            while index >= 0 && index < sentence.getClusterCount() {
                index = clauseHasOptionalMultipleRule(cfRule: rule, startIndex:startIndex)
                if ( index > 0 ){startIndex = index}
            }
        }
        print("Sentence.Analyze: after preposition phrase rule count = \(sentence.getClusterCount())")
    }
    
    func breakUpContraction()->Bool{
        var contractionFound = false
        switch m_language {
        
        case .English:
            // break up don'ts and won'ts, etc
            contractionFound = false
        case .Spanish:
            // break up don'ts and won'ts, etc
            contractionFound = false
        case .French:
            // break up don'ts and won'ts, etc
            contractionFound = false           
        case .Italian:
            // break up don'ts and won'ts, etc
            contractionFound = false
        case .Portuguese, .Agnostic:
            // break up don'ts and won'ts, etc
            contractionFound = false
        }
        return contractionFound
    }
    
    func createSinglesFromWordList(){
        if ( clauseList.isEmpty ){
            let cfHead = ContextFreeSymbolStruct(cfs : .S, word: Word() )
            let sentenceClause = WordRuleManager(phraseType: .S,
                                                 cfss: cfHead)
            clauseList.append(sentenceClause)
        }
        
        var single = dSingle()
        
        for data in dataList {
            let word = data.word
            switch data.data.wordType {
            case .adjective:
                single = dAdjectiveSingle(word: word, data: data.data)
            case .adverb:
                single = dAdverbSingle(word:word, data: data.data)
            case .ambiguous:
                single = dAmbiguousSingle(word: word, data: data.data)
            case .article:
                single = dArticleSingle(word: word, data: data.data)
            case .conjunction:
                single = dConjunctionSingle(word: word, data: data.data)
            case .determiner:
                single = dDeterminerSingle(word: word, data: data.data)
            case .noun:
                single = dNounSingle(word: word, data: data.data)
            case .number:
                single = dAdjectiveSingle(word: word, data: data.data)
            case .pronoun:
                single = dSubjectPronounSingle(word: word, data: data.data)
            case .preposition:
                single = dPrepositionSingle(word: word, data: data.data)
            case .punctuation:
                single = dPunctuationSingle(word: word, data: data.data)
            case .verb:
                switch m_language{
                case .Spanish:
                    single = dSpanishVerbSingle(word: word, data: data.data)
                case .French:
                    single = dFrenchVerbSingle(word: word, data: data.data)
                case .Italian, .English, .Portuguese, .Agnostic:
                    single = dVerbSingle(word: word, data: data.data)
                }
                
            default:
                single = dUnknownSingle(word: word, data: data.data)
            }
            
            sentence.appendCluster(cluster: single)
            
        }
        print("createClustersFromWordList - Single count = \(sentence.getClusterCount())")
        
    }//sentence
    
    func processInfo(){
        print("dIndependentClause: cluster count = \(sentence.getClusterList().count)")
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
                 .Det, .Num, .PersPro, .P, .V, .SubjP, .AuxV, .UNK :
                continue
            case .NP:
                let c = cluster as! dNounPhrase
                c.processInfo()
            case .PP:
                let c = cluster as! dPrepositionPhrase
                c.processInfo()
            case .VP:
                let c = cluster as! dVerbPhrase
                c.processInfo()
            default: break
            }
        }
    }
    
    func getWordStateDataList()->[WordStateData]{
        var wordStateList = [WordStateData]()
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
                 .Det, .Num, .PersPro, .P, .V, .SubjP, .AuxV, .UNK :
                wordStateList.append(cluster.getSentenceData())
            case .NP:
                let c = cluster as! dNounPhrase
                wordStateList = c.getWordStateList(inputWordList: wordStateList)
            case .PP:
                let c = cluster as! dPrepositionPhrase
                wordStateList = c.getWordStateList(inputWordList: wordStateList)
            case .VP:
                let c = cluster as! dVerbPhrase
                wordStateList = c.getWordStateList(inputWordList: wordStateList)
            default: break
            }
        }
        return wordStateList
    }
    
    func dumpNounPhraseData(){
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .NP:
                let c = cluster as! dNounPhrase
                c.dumpClusterInfo(str: "dumpNounPhraseData:")
            default: break
            }
        }
    }
    
    func getSingleList()->[dSingle]{
        
        dumpNounPhraseData()
        
        var singleList = [dSingle]()
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
                 .Det, .Num, .PersPro, .P, .V, .SubjP, .AuxV, .UNK :
                let single = cluster as! dSingle
                singleList.append(single)
            case .NP:
                let c = cluster as! dNounPhrase
                c.dumpClusterInfo(str: "getSingleList NP:")
                singleList = c.getSingleList(inputSingleList: singleList)
            case .PP:
                let c = cluster as! dPrepositionPhrase
                singleList = c.getSingleList(inputSingleList: singleList)
            case .VP:
                let c = cluster as! dVerbPhrase
                singleList = c.getSingleList(inputSingleList: singleList)
            default: break
            }
        }
        return singleList
    }
    
    func getReconstructedSentenceString()->String {
        var ss = ""
        var str = ""
        //print ("getReconstructedSentenceString - dataList count = \(dataList.count)")
        
        for cluster in sentence.getClusterList() {
            
            switch cluster.getClusterType() {
            case .Adj:
                let c = cluster as! dAdjectiveSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .AdjCls:
                let c = cluster as! dAdjectiveSingle //for now
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .Adv:
                let c = cluster as! dAdverbSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .AdvP:
                let c = cluster as! dAdverbPhrase
                str = c.getString()
            //               c.getSentenceData().processedWord = c.getString()
            case .AMB:
                let c = cluster as! dAmbiguousSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .Art:
                let c = cluster as! dArticleSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .C:
                let c = cluster as! dConjunctionSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .comma:
                let c = cluster as! dPunctuationSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .Det:
                let c = cluster as! dDeterminerSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .N:
                let c = cluster as! dNounSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .NP:
                let c = cluster as! dNounPhrase
                c.reconcile()  //informs all member clusters of number, gender, etc
                str = c.getString()
            case .Num:
                let c = cluster as! dNumberSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .PersPro:
                let c = cluster as! dPersonalPronounSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .P:
                let c = cluster as! dPrepositionSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .PP:
                let c = cluster as! dPrepositionPhrase
                str = c.getString()
            case .SubjP:
                let c = cluster as! dSubjectPronounSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .V:
                let c = cluster as! dVerbSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .VP:
                let c = cluster as! dVerbPhrase
                str = c.getString()
            case .AuxV:
                let c = cluster as! dVerbSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            case .UNK:
                let c = cluster as! dUnknownSingle
                str = c.getString()
                cluster.setProcessWordInWordStateData(str: c.getString())
            default:
                str = ""
                
            }
            ss += str + " "
            
        }
        
        return ss
    }
    
}
