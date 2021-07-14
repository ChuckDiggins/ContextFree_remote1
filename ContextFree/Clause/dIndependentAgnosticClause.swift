//
//  dAgnosticIndependentClause.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/25/21.
//

import Foundation

class dIndependentAgnosticClause : dClause {
    var grammarLibrary = CFGrammarLibrary()
    var frenchGrammarLibrary = CFGrammarLibrary()
    var originalSentenceString = String()
    var processedSentenceString = ""
    //var dataList = Array<SentenceData>()
    //var clauseList = Array<WordRuleManager>()
    var currentWordRuleIndex = 0
    var sentence = dSentence()
    var headNoun = dCluster(word: Word(), clusterType: .UNK)
    var headVerb = dCluster(word: Word(), clusterType: .UNK)
    var m_cfMorphStruct = CFMorphStruct()
    
    var workingSingleList = [dSingle]()
    
    override func appendCluster(cluster: dCluster){
        let ct = cluster.getClusterType()
        sentence.appendCluster(cluster: cluster)
    }
    
    func initializeMorphStructs(){
        m_cfMorphStruct.clear()
    }
    
    func copy(inClause :dIndependentAgnosticClause){
        sentence.clearClusterList()
        for cluster in inClause.sentence.getClusterList() {
            sentence.appendCluster(cluster: cluster)
        }
        setHeadNounAndHeadVerb()
    }
    
    func convertRomancePhraseOrderToEnglishPhraseOrder(){
        let cfMap = ContextFreeMapping()
        let newSentence = dSentence()
        
        for cluster in sentence.getClusterList() {
            switch cluster.getClusterType() {
            case .NP:
                let c = cluster as! dNounPhrase
                newSentence.appendCluster(cluster: cfMap.fromRomanceNPToEnglishNP(fromNP: c))
            case .PP:
                let c = cluster as! dPrepositionPhrase
                newSentence.appendCluster(cluster: cfMap.fromRomancePPToEnglishPP(fromPP: c))
            case .VP:
                let c = cluster as! dVerbPhrase
                newSentence.appendCluster(cluster: cfMap.fromRomanceVPToEnglishVP(fromVP: c))
            default:
                newSentence.appendCluster(cluster: cluster)
            }
            
        }
        sentence = newSentence
    }
    
    func convertSubjectPronoun(language: LanguageType, inputMorphStruct: CFMorphStruct)->CFMorphStruct{
        var workingMorphStruct = inputMorphStruct
        var morph = CFMorphStep()
        
        //find the subject phrase
        if ( headNoun.getClusterType() != .UNK){
            let hnp = headNoun as! dNounPhrase
            //hnp.getStringAtLanguage(language: language)()
        }
        
        //get the subject phrase as pronoun, if necessary
        
        //replace phrase with pronoun
        
        return workingMorphStruct
    }
    
    func convertDirectObjectPronoun(inputMorphStruct: CFMorphStruct)->CFMorphStruct{
        var workingMorphStruct = inputMorphStruct
        var morph = CFMorphStep()
        
        //find the direct-object phrase
        
        //get the direct-object phrase as pronoun, if necessary
        
        //replace phrase with pronoun
        
        //move before verb
        
        return workingMorphStruct
    }
    
    func convertIndirectObjectPronoun(inputMorphStruct: CFMorphStruct)->CFMorphStruct{
        var workingMorphStruct = inputMorphStruct
        var morph = CFMorphStep()
        
        //find the indirect-object phrase
        
        //get the indirect-object phrase as pronoun, if necessary
        
        //replace phrase with pronoun
        
        //move before verb
        
        return workingMorphStruct
    }
    
