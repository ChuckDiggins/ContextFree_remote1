////
////  AgnosticClauseExtras.swift
////  AgnosticClauseExtras
////
////  Created by Charles Diggins on 1/22/22.
////
//
//import Foundation
//
//struct AgnosticClauseProcesses{
//    var m_clause = AgnosticClause()
//    var m_englishClause = AgnosticClause()
//    
//    func dumpClause(clause: AgnosticClause){
//        let tempSingleList = clause.getSingleList()
//        for single in tempSingleList {
//            print("clauseManipulation: \(single.getClusterWord().word)")
//        }
//    }
//    
//    mutating func createRandomClause(cfModelView: CFModelView, tense: Tense, randomPhraseType: RandomPhraseType){
//        m_clause = cfModelView.getNewRandomAgnosticSentence(rft: randomPhraseType)
//        dumpClause(clause: m_clause)
// 
//        let currentPerson = m_clause.getPerson()
//        m_clause.setTenseAndPerson(tense: tense, person: currentPerson)
//        let fs  = m_clause.createNewSentenceString(language: .French)
//        print("French phrase: \(fs)")
//        let ss  = m_clause.createNewSentenceString(language: .Spanish)
//        print("Spanish phrase: \(ss)")
//        
//        m_englishClause.copy(inClause: m_clause)
//        convertRomancePhraseOrderToEnglishPhraseOrder()
//        let es  = m_englishClause.createNewSentenceString(language: .English)
//        print("English phrase: \(es)")
//        
//        var tempSingleList = m_clause.getSingleList()
//        for single in tempSingleList {
//            print("Before - createRandomClause: \(single.getClusterWord().word)")
//        }
//    }
//    
//    func changeWordInClause(cfModelView: CFModelView, single: dSingle, isSubject: Bool)->AgnosticClause{
//        var tempSingleList = [dSingle]()
//        
//        tempSingleList = m_clause.getSingleList()
//        for single in tempSingleList {
//            print("Before before - changeWordInClause: \(single.getClusterWord().word)")
//        }
//        let randomSentence = cfModelView.getRandomSentenceObject()
//        let tense = m_clause.getTense()
//        var person = m_clause.getPerson()
//        //let single = singleList[currentSingleIndex]
//        var wsd = single.getSentenceData()
//        
//        switch wsd.wordType {
//        case .PersPro:
//            //person = cfModelView.getNextPerson(currentPerson: person)
//            person = cfModelView.getNextPerson(currentPerson: person)
//            let newSingle = randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject: isSubject)
//            single.copyGuts(newSingle: newSingle)
//            if isSubject{
//                single.setPerson(value: person)
//                m_clause.setPerson(value: person)
//            }
//        case .V:
//            let newSingle = randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
//            newSingle.setPerson(value: person)
//            single.copyGuts(newSingle: newSingle)
//            person = single.getPerson()
//        case .Adj, .Det, .Adv, .C:
//            let newSingle = randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
//            //person = newSingle.getPerson()
//            single.copyGuts(newSingle: newSingle)
//            //person = single.getPerson()
//            m_clause.setPerson(value: person)
//        case .N:
//            let nounSingle = single as! dNounSingle
//            let newSingle = randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:nounSingle.isSubject())
//            nounSingle.copyGuts(newSingle: newSingle)
//            if nounSingle.isSubject() {
//                m_clause.setPerson(value: nounSingle.getPerson())
//                person = nounSingle.getPerson()
//            }
//        case .P:
//            let newSingle = randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
//            single.copyGuts(newSingle: newSingle)
//        default: break
//        }
//        wsd = single.getSentenceData()
//        m_clause.processInfo()
//
//        //these are for resetting various parameters for each language/sentence
////        var sentenceString : String!
//        m_clause.setTenseAndPerson(tense: tense, person: person)
//        _ = m_clause.createNewSentenceString(language: .Spanish)
//        _ = m_clause.createNewSentenceString(language: .French)
//        m_englishClause.setTenseAndPerson(tense: tense, person: person)
//        _ = m_englishClause.createNewSentenceString(language: .English)
//        
////        tempSingleList = clause.getSingleList()
////        for single in tempSingleList {
////            print("After after - changeWordInClause: \(single.getClusterWord().word)")
////        }
//        return m_clause
//    }
//    
//    enum FrenchContractionType{
//        case article, subject
//    }
//    
//    func handleFrenchContractions(singleList: [dSingle]){
//        
//        //never check last word, because there can't be a phonetic contraction
//        
//        for i in 0 ..< singleList.count-1 {
//            let single = singleList[i]
//            var wordStr = single.getWordStringAtLanguage(language: .French)
//            let nextWordStr = singleList[i+1].getProcessWordInWordStateData(language: .French)
//            let nextWordStartsWithVowelSound = VerbUtilities().startsWithVowelSound(characterArray: nextWordStr)
//            if nextWordStartsWithVowelSound {
//                switch wordStr {
//                case "le", "la", "je", "se", "ce", "de", "te", "me", "que":
//                    wordStr.removeLast()
//                    wordStr += "'"
//                    single.setProcessWordInWordStateData(language: .French, str: wordStr)
//                default: break
//                }
//            }
//        }
//    }
//    
//    func scanStringForContractionsAndStuff(inputString: String, findString: String, replacementString: String)->(Bool, String){
//        let newString = VerbUtilities().replaceSubstringInString(inputString: inputString, findString: findString, replacementString: replacementString)
//        
//        // if a strings, do not match then the new string has findString replaced with replacementString
//        
//        if newString != inputString { return (true, newString)}
//        else { return (false, inputString)}
//    }
//    
//    func handleContractions(language: LanguageType, wordList: [Word])->[Word]{
//
//        var wordListCopy = wordList
//        switch language {
//        case .Spanish:
//            let sw = SpanishWords()
//            var contractionFound  = true
//            while contractionFound {
//                for (i, word) in wordListCopy.enumerated() {
//                    let result = sw.isContraction(word: word.word)
//                    //if is contraction, then remove it and replace it
//                    if result.0 {
//                        wordListCopy.remove(at: i)
//                        let word1 = Word(word: result.2, wordType : .unknown)
//                        let word2 = Word(word: result.1, wordType : .unknown)
//                        wordListCopy.insert(word2, at:i)
//                        wordListCopy.insert(word1, at:i)
//                        contractionFound = true
//                        break
//                    }
//                    contractionFound = false
//                }
//            }
//        default:
//            return wordListCopy
//        }
//        return wordListCopy
//    }
//
//    func convertRomancePhraseOrderToEnglishPhraseOrder(){
//        let cfMap = ContextFreeMapping()
//        //let newSentence = dSentence()
//        let newCluster = dCluster()
//        
//        for cluster in m_clause.getClusterList() {
//            switch cluster.getClusterType() {
//            case .NP:
//                let c = cluster as! dNounPhrase
//                newCluster.appendCluster(cluster: cfMap.fromRomanceNPToEnglishNP(fromNP: c))
//            case .PP:
//                let c = cluster as! dPrepositionPhrase
//                newCluster.appendCluster(cluster: cfMap.fromRomancePPToEnglishPP(fromPP: c))
//            case .VP:
//                let c = cluster as! dVerbPhrase
//                newCluster.appendCluster(cluster: cfMap.fromRomanceVPToEnglishVP(fromVP: c))
//            default:
//                newCluster.appendCluster(cluster: cluster)
//            }
//            
//        }
//        m_englishClause.setClusterList(clusterList: newCluster.getClusterList())
//    }
//
////    func countStringLengths(clause: dIndependentAgnosticClause, englishClause: dIndependentAgnosticClause){
////        let singleList = clause.getSingleList()
////        let englishSingleList = englishClause.getSingleList()
////        var spanishStringLength = 0
////        var frenchStringLength = 0
////        var englishStringLength = 0
////        var singleIndex = 0
////        for single in singleList {
////            let frenchStr = single.getProcessWordInWordStateData(language: .French)
////            let spanishStr = single.getProcessWordInWordStateData(language: .Spanish)
////            let englishStr = single.getProcessWordInWordStateData(language: .English)
////            frenchStringLength += frenchStr.count
////            spanishStringLength += spanishStr.count
////            englishStringLength += englishStr.count
////        }
////
////        print("Spanish string length \(spanishStringLength)")
////        print("French string length \(frenchStringLength)")
////        print("English string length \(englishStringLength)")
////
////    }
//    
//}
//    
