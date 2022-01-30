//
//  Cluster.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

class dCluster : Hashable {
    
    static func == (lhs : dCluster, rhs : dCluster) ->Bool{
        return lhs.getClusterWord().spanish == rhs.getClusterWord().spanish && lhs.getClusterWord().french == rhs.getClusterWord().french
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.getClusterWord().spanish)
        hasher.combine(self.getClusterWord().french)
    }
    var m_clusterName = ""
    func getClusterName()->String{
        return m_clusterName
    }
    
    var m_clusterType : ContextFreeSymbol
    var m_parentClusterType = ContextFreeSymbol.UNK
    var m_clusterFunction = ContextFreeFunction.None
    var m_associatedWordList = [Word]()
    
    var m_clusterList = Array<dCluster>()
    func getClusterCount()->Int{return m_clusterList.count}
    func getCluster(index: Int)->dCluster{
        if index >= 0 && index < getClusterCount() { return m_clusterList[index]}
        return dCluster()
    }
    
    func getClusterList()->[dCluster]{ return m_clusterList}
    func setClusterList(clusterList: [dCluster]){ m_clusterList = clusterList}
    func appendCluster(cluster: dCluster){m_clusterList.append(cluster)}
    func deleteCluster(index: Int){if index < getClusterCount(){m_clusterList.remove(at : index)}}
    func insertCluster(index: Int, cluster : dCluster){m_clusterList.insert(cluster, at: index)}
    func clearClusterList(){ m_clusterList.removeAll()}
    func getLastCluster()->dCluster{ return m_clusterList[getClusterCount()-1] }
    func getFirstCluster()->dCluster{ return m_clusterList[0] }
    func replaceClusterRange(firstIndex: Int, lastIndex: Int, cluster: dCluster){
        for _ in firstIndex...lastIndex {
            deleteCluster(index: firstIndex)
        }
        insertCluster(index: firstIndex, cluster: cluster)
    }
    func replaceCluster(index: Int, cluster: dCluster){
        m_clusterList[index] = cluster
    }
 
    
    init(){
        m_clusterWord = Word()
        m_clusterType = ContextFreeSymbol.UNK
    }
    
    init(word : Word, clusterType: ContextFreeSymbol){
        m_clusterWord = word
        m_clusterType = clusterType
    }
    
    init(word : Word, clusterType: ContextFreeSymbol, data: WordStateData){
        m_clusterWord = word
        m_clusterType = clusterType
        m_sentenceData = data
    }
    
    func replaceWord(newWord: Word){
        m_clusterWord = newWord
    }
    
    func setClusterName(name: String){
        m_clusterName = name
    }
    
    func replaceClusterWordWithRandomAssociatedWord(){
        var index = Int.random(in: 0..<m_associatedWordList.count)
        m_clusterWord = m_associatedWordList[index]
    }
    
    //associated words for this cluster
    
    func putAssociatedWordList(wordList: [Word]){ m_associatedWordList = wordList }
    func clearAssociatedWordList(){ m_associatedWordList.removeAll() }
    func appendWordToAssociatedWordList(word: Word){
        m_associatedWordList.append(word)
    }
    
    func getAssociatedWordList()->[Word]{
        return m_associatedWordList
    }
    
    func getAssociatedWordListCount()->Int{
        return m_associatedWordList.count
    }
    
    func getRandomAssociatedWord()->Word{
        let i = Int.random(in: 0 ..< m_associatedWordList.count)
        return m_associatedWordList[i]
    }
    
    var m_clusterWord : Word

    func putClusterWord(word: Word){m_clusterWord = word}
    func getClusterWord()->Word{return m_clusterWord}
    
    func getParentClusterType()->ContextFreeSymbol{
        return m_parentClusterType
    }
    
    func setParentClusterType(clusterType: ContextFreeSymbol){
        m_parentClusterType = clusterType
    }
    
    var m_sentenceData = WordStateData()
    
    func setSentenceData(data: WordStateData){
        m_sentenceData = data
    }
    
    func getSentenceData()->WordStateData{
        return m_sentenceData
    }
    
    func setProcessWordInWordStateData(str: String){
        m_sentenceData.processedWord = str
    }
    
    func setProcessWordInWordStateData(language: LanguageType, str: String){
        m_sentenceData.setProcessedWord(language: language, str: str)
    }
    
    func getProcessWordInWordStateData()->String{
        return m_sentenceData.processedWord
    }
    
    func getProcessWordInWordStateData(language: LanguageType)->String{
        return m_sentenceData.getProcessedWord(language: language)
    }
    
    func setClusterFunction(fn: ContextFreeFunction){
        m_clusterFunction = fn
    }

    func hasClusterFunction(fn: ContextFreeFunction)->Bool{
        if fn == m_clusterFunction {return true}
        return false
    }
    func getClusterFunction()->ContextFreeFunction{
        return m_clusterFunction
    }
    
    func setClusterType(type: ContextFreeSymbol){m_clusterType = type}
    func getClusterType()->ContextFreeSymbol{return m_clusterType}
    
    func setGender(value : Gender){m_sentenceData.gender = value}
    func getGender()->Gender{return m_sentenceData.gender}

    func setPerson(value : Person){
        m_sentenceData.person = value    
    }
    
    func getPerson()->Person{return m_sentenceData.person}
    
    func setTense(value : Tense){
        m_sentenceData.tense = value
    }
    
    func getPronounType()->PronounType{return m_sentenceData.pronounType}
    func isPersonalPronounType()->Bool{
        if m_sentenceData.pronounType == .DIRECT_OBJECT ||
            m_sentenceData.pronounType == .INDIRECT_OBJECT ||
            m_sentenceData.pronounType == .SUBJECT ||
            m_sentenceData.pronounType == .PREPOSITIONAL ||
            m_sentenceData.pronounType == .REFLEXIVE {return true}
        return false
    }
    
    func getTense()->Tense{return m_sentenceData.tense}

    func setNumber(value : Number){m_sentenceData.number = value}
    func getNumber()->Number{return m_sentenceData.number}

    func setWordType(value : ContextFreeSymbol){m_sentenceData.wordType = value}
    func getWordType()->ContextFreeSymbol{return m_sentenceData.wordType}

    func getPhraseString(inCluster: dCluster)->String{
        return ""
    }
}

/*
class dClusterGroup : dCluster {
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
        if m_clusterList.count == 1 {m_sentenceData.language = cluster.getSentenceData().language}
    }
    
    func getClusterAtFunction(fn: ContextFreeFunction)->dCluster{
        for cluster in getClusterList(){
            if cluster.getClusterFunction() == fn {return cluster}
        }
        return dCluster()
    }
    
    
    
}
*/




