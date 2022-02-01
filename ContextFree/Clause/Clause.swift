//
//  Clause.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

public class dClause : dCluster, ObservableObject {
    @Published private(set) var clause = dClause.self
    
    
    public override init(word: Word, clusterType : ContextFreeSymbol){
        super.init(word: word, clusterType: clusterType)
    }
    
    public override init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    var m_headSubjectCluster = dCluster(word: Word(), clusterType: .PersPro)
    var m_headNounCluster = dCluster(word: Word(), clusterType: .N)
    var m_headVerbCluster = dCluster(word: Word(), clusterType: .V)
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    var m_singleList = Array<dSingle>()

    public func appendSingle(single: dSingle){
        m_singleList.append(single)
    }
    
    public func insertSingle(index: Int, single : dSingle){
        if ( index < m_singleList.count ){
            m_singleList.insert(single, at: index)
        }
    }
    
    public func replaceSingle(index: Int, single : dSingle){
        if ( index < m_singleList.count ){
            m_singleList[index] = single
        }
    }
    
    
    public func getLastSingle()->dSingle{
        if getLastCluster().getClusterType().isSingle() {
            //let single = getFirstCluster() as! dSingle
            return getLastCluster() as! dSingle
        }
        return dSingle()
    }
    public func setRule(rule: ContextFreeRule){m_cfr = rule}
    
    public func getString( wordList : SentenceWordList)->String{
        var wordListCopy = wordList
        return wordListCopy.getString()
    }
}

public class dAdverbialClause : dClause {
    
    public override init(){
        super.init(word: Word(), clusterType: .AdjCls)
    }
    
    public init(word: Word){
        super.init(word: word, clusterType: .AdjCls)
    }
}

public class dAdjectivalClause : dClause {
    
    public override init(){
        super.init(word: Word(), clusterType: .AdjCls)
    }
    
    public init(word: Word){
        super.init(word: word, clusterType: .AdjCls)
    }
    
    var m_isComparative = false
    var m_isSuperlative = false
    var m_articleExists = false
    var m_compareAdverb = ""
    var m_superState = AdjectiveSuperState.none
    var m_adjPosType     = AdjectivePositionType.following
    var m_adjType         = AdjectiveType.any
    
    
    
    public func setSuperState(superState: AdjectiveSuperState){
        m_superState = superState
    }
    public func  setAdjectiveType (adjType : AdjectiveType){
        m_adjType = adjType
    }
    
    public func setAdjectivePositionType (posType : AdjectivePositionType){m_adjPosType = posType}
    
    public func getAdjectiveType()->AdjectiveType{return m_adjType}
    
    public func getAdjectivePositionType()->AdjectivePositionType{return m_adjPosType}
    
    public func setIsComparative (isComparative : Bool){
        m_isComparative = isComparative
    }
    
    public func setIsSuperlative (isSuperlative : Bool){m_isSuperlative = isSuperlative}
    
    public func isComparative ()->Bool { return m_isComparative}
    public func isSuperlative ()->Bool { return m_isSuperlative}
    
    public func processInfo(){
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


public class dRelativePronounClause: dClause {
    public override init(){
        super.init(word: Word(), clusterType: .RelP)
    }
    
    public init(word: Word){
        super.init(word: word, clusterType: .RelP)
    }
    
    
}
public class dDependentClause : dClause {
    public override init(){
        super.init(word: Word(), clusterType: .RelP)
    }
    
    public init(word: Word){
        super.init(word: word, clusterType: .RelP)
    }
    
    
}

public class dSentenceA : dClause {
    
    public override init(){
        super.init(word: Word(), clusterType: .S)
    }
    
    public init(word: Word){
        super.init(word: word, clusterType: .S)
    }
    
    var subClauseList = Array<dClause>()
    
    public  func appendNounClause(conj: Conjunction, clause: dNounClause){
        //var conj = conj
        subClauseList.append(clause)
    }
    
    public func appendAdverbialClause(conj: Conjunction, clause: dAdverbialClause){
        //let conj = conj
        subClauseList.append(clause)
    }
 
}

