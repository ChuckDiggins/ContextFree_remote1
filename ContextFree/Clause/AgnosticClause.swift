////
////  NewIndependentAgnosticClause.swift
////  NewIndependentAgnosticClause
////
////  Created by Charles Diggins on 1/22/22.
////
//// -- This can be contain anything from a single word phrase
////    to a full independent clause (containing head noun and head verb)
////
//
//
//
//import Foundation
//
//class AgnosticClause : dClause{
//    var headNoun = dCluster(word: Word(), clusterType: .UNK)
//    var headVerb = dCluster(word: Word(), clusterType: .UNK)
//    var m_cfMorphStruct = CFMorphStruct()
//    
//    var singleList: [dSingle]?
//    
//    func initializeMorphStructs(){
//        m_cfMorphStruct.clear()
//    }
//    
//    func copy(inClause :AgnosticClause){
//        clearClusterList()
//        for cluster in inClause.getClusterList() {
//            appendCluster(cluster: cluster)
//        }
//        setHeadNounAndHeadVerb()
//    }
//    
//    //if this has a head noun and a head verb ...
//    
//    func setHeadNounAndHeadVerb(){
//        for cluster in getClusterList(){
//            //for now assume that the first NP is the head noun
//            //let hct = headNoun.getClusterType()
//            if cluster.getClusterType() == .NP && headNoun.getClusterType() == .UNK {
//                //print("setting head noun phrase")
//                headNoun = cluster
//            }
//            //let hcv = headVerb.getClusterType()
//            if cluster.getClusterType() == .VP && headVerb.getClusterType() == .UNK {
//                //print("setting head verb phrase")
//                headVerb = cluster
//            }
//        }
//        informHeadVerb()
//    }
//    
//    //this has the head NP inform the head VP about person
//    
//    func hasHeadVerb()->Bool{
//        if headVerb.getClusterType() == .V || headVerb.getClusterType() == .VP {return true}
//        return false
//        
//    }
//    
//    func hasHeadNoun()->Bool{
//        if headNoun.getClusterType() == .N || headNoun.getClusterType() == .NP {return true}
//        return false
//    }
//    
//    func informHeadVerb(){
//        if hasHeadVerb() && hasHeadNoun() {
//            let hvp = headVerb as! dVerbPhrase
//            if  headNoun.getClusterType() == .N || headNoun.getClusterType() == .PersPro {hvp.setPerson(value: headNoun.getPerson())}
//            else if headNoun.getClusterType() == .NP {
//                let hnp = headNoun as! dNounPhrase
//                //let npPerson = hnp.getPerson()
//                hvp.setPerson(value: hnp.getPerson())
//                //let vpPerson = hvp.getPerson()
////                print("InformHeadVerb: npPerson \(npPerson) ... vpPerson \(vpPerson)")
////                print("... tense = \(hvp.getTense())")
////
//                //inform the clause...
//                setGender(value: hnp.getGender())
//                setPerson(value: hnp.getPerson())
//            }
//        }
//    }
//    func setTenseAndPerson(tense: Tense, person: Person){
//        if ( headVerb.getClusterType() != .UNK){
//            let hvp = headVerb as! dVerbPhrase
//            hvp.setTense(value: tense)
//            hvp.setPerson(value: person)
//        }
//        
//        if ( headNoun.getClusterType() != .UNK){
//            let hnp = headNoun as! dNounPhrase
//            hnp.setPerson(value: person)
//            hnp.m_isSubject = true
//        }
//    }
//    
//    func processInfo(){
//        print("AgnosticClause: cluster count = \(getClusterList().count)")
//        for cluster in getClusterList(){
//            switch cluster.getClusterType() {
//            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
//                 .Det, .Num, .PersPro, .P, .V, .AuxV, .UNK :
//                continue
//            case .NP:
//                let c = cluster as! dNounPhrase
//                c.processInfo()
//                if c.m_isSubject {
//                    setPerson(value: c.getPerson())
//                }
//            case .PP:
//                let c = cluster as! dPrepositionPhrase
//                c.processInfo()
//            case .VP:
//                let c = cluster as! dVerbPhrase
//                c.processInfo()
//            default: break
//            }
//        }
//    }
//
//    func createNewSentenceString(language: LanguageType)->String{
//        var sentenceString = getReconstructedSentenceString(language: language)
//        sentenceString = VerbUtilities().makeSentenceByEliminatingExtraBlanksAndDoingOtherStuff(characterArray: sentenceString)
//        return sentenceString
//    }
//    
//    func getReconstructedSentenceString(language: LanguageType)->String {
//        var ss = ""
//        var str = ""
//    
//        for cluster in getClusterList() {
//            let type = cluster.getClusterType()
//            switch type {
//            case .NP:
//                let c = cluster as! dNounPhrase
//                c.reconcileForLanguage(language: language)  //informs all member clusters of number, gender, etc
//                str = c.getStringAtLanguage(language: language)
//            case .PP:
//                let c = cluster as! dPrepositionPhrase
//                str = c.getStringAtLanguage(language: language)
//            case .VP:
//                let c = cluster as! dVerbPhrase
//                str = c.getStringAtLanguage(language: language)
//            default:
//                str = ""
//                
//            }
//            ss += str + " "
//        }
//        return ss
//    }
//    
//    func getSingleList()->[dSingle]{
//        var singleList = [dSingle]()
//        var clusterIndex = 0
//        //let count = sentence.getClusterList().count
//        
//        for cluster in getClusterList(){
//            switch cluster.getClusterType() {
//            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
//                 .Det, .Num, .PersPro, .P, .V, .AuxV, .UNK :
//                let single = cluster as! dSingle
//                //print("clusterIndex \(clusterIndex): \(single.getProcessWordInWordStateData(language: .Spanish))")
//                singleList.append(single)
//            case .NP:
//                let c = cluster as! dNounPhrase
//                //c.dumpClusterInfo(str: "getSingleList NP:")
//                singleList = c.getSingleList(inputSingleList: singleList)
//            case .PP:
//                let c = cluster as! dPrepositionPhrase
//                singleList = c.getSingleList(inputSingleList: singleList)
//            case .VP:
//                let c = cluster as! dVerbPhrase
//                singleList = c.getSingleList(inputSingleList: singleList)
//            default: break
//            }
//            clusterIndex += 1
//        }
//        return singleList
//    }
//    
//    func getSingleStringList(language: LanguageType)->[String]{
//        var singleStringList = [String]()
//        for single in getSingleList(){
//            singleStringList.append(single.getProcessWordInWordStateData(language: language))
//        }
//        return singleStringList
//    }
// 
//    func getWordTypeList()->[String]{
//        var wordTypeList = [String]()
//        for single in getSingleList(){
//            wordTypeList.append(single.getWordType().rawValue)
//        }
//        return wordTypeList
//    }
//    
//    func getWordString(language: LanguageType, single: dSingle)->String{
//        if single.isPersonalPronounType(){
//            let ppSingle = single as! dPersonalPronounSingle
//            return ppSingle.getWordStringAtLanguage(language: language)
//        }
//        return single.getProcessWordInWordStateData(language: language) + " "
//    }
//    
//   
// 
//}
