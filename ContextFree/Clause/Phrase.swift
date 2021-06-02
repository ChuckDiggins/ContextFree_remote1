//
//  Phrase.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/14/21.
//

import Foundation


class dPhrase : dCluster {
    
    override init(word: Word, clusterType : ContextFreeSymbol, data: WordStateData){
        super.init(word: word, clusterType: clusterType, data: data)
    }
    
    init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    var m_clusterList = Array<dCluster>()
    func getClusterCount()->Int{return m_clusterList.count}
    func getClusterList()->[dCluster]{ return m_clusterList}
    func appendCluster(cluster: dCluster){
        m_clusterList.append(cluster)        
    }
    func deleteCluster(index: Int){if index < getClusterCount(){m_clusterList.remove(at : index)}}
    func insertCluster(index: Int, cluster : dCluster){m_clusterList.insert(cluster, at: index)}
    
    func replaceClusterRange(firstIndex: Int, lastIndex: Int, cluster: dCluster){
        for _ in firstIndex...lastIndex {
            deleteCluster(index: firstIndex)
        }
        insertCluster(index: firstIndex, cluster: cluster)
    }

    func clearClusterList(){m_clusterList.removeAll()}
    
    func replaceCluster(index: Int, cluster: dCluster){
        m_clusterList[index] = cluster
    }
 
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

    func getString( )->String{
        var str = ""
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    let c = cluster as! dNounSingle
                    str += c.getString() + " "
                }
                else if ( type == .V){
                    let c = cluster as! dVerbSingle
                    str += c.getString() + " "
                }
                else if ( type == .SubjP){
                    let c = cluster as! dSubjectPronounSingle
                    str += c.getString() + " "
                }
                else {
                    let single = cluster as! dSingle
                    str += single.getString() + " "
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    str += c.getString() + " "
                case .VP:
                    let c = cluster as! dVerbPhrase
                    str += c.getString() + " "
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    str += c.getString() + " "
                default:
                    str += ""
                }
            }
        }
        return str
    }

}


class dAdverbPhrase : dPhrase {
    var type = ContextFreeSymbol.AdvP
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_adverbType = AdverbType.modifying
    func setAdverbType(type: AdverbType){m_adverbType = type}
    func getAdverbType()->AdverbType{return m_adverbType}
}

class dPrepositionPhrase : dPhrase {
    var type = ContextFreeSymbol.PP
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_isInfinitive  = false
    var m_isPersonal   = false
    var isPossessive = false
    var isSuppressPrep  = false
    var m_prepositionType = PrepositionType.general;
    
    func setPrepositionType (type : PrepositionType){m_prepositionType = type}
    func getPrepositionType()->PrepositionType{return m_prepositionType}
    
    func setIsPersonal (flag : Bool){m_isPersonal = flag}
    func getIsPersonal()->Bool{return m_isPersonal}
    func setIsInfinitive (flag : Bool){m_isInfinitive = flag}
    func getIsInfinitive()->Bool{return m_isInfinitive}
    func setIsPossessive (flag : Bool){isPossessive = flag}
    func getIsPossessive()->Bool{return isPossessive}
    func setIsSuppressPrep (flag : Bool){isSuppressPrep = flag}
    func getIsSuppressPrep()->Bool{return isSuppressPrep}
    

    func appendThisCluster(cluster : dCluster){
        switch(cluster.getClusterType()){
        case .P:
            let prep = cluster as! dPrepositionSingle

            setPrepositionType(type: prep.getPrepositionType())
        case .N:
            let noun = cluster as! dNounSingle
            if ( noun.getNounType() == .person ){ setIsPersonal(flag: true)}
        case .NP:
            let noun = cluster as! dNounPhrase
            if ( noun.getNounType() == NounType.any ){ setIsPersonal(flag: true)}
        case .PersPro:
             setIsPersonal(flag: true)
        default:
            appendCluster(cluster: cluster)
        }
        appendCluster(cluster: cluster)
    }
}



