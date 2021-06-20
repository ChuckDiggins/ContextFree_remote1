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
    
    override func copyGuts(newSingle: dSingle){
        putClusterWord(word: newSingle.getClusterWord())
        setSentenceData(data: newSingle.getSentenceData())
        let sd = getSentenceData()
        print("in dNounSingle: \(sd.word.word):  \(sd.gender), \(sd.number)")
    }
    

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
    
    func startsWithVowelSound()->Bool{
        return getNounSingle().startsWithVowelSound()
    }
    
    func getNounSingle()->dNounSingle{
        let nounSingle = dNounSingle()
        for cluster in getClusterList(){
            if cluster.getClusterType() == .N {return cluster as! dNounSingle}
        }
        return nounSingle
    }
    
    func reconcile(){
        let npSentenceData = getSentenceData()
        for cluster in getClusterList(){
            let sym = cluster.getClusterType()
            if ( sym == .Art || sym == .Adj ){
                //cluster.setGender(value: npSentenceData.gender)
                //cluster.setNumber(value: npSentenceData.number)
                let sd = cluster.getSentenceData()
                sd.gender = npSentenceData.gender
                sd.number = npSentenceData.number
                if sym == .Art {
                    let art = cluster as! dArticleSingle
                    sd.setProcessedWord(str: art.getWordString())
                    //print("dNounPhrase:reconcile article \(art.getWordString()) .. ")
                }
                else if sym == .Adj {
                    let adj = cluster as! dAdjectiveSingle
                    var adjStr = adj.getWordString()
                    let now = Date()
                    adjStr = now.description
                    sd.setProcessedWord(str: adjStr)
                    //print("dNounPhrase:reconcile adjective \(adj.getWordString()) .. \(adjStr) .. ")
                }
                cluster.setSentenceData(data: sd)
                //print(cluster.getSentenceData().getProcessedWord())
            }
            else if sym == .NP {
                let np = cluster as! dNounPhrase
                np.reconcile()
            }
            else if sym == .PP {
                let pp = cluster as! dPrepositionPhrase
                pp.reconcile()
            }
        }
    }
    
    override func getPerson()->Person{
        for cluster in getClusterList() {
            let clusterType = cluster.getClusterType()
            if clusterType == .SubjP {
                let c = cluster as! dSubjectPronounSingle
                let person = c.getPerson()
                getSentenceData().person = person
                if c.getPronounType() == .SUBJECT {m_isSubject = true}
                return person      
            }
            else if clusterType == .N {
                let c = cluster as! dNounSingle
                let person = c.getPerson()
                getSentenceData().person = person
                return person
            }
        }
        return .S3
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


