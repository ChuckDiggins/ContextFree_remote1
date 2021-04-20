//
//  NounCluster.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/14/21.
//

import Foundation

class dNounSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling noun
 single word clusters.
 ------------------------------------------------------------------*/
{
    override init(){
        super.init(word: Word(), clusterType: .N, data: SentenceWordData())
    }
    
    init(word: Word, data: SentenceWordData ){
        super.init(word: word, clusterType: .N, data: data)
    }
    
    var      m_isSubject = false
    var      m_nounType = NounType.any
    
    func    setNounType (type : NounType){m_nounType = type}
    func    getNounType ()->NounType{return m_nounType}
    func    setIsSubject(flag:Bool){m_isSubject = flag}
    func   isSubject()->Bool{return m_isSubject}
    
    func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        let noun = word as! RomanceNoun
        return noun.getNounString(number: sd.number)
    }
    
    override func getString()->String
    {
        return getWordString()
    }
    
} //dNounSingle

class dNounPhrase : dPhrase {
    var      m_isSubject = false
    var      m_nounType  = NounType.any
    var      m_nounCount = 0   //can we use cluster.number for this?
    var      m_isPlural  = false

    var type = ContextFreeSymbol.NP
    override init(){
        super.init(word: Word(), clusterType: type, data: SentenceWordData())
    }
    
    init(word: Word, data: SentenceWordData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    func reconcile(){
        for cluster in getClusterList(){
            let sym = cluster.getClusterType()
            if ( sym == .Art || sym == .Adj ){
                let data = getSentenceData()
                cluster.setGender(value: data.gender)
                cluster.setNumber(value: data.number)
            }
        }
    }
    
    func setAsSubject(flag : Bool){
        m_isSubject = flag
    }
    
    func    setNounType (type : NounType){m_nounType = type}
    func    getNounType ()->NounType{return m_nounType}
    
    func processInfo(){
        m_nounCount = 0
        for cluster in getClusterList() {
            let clusterType = cluster.getClusterType()
            switch clusterType {
            case .Num:
                let c = cluster as! dNumberSingle
                setNumber(value: c.getNumber())
            case .SubjP:
                let c = cluster as! dSubjectPronounSingle
                if c.getPronounType() == .SUBJECT {m_isSubject = true}
            case .N, .NP:
                m_nounCount += 1
                setPerson(value: cluster.getPerson())
                setGender(value: cluster.getGender())
                setNumber(value: cluster.getNumber())
            default:
                setTense(value: .present)
            }
        }
        if ( m_nounCount > 1){setNumber(value: .plural)}
    }
}

class dNounClause : dClause {
    
    var type = ContextFreeSymbol.NP
    override init(){
        super.init(word: Word(), clusterType: type)
    }
    
    init(word: Word, data: SentenceWordData ){
        super.init(word: word, clusterType: type)
    }
    
    
    var      m_nounType  = NounType.any
}


