//
//  dAgnosticIndependentClause.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/25/21.
//

import Foundation

class dIndependentAgnosticClause : dClause {
    var grammarLibrary = CFGrammarLibrary()
    var originalSentenceString = String()
    var processedSentenceString = ""
    //var dataList = Array<SentenceData>()
    //var clauseList = Array<WordRuleManager>()
    var currentWordRuleIndex = 0
    var sentence = dSentence()
    var headNoun = dCluster(word: Word(), clusterType: .UNK)
    var headVerb = dCluster(word: Word(), clusterType: .UNK)
    
    override func appendCluster(cluster: dCluster){
        sentence.appendCluster(cluster: cluster)
    }
    
    func processInfo(){
        print("dIndependentAgnosticClause: cluster count = \(sentence.getClusterList().count)")
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
    
    func setTenseAndPersonAndCreateNewSentenceString(language: LanguageType, tense: Tense, person: Person)->String{
        if ( headVerb.getClusterType() != .UNK){
            let hvp = headVerb as! dVerbPhrase
            hvp.setTense(value: tense)
            hvp.setPerson(value: person)
        }
        
        if ( headNoun.getClusterType() != .UNK){
            let hnp = headNoun as! dNounPhrase
            hnp.setPerson(value: person)
        }
        return createNewSentenceString(language: language)
    }
    
    func createNewSentenceString(language: LanguageType)->String{
        var sentenceString = getReconstructedSentenceString(language: language)
        sentenceString = VerbUtilities().makeSentenceByEliminatingExtraBlanksAndDoingOtherStuff(characterArray: sentenceString)
        return sentenceString
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
    
    func getSingleList()->[dSingle]{
        
        dumpNounPhraseData()
        
        var singleList = [dSingle]()
        var clusterIndex = 0
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
                 .Det, .Num, .PersPro, .P, .V, .SubjP, .AuxV, .UNK :
                let single = cluster as! dSingle
                print("clusterIndex \(clusterIndex): \(single.getProcessWordInWordStateData(language: .Spanish))")
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
            clusterIndex += 1
        }
        return singleList
    }
 
    func getReconstructedSentenceString(language: LanguageType)->String {
        var ss = ""
        var str = ""
        //print ("getReconstructedSentenceString - dataList count = \(dataList.count)")
    
        for cluster in sentence.getClusterList() {
            
            switch cluster.getClusterType() {
            case .NP:
                let c = cluster as! dNounPhrase
                c.reconcileForLanguage(language: language)  //informs all member clusters of number, gender, etc
                str = c.getStringAtLanguage(language: language)
            case .PP:
                let c = cluster as! dPrepositionPhrase
                str = c.getStringAtLanguage(language: language)
            case .VP:
                let c = cluster as! dVerbPhrase
                str = c.getStringAtLanguage(language: language)
            default:
                str = ""
                
            }
            ss += str + " "
            
        }
        
        return ss
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
    
}
