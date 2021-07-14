//
//  SentenceParser.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import Foundation

struct VerbSettings{
    var tense : Tense
    var person : Person
}

struct NounSettings{
    var number : Number
}



struct SentenceData {
    var word = Word()
    var data = WordStateData()
}

struct Sentence  {
    var grammarLibrary = CFGrammarLibrary()
    var originalSentenceString : String
    var dataList : Array<SentenceData>
    var clauseList = Array<WordRuleManager>()
    var currentWordRuleIndex = 0
    var sentence = dSentence()
    
    //var wordObjectList = Array<Word>()
    //var sentenceWordData = Array<SentenceWordData>()  //current information about each word

    init(sentenceString: String, data: Array<SentenceData>){
        self.originalSentenceString = sentenceString
        self.dataList = data
    }
    
    mutating func setGrammarLibrary(cfLib : CFGrammarLibrary){
        grammarLibrary = cfLib
    }

    mutating func getCurrentRuleManager()->WordRuleManager{
        return clauseList[currentWordRuleIndex]
    }
    
    mutating func setCurrentWordRuleManager(mgr : WordRuleManager){
        clauseList[currentWordRuleIndex] = mgr
    }
    
    mutating func appendWord(data: SentenceData){
        dataList.append(data)
    }
    
    func getWordList()-> (Array<Word>){
        var wordList = Array<Word>()
        
        for data in dataList {
            wordList.append( data.word )
        }
        return wordList
    }
    
    mutating func getCurrentCFRuleListCount()->Int{
        return getCurrentRuleManager().ruleList.count
    }
    
    mutating func getCurrentCFRuleList()->Array<ContextFreeRule>{
        return getCurrentRuleManager().ruleList
    }
    
    mutating func analyze(){
        if clauseList.isEmpty{
            print("sentence clauseList is empty")
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

            print("Reconstructed Sentence: \(getReconstructedSentenceString())")
            
        }
    }
    
    mutating func findNextLocationOfSymbolInClusterList(sym : ContextFreeSymbol, startIndex : Int)->Int{
        let clusterList = sentence.getClusterList()
        for i in startIndex ..< sentence.getClusterCount() {
            let clusterSym = clusterList[i].getClusterType()
            if  clusterSym == sym{
                return i
            }
        }
        return -1
    }
    
    mutating func sentenceHasOptionalMultipleRule(cfRule : ContextFreeRule, startIndex : Int)->Int{
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
        

    mutating func printClusters(){
        print("Sentence - analyze - Cluster count = \(sentence.getClusterCount())")
        for  cluster in sentence.getClusterList() {
            if cluster.getClusterType().isSingle()
            {
                let single = cluster as! dSingle
                print("single: \(single.getString()) - single wordType: \(cluster.getClusterType())")
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
    
    mutating func checkForNounPhrases(){
        let grammar = grammarLibrary.nounPhraseGrammar
        var startIndex = 0
        
        for rule in grammar.cfRuleList {
            var index = 0
            while index >= 0 && index < sentence.getClusterCount() {
                index = sentenceHasOptionalMultipleRule(cfRule: rule, startIndex:startIndex)
                if ( index > 0 ){startIndex = index}
            }
        }
        print("Sentence.Analyze: after noun phrase rule count = \(sentence.getClusterCount())")
    }
    
    mutating func checkForVerbPhrases(){
        let grammar = grammarLibrary.verbPhraseGrammar
        var startIndex = 0

        for rule in grammar.cfRuleList {
            var index = 0
            while index >= 0 && index < sentence.getClusterCount() {
                index = sentenceHasOptionalMultipleRule(cfRule: rule, startIndex:startIndex)
                if ( index > 0 ){startIndex = index}
            }
        }
        print("Sentence.Analyze: after verb phrase rule count = \(sentence.getClusterCount())")
    }

    mutating func checkForPrepositionPhrases(){
        let grammar = grammarLibrary.prepositionalPhraseGrammar
        var startIndex = 0

        for rule in grammar.cfRuleList {
            var index = 0
            while index >= 0 && index < sentence.getClusterCount() {
                index = sentenceHasOptionalMultipleRule(cfRule: rule, startIndex:startIndex)
                if ( index > 0 ){startIndex = index}
            }
        }
        print("Sentence.Analyze: after preposition phrase rule count = \(sentence.getClusterCount())")
    }

    
        mutating func createClustersFromWordList(){
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
                single = dPersonalPronounSingle(word: word, data: data.data)
            case .preposition:
                single = dPrepositionSingle(word: word, data: data.data)
            case .verb:
                single = dVerbSingle(word: word, data: data.data)
            default:
                single = dUnknownSingle(word: word, data: data.data)
            }
            
            sentence.appendCluster(cluster: single)
            
            }
        print("createClustersFromWordList - Single count = \(sentence.getClusterCount())")
        for  cluster in sentence.getClusterList() {
            let single = cluster as! dSingle
            print("single: \(single.getString()) - single wordType: \(cluster.getClusterType())")
        }
 
        }//sentence
        
   
    mutating func getReconstructedSentenceString()->String {
        var ss = ""
        var str = ""
        //print ("getReconstructedSentenceString - dataList count = \(dataList.count)")
        
        for cluster in sentence.getClusterList() {
            
            switch cluster.getClusterType() {
            case .Adj:
                let c = cluster as! dAdjectiveSingle
                str = c.getString()
            case .AdjCls:
                let c = cluster as! dAdjectiveSingle //for now
                str = c.getString()
            case .Adv:
                let c = cluster as! dAdverbSingle
                str = c.getString()
            case .AdvP:
                let c = cluster as! dAdverbPhrase
                str = c.getString()
            case .AMB:
                let c = cluster as! dAmbiguousSingle
                str = c.getString()
            case .Art:
                let c = cluster as! dArticleSingle
                str = c.getString()
            case .C:
                let c = cluster as! dConjunctionSingle
                str = c.getString()
            case .comma:
                let c = cluster as! dPunctuationSingle
                str = c.getString()
            case .Det:
                let c = cluster as! dDeterminerSingle
                str = c.getString()
            case .N:
                let c = cluster as! dNounSingle
                str = c.getString()
            case .NP:
                let c = cluster as! dNounPhrase
                //c.reconcile()  //informs all member clusters of number, gender, etc
                str = c.getString()
            case .Num:
                let c = cluster as! dNumberSingle
                str = c.getString()
            case .PersPro:
                let c = cluster as! dPersonalPronounSingle
                str = c.getString()
            case .P:
                let c = cluster as! dPrepositionSingle
                str = c.getString()
            case .PP:
                let c = cluster as! dPrepositionPhrase
                str = c.getString()
            case .PersPro:
                let c = cluster as! dPersonalPronounSingle
                str = c.getString()
            case .V:
                let c = cluster as! dVerbSingle
                str = c.getString()
            case .VP:
                let c = cluster as! dPhrase
                str = c.getString()
            case .AuxV:
                let c = cluster as! dVerbSingle
                str = c.getString()
            case .UNK:
                let c = cluster as! dUnknownSingle
                str = c.getString()
            default:
                str = ""
                
            }
            ss += str + " "
       
        }
        return ss
    }

}