    func getCompositeSentenceString(language: LanguageType, targetFunction: ContextFreeFunction)->[dSingle] {
        var singleListBefore = Array<dSingle>()  //pre target
        var targetSingleList = Array<dSingle>()
        var singleListAfter = Array<dSingle>()  //after target

        // first find the start index of the target function
        
        var workingSingleList = [dSingle]()
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .NP:
                let nounPhrase = cluster as! dNounPhrase
                if nounPhrase.getClusterFunction() == targetFunction {
                    targetSingleList = nounPhrase.getSingleList(inputSingleList: targetSingleList)
                }
            case .VP:
                let verbPhrase = cluster as! dVerbPhrase
                for vc in verbPhrase.getClusterList() {
                    if vc.getClusterType() == .PP {
                        let prepPhrase = vc as! dPrepositionPhrase
                        if prepPhrase.getClusterFunction() == targetFunction {
                            targetSingleList = prepPhrase.getSingleList(inputSingleList: targetSingleList)
                            break
                        }
                    }
                    else if vc.getClusterType() == .NP {
                        let nounPhrase = vc as! dNounPhrase
                        if nounPhrase.getClusterFunction() == targetFunction {
                            targetSingleList = nounPhrase.getSingleList(inputSingleList: targetSingleList)
                            break
                        }
                    }
                }
            default: continue
            }
        }
        
        return targetSingleList
    }
    
    
    func processInfo(){
        //print("dIndependentAgnosticClause: cluster count = \(sentence.getClusterList().count)")
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
                 .Det, .Num, .PersPro, .P, .V, .AuxV, .UNK :
                continue
            case .NP:
                let c = cluster as! dNounPhrase
                c.processInfo()
                if c.m_isSubject {
                    setPerson(value: c.getPerson())
                }
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
    
    
    func getSubjectPronounString(language: LanguageType)->String{
        if ( headNoun.getClusterType() != .UNK){
            let hnp = headNoun as! dNounPhrase
            return hnp.getEquivalentSubjectPronounString(language: language)
        }
        return ""
    }

    func getDirectObjectPronounString(language: LanguageType)->String{
        let hvp = headVerb as! dVerbPhrase
        if hvp.hasClusterFunction(fn: .DirectObject){
            let c = hvp.getClusterAtFunction(fn: .DirectObject)
            let dp = c as! dPhrase
            return dp.getEquivalentDirectObjectPronounString(language: language)
        }
        return ""
    }
    
    func getIndirectObjectPronounString(language: LanguageType)->String{
        let hvp = headVerb as! dVerbPhrase
        if hvp.hasClusterFunction(fn: .IndirectObject){
            let c = hvp.getClusterAtFunction(fn: .IndirectObject)
            let dp = c as! dPhrase
            return dp.getEquivalentIndirectObjectPronounString(language: language)
        }
        return ""
    }
    
    func getPronounString(language: LanguageType, phrase: dPhrase, fn: ContextFreeFunction)->String{
        return phrase.getEquivalentPronounString(language: language, fn: fn)
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
            if  headNoun.getClusterType() == .N || headNoun.getClusterType() == .PersPro {hvp.setPerson(value: headNoun.getPerson())}
            else if headNoun.getClusterType() == .NP {
                let hnp = headNoun as! dNounPhrase
                let npPerson = hnp.getPerson()
                hvp.setPerson(value: hnp.getPerson())
                let vpPerson = hvp.getPerson()
                print("InformHeadVerb: npPerson \(npPerson) ... vpPerson \(vpPerson)")
                print("... tense = \(hvp.getTense())")
                
                //inform the clause...
                setGender(value: hnp.getGender())
                setPerson(value: hnp.getPerson())
            }
        }
    }
    
    func setWorkingSingleList(singleList: [dSingle]){
        workingSingleList = singleList
    }
    
    func getWorkingSingleList()->[dSingle]{
        return workingSingleList
    }
    
    func getSingleList()->[dSingle]{
        var singleList = [dSingle]()
        var clusterIndex = 0
        let count = sentence.getClusterList().count
        
        for cluster in sentence.getClusterList(){
            switch cluster.getClusterType() {
            case .Adj, .AdjCls, .Adv, .AMB, .Art, .C, .comma,
                 .Det, .Num, .PersPro, .P, .V, .AuxV, .UNK :
                let single = cluster as! dSingle
                //print("clusterIndex \(clusterIndex): \(single.getProcessWordInWordStateData(language: .Spanish))")
                singleList.append(single)
            case .NP:
                let c = cluster as! dNounPhrase
                //c.dumpClusterInfo(str: "getSingleList NP:")
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
            let type = cluster.getClusterType()
            switch type {
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