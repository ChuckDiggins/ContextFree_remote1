//
//  Clause.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

class dClause : dCluster, ObservableObject {
    @Published private(set) var clause = dClause.self
    
    
    override init(word: Word, clusterType : ContextFreeSymbol){
        super.init(word: word, clusterType: clusterType)
    }
    
    override init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    var m_headSubjectCluster = dCluster(word: Word(), clusterType: .PersPro)
    var m_headNounCluster = dCluster(word: Word(), clusterType: .N)
    var m_headVerbCluster = dCluster(word: Word(), clusterType: .V)
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    var m_singleList = Array<dSingle>()

    func appendSingle(single: dSingle){
        m_singleList.append(single)
    }
    
    func insertSingle(index: Int, single : dSingle){
        if ( index < m_singleList.count ){
            m_singleList.insert(single, at: index)
        }
    }
    
    func replaceSingle(index: Int, single : dSingle){
        if ( index < m_singleList.count ){
            m_singleList[index] = single
        }
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

class dSentenceA : dClause {
    
    override init(){
        super.init(word: Word(), clusterType: .S)
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .S)
    }
    
    var subClauseList = Array<dClause>()
    
    func appendNounClause(conj: Conjunction, clause: dNounClause){
        //var conj = conj
        subClauseList.append(clause)
    }
    
    func appendAdverbialClause(conj: Conjunction, clause: dAdverbialClause){
        //let conj = conj
        subClauseList.append(clause)
    }
 
}

