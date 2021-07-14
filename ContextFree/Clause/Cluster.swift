//
//  Cluster.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

class dCluster {
    var m_clusterType : ContextFreeSymbol
    var m_clusterFunction = ContextFreeFunction.Undefined
    
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
    
    var m_clusterWord : Word

    func putClusterWord(word: Word){m_clusterWord = word}
    func getClusterWord()->Word{return m_clusterWord}
    
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
    
    func getTense()->Tense{return m_sentenceData.tense}

    func setNumber(value : Number){m_sentenceData.number = value}
    func getNumber()->Number{return m_sentenceData.number}

    func setWordType(value : WordType){m_sentenceData.wordType = value}
    func getWordType()->WordType{return m_sentenceData.wordType}

    func getPhraseString(inCluster: dCluster)->String{
        return ""
    }
}





