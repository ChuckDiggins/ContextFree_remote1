//
//  Clause.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

class dClause : dCluster {
    
    override init(word: Word, clusterType : ContextFreeSymbol){
        super.init(word: word, clusterType: clusterType)
    }
    
    init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    var m_headSubjectCluster = dCluster(word: Word(), clusterType: .SubjP)
    var m_headNounCluster = dCluster(word: Word(), clusterType: .N)
    var m_headVerbCluster = dCluster(word: Word(), clusterType: .V)
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    //var m_clusterList = [dCluster]()
    var m_clusterList = Array<dCluster>()
    
    func clearClusterList(){m_clusterList.removeAll()}
    func getClusterList()->[dCluster]{ return m_clusterList}
    func appendCluster(cluster: dCluster){m_clusterList.append(cluster)}
    func deleteCluster(index: Int){if index < getClusterCount(){m_clusterList.remove(at : index)}}
    func insertCluster(index: Int, cluster : dCluster){m_clusterList.insert(cluster, at: index)}
    
    func replaceClusterRange(firstIndex: Int, lastIndex: Int, cluster: dCluster){
        for _ in firstIndex...lastIndex {
            deleteCluster(index: firstIndex)
        }
        insertCluster(index: firstIndex, cluster: cluster)
    }
    
    func replaceCluster(index: Int, cluster: dCluster){
        m_clusterList[index] = cluster
    }
    
    func getClusterCount()->Int{return m_clusterList.count}
    func getFirstCluster()->dCluster{ return m_clusterList[0] }
    func getLastCluster()->dCluster{ return m_clusterList[getClusterCount()-1] }
    func getFirstSingle()->dSingle{
        if getFirstCluster().getClusterType().isSingle() {
            //let single = getFirstCluster() as! dSingle
            return getFirstCluster() as! dSingle
        }
        return dSingle()
    }
    
    func getLastSingle()->dSingle{
        if getLastCluster().getClusterType().isSingle() {
            //let single = getFirstCluster() as! dSingle
            return getLastCluster() as! dSingle
        }
        return dSingle()
    }
    func setRule(rule: ContextFreeRule){m_cfr = rule}
    
    func getString( wordList : SentenceWordList)->String{
        var wordListCopy = wordList
        return wordListCopy.getString()
    }
}

class dAdverbialClause : dClause {
    
    override init(){
        super.init(word: Word(), clusterType: .AdjCls)
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .AdjCls)
    }
}

class dAdjectivalClause : dClause {
    
    override init(){
        super.init(word: Word(), clusterType: .AdjCls)
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .AdjCls)
    }
    
    //override init(){setWordType(value: .adjective)}
    
    var m_isComparative = false
    var m_isSuperlative = false
    var m_articleExists = false
    var m_compareAdverb = ""
    var m_superState = AdjectiveSuperState.none
    var m_adjPosType     = AdjectivePositionType.following
    var m_adjType         = AdjectiveType.any
    
    
    
    func setSuperState(superState: AdjectiveSuperState){
        m_superState = superState
    }
    func  setAdjectiveType (adjType : AdjectiveType){
        m_adjType = adjType
    }
    
    func setAdjectivePositionType (posType : AdjectivePositionType){m_adjPosType = posType}
    
    func getAdjectiveType()->AdjectiveType{return m_adjType}
    
    func getAdjectivePositionType()->AdjectivePositionType{return m_adjPosType}
    
    func setIsComparative (isComparative : Bool){
        m_isComparative = isComparative
    }
    
    func setIsSuperlative (isSuperlative : Bool){m_isSuperlative = isSuperlative}
    
    func isComparative ()->Bool { return m_isComparative}
    func isSuperlative ()->Bool { return m_isSuperlative}
    
    func processInfo(){
        //if head subject cluster is not found in this process,
        // then the parent/modified noun phrase must provide the person, number, gender
        
        for cluster in getClusterList(){
            
            //if we find a verb phrase first, then abort search for head noun
            
            if  cluster.getClusterType() == .VP {break}
            
            if  cluster.getClusterType() == .NP {
                m_headSubjectCluster = cluster
                setGender(value: cluster.getGender())
                setNumber(value: cluster.getNumber())
                setPerson(value: cluster.getPerson())
                break
            }
        }
        for cluster in getClusterList(){
            if  cluster.getClusterType() == .VP {
                m_headVerbCluster = cluster
                break
            }
        }
    } //ProcessInfo
    
    
} //dAdjectiveClause


class dRelativePronounClause: dClause {
    override init(){
        super.init(word: Word(), clusterType: .RelP)
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .RelP)
    }
    
    
}


class dDependentClause : dClause {
    override init(){
        super.init(word: Word(), clusterType: .RelP)
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .RelP)
    }
    
    
}

/*
class dIndependentClause : dClause {
    override init(){
        super.init(word: Word(), clusterType: .RelP)
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .RelP)
    }
    
    var headNoun = dCluster(word: Word(), clusterType: .N)
    var headVerb = dCluster(word: Word(), clusterType: .V)
    
    
    func informHeadVerb(){
        var hv = headVerb as! dVerbSingle
        let hn = headNoun as! dNounSingle
        hv.setGender(value: hn.getGender())
        hv.setPerson(value: hn.getPerson())
        hv.setNumber(value: hn.getNumber())
    }
}
*/

class dSentence : dClause {
    
    /*
    init(word: Word, mainClause: dIndependentClause){
        self.mainClause = mainClause
        super.init(word: word, clusterType: .S)
    }
    */
    override init(){
        //mainClause = dIndependentClause(sentenceString: "", data: Array<SentenceData>())
        super.init(word: Word(), clusterType: .S)
    }
    
    init(word: Word){
        //mainClause = dIndependentClause(sentenceString: word.word, data: Array<SentenceData>())
        super.init(word: word, clusterType: .S)
    }
    
    //var mainClause : dIndependentClause
    var subClauseList = Array<dClause>()
    /*
    func setMainClause(clause : dIndependentClause){
        mainClause = clause
    }
    func getMainClause()->dIndependentClause{
        return mainClause
    }
    */
    
    func appendNounClause(conj: Conjunction, clause: dNounClause){
        //var conj = conj
        subClauseList.append(clause)
    }

    
    /*
     func appendAdjectiveClause(pro: RelativePronoun, clause: dAdjectiveClause){
     var conj = conj
     subClauseList.append(clause)
     }
     
     */
    
    func appendAdverbialClause(conj: Conjunction, clause: dAdverbialClause){
        //let conj = conj
        subClauseList.append(clause)
    }
 
}

