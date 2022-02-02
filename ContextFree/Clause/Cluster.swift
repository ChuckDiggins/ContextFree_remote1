//
//  Cluster.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation
import JumpLinguaHelpers

public class dCluster : Hashable {
    var m_clusterWord : Word
    var m_clusterType : ContextFreeSymbol
    var m_parentClusterType = ContextFreeSymbol.UNK
    var m_clusterFunction = ContextFreeFunction.None
    var m_associatedWordList = [Word]()
    var m_sentenceData = WordStateData()
    
    var m_clusterList = Array<dCluster>()
    public static func == (lhs : dCluster, rhs : dCluster) ->Bool{
        return lhs.getClusterWord().spanish == rhs.getClusterWord().spanish && lhs.getClusterWord().french == rhs.getClusterWord().french
    }
    
    public func hash(into hasher: inout Hasher){
        hasher.combine(self.getClusterWord().spanish)
        hasher.combine(self.getClusterWord().french)
    }
    var m_clusterName = ""
    public func getClusterName()->String{
        return m_clusterName
    }

    
    public func getClusterCount()->Int{return m_clusterList.count}
    public func getCluster(index: Int)->dCluster{
        if index >= 0 && index < getClusterCount() { return m_clusterList[index]}
        return dCluster()
    }
    
    public func getClusterList()->[dCluster]{ return m_clusterList}
    public func setClusterList(clusterList: [dCluster]){ m_clusterList = clusterList}
    public func appendCluster(cluster: dCluster){m_clusterList.append(cluster)}
    public func deleteCluster(index: Int){if index < getClusterCount(){m_clusterList.remove(at : index)}}
    public func insertCluster(index: Int, cluster : dCluster){m_clusterList.insert(cluster, at: index)}
    public func clearClusterList(){ m_clusterList.removeAll()}
    public func getLastCluster()->dCluster{ return m_clusterList[getClusterCount()-1] }
    public func getFirstCluster()->dCluster{ return m_clusterList[0] }
    public func replaceClusterRange(firstIndex: Int, lastIndex: Int, cluster: dCluster){
        for _ in firstIndex...lastIndex {
            deleteCluster(index: firstIndex)
        }
        insertCluster(index: firstIndex, cluster: cluster)
    }
    public func replaceCluster(index: Int, cluster: dCluster){
        m_clusterList[index] = cluster
    }
 
    
    public init(){
        m_clusterWord = Word()
        m_clusterType = ContextFreeSymbol.UNK
    }
    
    public init(word : Word, clusterType: ContextFreeSymbol){
        m_clusterWord = word
        m_clusterType = clusterType
    }
    
    public init(word : Word, clusterType: ContextFreeSymbol, data: WordStateData){
        m_clusterWord = word
        m_clusterType = clusterType
        m_sentenceData = data
    }
    
    public func replaceWord(newWord: Word){
        m_clusterWord = newWord
    }
    
    public func setClusterName(name: String){
        m_clusterName = name
    }
    
    public func replaceClusterWordWithRandomAssociatedWord(){
        let index = Int.random(in: 0..<m_associatedWordList.count)
        m_clusterWord = m_associatedWordList[index]
    }
    
    //associated words for this cluster
    
    public func putAssociatedWordList(wordList: [Word]){ m_associatedWordList = wordList }
    public func clearAssociatedWordList(){ m_associatedWordList.removeAll() }
    public func appendWordToAssociatedWordList(word: Word){
        m_associatedWordList.append(word)
    }
    
    public func getAssociatedWordList()->[Word]{
        return m_associatedWordList
    }
    
    public func getAssociatedWordListCount()->Int{
        return m_associatedWordList.count
    }
    
    public func getRandomAssociatedWord()->Word{
        let i = Int.random(in: 0 ..< m_associatedWordList.count)
        return m_associatedWordList[i]
    }

    public func putClusterWord(word: Word){m_clusterWord = word}
    public func getClusterWord()->Word{return m_clusterWord}
    
    public func getParentClusterType()->ContextFreeSymbol{
        return m_parentClusterType
    }
    
    public func setParentClusterType(clusterType: ContextFreeSymbol){
        m_parentClusterType = clusterType
    }
    
   
    
    public func setSentenceData(data: WordStateData){
        m_sentenceData = data
    }
    
    public func getSentenceData()->WordStateData{
        return m_sentenceData
    }
    
    public func setProcessWordInWordStateData(str: String){
        m_sentenceData.processedWord = str
    }
    
    public func setProcessWordInWordStateData(language: LanguageType, str: String){
        m_sentenceData.setProcessedWord(language: language, str: str)
    }
    
    public func getProcessWordInWordStateData()->String{
        return m_sentenceData.processedWord
    }
    
    public func getProcessWordInWordStateData(language: LanguageType)->String{
        return m_sentenceData.getProcessedWord(language: language)
    }
    
    public func setClusterFunction(fn: ContextFreeFunction){
        m_clusterFunction = fn
    }

    public func hasClusterFunction(fn: ContextFreeFunction)->Bool{
        if fn == m_clusterFunction {return true}
        return false
    }
    public func getClusterFunction()->ContextFreeFunction{
        return m_clusterFunction
    }
    
    public func setClusterType(type: ContextFreeSymbol){m_clusterType = type}
    public func getClusterType()->ContextFreeSymbol{return m_clusterType}
    
    public func setGender(value : Gender){m_sentenceData.gender = value}
    public func getGender()->Gender{return m_sentenceData.gender}

    public func setPerson(value : Person){
        m_sentenceData.person = value    
    }
    
    public func getPerson()->Person{return m_sentenceData.person}
    
    public func setTense(value : Tense){
        m_sentenceData.tense = value
    }
    
    public func getPronounType()->PronounType{return m_sentenceData.pronounType}
    public func isPersonalPronounType()->Bool{
        if m_sentenceData.pronounType == .DIRECT_OBJECT ||
            m_sentenceData.pronounType == .INDIRECT_OBJECT ||
            m_sentenceData.pronounType == .SUBJECT ||
            m_sentenceData.pronounType == .PREPOSITIONAL ||
            m_sentenceData.pronounType == .REFLEXIVE {return true}
        return false
    }
    
    public func getTense()->Tense{return m_sentenceData.tense}

    public func setNumber(value : Number){m_sentenceData.number = value}
    public func getNumber()->Number{return m_sentenceData.number}

    public func setWordType(value : ContextFreeSymbol){m_sentenceData.wordType = value}
    public func getWordType()->ContextFreeSymbol{return m_sentenceData.wordType}

    public func getPhraseString(inCluster: dCluster)->String{
        return ""
    }
}

/*
 public class dClusterGroup : dCluster {
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    var m_clusterList = Array<dCluster>()
    
 public func getClusterCount()->Int{return m_clusterList.count}
    
 public func getClusterList()->[dCluster]{ return m_clusterList}
    
 public func appendCluster(cluster: dCluster){
        if cluster.getWordType() == .noun {
            m_sentenceData.gender = cluster.getGender()
            m_sentenceData.number = cluster.getNumber()
        }
        m_clusterList.append(cluster)
        if m_clusterList.count == 1 {m_sentenceData.language = cluster.getSentenceData().language}
    }
    
 public func getClusterAtFunction(fn: ContextFreeFunction)->dCluster{
        for cluster in getClusterList(){
            if cluster.getClusterFunction() == fn {return cluster}
        }
        return dCluster()
    }
    
    
    
}
*/




