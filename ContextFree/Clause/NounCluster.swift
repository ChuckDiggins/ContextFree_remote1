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
        super.init(word: Word(), clusterType: .N, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: .N, data: data)
        setGender(value: data.gender)
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
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
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
    
    override func setPerson(value: Person){
        for cluster in getClusterList() {
            let clusterType = cluster.getClusterType()
            if clusterType == .SubjP {
                let c = cluster as! dSubjectPronounSingle
                c.setPerson(value: value)
                if c.getPronounType() == .SUBJECT {m_isSubject = true}
            }
        }
    }
    
    func processInfo(){
        m_nounCount = 0
        
        let gender = getGender()
        let number = getNumber()
        
        print ("Noun clause: \(getString()), gender: \(gender), number: \(number)")
        
        for cluster in getClusterList() {
            
            let clusterType = cluster.getClusterType()
            switch clusterType {
            case .Art:
                let c = cluster as! dArticleSingle
                c.setGender(value: gender)
                c.setNumber(value: number)
                print("Article:  gender: \(gender), number: \(number), \(c.getString())")
            case .Adj:
                let c = cluster as! dAdjectiveSingle
                c.setGender(value: gender)
                c.setNumber(value: number)
                print("Adjective: gender: \(gender), number: \(number), \(c.getString())")
                
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
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type)
    }
    
    
    var      m_nounType  = NounType.any
}


