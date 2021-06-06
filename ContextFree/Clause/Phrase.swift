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
        if cluster.getWordType() == .noun {
            m_sentenceData.gender = cluster.getGender()
            m_sentenceData.number = cluster.getNumber()
        }
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

    func getWordStateList(inputWordList: [WordStateData])->[WordStateData]{
        var wordList = inputWordList
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    //let c = cluster as! dNounSingle
                    wordList.append(cluster.getSentenceData())
                }
                else if ( type == .V){
                    let sd = cluster.getSentenceData()
                    wordList.append(sd)
                }
                else if ( type == .SubjP){
                    //let c = cluster as! dSubjectPronounSingle
                    wordList.append(cluster.getSentenceData())
                }
                else if ( type == .Art){
                    //let c = cluster as! dArticleSingle
                    wordList.append(cluster.getSentenceData())
                }
                else {
                    wordList.append(cluster.getSentenceData())
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    wordList = c.getWordStateList(inputWordList: wordList)
                case .VP:
                    let c = cluster as! dVerbPhrase
                    wordList = c.getWordStateList(inputWordList: wordList)
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    wordList = c.getWordStateList(inputWordList: wordList)
                default: break
                }
            }
        }
        return wordList
    }
    
    func getWordList(inputWordList: [Word])->[Word]{
        var wordList = inputWordList
        var str = ""
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    //let c = cluster as! dNounSingle
                    wordList.append(cluster.getClusterWord())
                }
                else if ( type == .V){
                    wordList.append(cluster.getClusterWord())
                }
                else if ( type == .SubjP){
                    let c = cluster as! dSubjectPronounSingle
                    wordList.append(c.getClusterWord())
                }
                else if ( type == .Art){
                    let c = cluster as! dArticleSingle
                    wordList.append(c.getClusterWord())
                }
                else {
                    wordList.append(cluster.getClusterWord())
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    wordList = c.getWordList(inputWordList: wordList)
                case .VP:
                    let c = cluster as! dVerbPhrase
                    wordList = c.getWordList(inputWordList: wordList)
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    wordList = c.getWordList(inputWordList: wordList)
                default: break
                }
            }
        }
        return wordList
    }
    
    func getString( )->String{
        var str = ""
        var tempStr = ""
        
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    let c = cluster as! dNounSingle
                    str += c.getString() + " "
                    c.setProcessWordInWordStateData(str: c.getString())
                }
                else if ( type == .V){
                    let c = cluster as! dVerbSingle
                    str += c.getString() + " "
                    c.setProcessWordInWordStateData(str: c.getString())

                }
                else if ( type == .SubjP){
                    let c = cluster as! dSubjectPronounSingle
                    str += c.getString() + " "
                    c.setProcessWordInWordStateData(str: c.getString())
                }
                else {
                    let single = cluster as! dSingle
                    let singleStr = single.getString()
                    str += singleStr + " "
                    single.setProcessWordInWordStateData(str: singleStr)
                    tempStr = single.getProcessWordInWordStateData()
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
        
        /*
        var wsdStr = ""
        for cluster in getClusterList(){
            if cluster.getClusterType().isSingle() {
                wsdStr += cluster.getProcessWordInWordStateData() + " "
            }
        }
        print(wsdStr)
 */
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
    
    func reconcile(){
        for cluster in getClusterList(){
            let sym = cluster.getClusterType()
            if ( sym == .Art || sym == .Adj ){
                let data = getSentenceData()
                cluster.setGender(value: data.gender)
                cluster.setNumber(value: data.number)
                var sd = cluster.getSentenceData()
                sd.gender = data.gender
                sd.number = data.number
                cluster.setSentenceData(data: sd)
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
            noun.reconcile()
        case .PersPro:
             setIsPersonal(flag: true)
        default:
            appendCluster(cluster: cluster)
        }
        appendCluster(cluster: cluster)
    }
}



