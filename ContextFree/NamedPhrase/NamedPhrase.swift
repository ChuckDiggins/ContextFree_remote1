//
//  NamedPhrase.swift
//  NamedPhrase
//
//  Created by Charles Diggins on 1/16/22.
//

import Foundation

struct NamedClause : Identifiable, Hashable{
    var id = UUID()
    private var clauseName : String
    private var m_clause = dIndependentAgnosticClause()
    
    init(){
        self.clauseName = ""
    }
    
    init(clauseName : String){
        self.clauseName = clauseName
    }
    
    mutating func appendNamedPhrase(namedPhrase : NamedPhrase){
        m_clause.appendCluster(cluster: namedPhrase.getPhrase())
    }
    
    func getName()->String{
        return clauseName
    }
    
    func getClause()->dIndependentAgnosticClause{
        return m_clause
    }
    
    func process(){
        m_clause.setHeadNounAndHeadVerb()
    }
}


struct NamedPhrase : Identifiable{
    var id = UUID()
    static func == (lhs: NamedPhrase, rhs: NamedPhrase) -> Bool {
        return lhs.phraseName == rhs.phraseName && lhs.phraseType == rhs.phraseType
    }
    
    private var phraseName : String
    private var phraseType = ContextFreeSymbol.UNK
    private var m_phrase = dPhrase()
    private var isSingleton = false
    
    private var m_randomWord : RandomWordLists!
    
    init(){
        self.phraseName = ""
    }
    
    init(phraseType : ContextFreeSymbol){
        self.phraseType = phraseType
        self.phraseName = ""
        isSingleton = true
    }
    
    //make copy but with new name
    
    init(inputPhrase: NamedPhrase, phraseName: String){
        m_randomWord = inputPhrase.m_randomWord
        self.phraseName = phraseName
        phraseType = inputPhrase.phraseType
        createPhrase(phraseType: phraseType)
        //must create new clusters here, not copy input ones
        for c in inputPhrase.getClusterList() {
            var isSubject = false
            let wordType = c.getWordType()
            if wordType == .N {
                let np = c as! dNounSingle
                isSubject = np.isSubject()
            }
            appendCluster(cfs: wordType, isSubject: isSubject)
        }
    }
    
    init(randomWord:RandomWordLists, phraseName: String, phraseType: ContextFreeSymbol){
        m_randomWord = randomWord
        self.phraseName = phraseName
        self.phraseType = phraseType
        createPhrase(phraseType: phraseType)
    }
 
    mutating func createPhrase(phraseType: ContextFreeSymbol){
        switch phraseType{
//        case .N: m_phrase = dNounSingle()
//        case .V: m_phrase = dVerbSingle()
//        case .Adj: m_phrase = dAdjectiveSingle()
//        case .Det: m_phrase = dDeterminerSingle()
//        case .Adv: m_phrase = dAdverbSingle()
//        case .P: m_phrase = dPrepositionSingle()
//        case .C: m_phrase = dConjunctionSingle()
            
        case .NP: m_phrase = dNounPhrase()
        case .VP: m_phrase = dVerbPhrase()
        case .AdvP: m_phrase = dAdverbPhrase()
        case .PP: m_phrase = dPrepositionPhrase()
        case .AP: m_phrase = dAdjectivePhrase()
        default: break
        }
    }
    
    func getAssociatedWordsForCluster(index: Int)->[Word]{
        return m_phrase.getCluster(index: index).getAssociatedWordList()
    }
    
    mutating func appendCluster(cfs: ContextFreeSymbol, isSubject: Bool=false){
        m_phrase.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: cfs, isSubject:isSubject))
    }
    
    mutating func appendNonRandomCluster(cfs: ContextFreeSymbol, isSubject: Bool=false){
        m_phrase.appendCluster(cluster: dSingle(clusterType: cfs))
    }
    
    
    mutating func createNewRandomPhrase(){
        var index = 0
        var newCluster = dCluster()
        var newClusterWord = Word()
        var replaceClusterWord = false
        for cluster in m_phrase.getClusterList(){
            replaceClusterWord = false
            if cluster.getAssociatedWordListCount()>0 {
                cluster.replaceClusterWordWithRandomAssociatedWord()
                newClusterWord = cluster.m_clusterWord
                replaceClusterWord = true
//                print("createNewPhrase: type \(cluster.getClusterType().rawValue): newWord \(newClusterWord.spanish)" )
            }
            let single = cluster as! dSingle
            newCluster = m_randomWord.getAgnosticRandomWordAsSingle(wordType: single.getWordType(), isSubject:false)
            if replaceClusterWord {
                newCluster.m_clusterWord = newClusterWord
                newCluster.putAssociatedWordList(wordList: cluster.getAssociatedWordList())
            }
            m_phrase.replaceCluster(index: index, cluster: newCluster)
            index += 1
        }
    }
    
    mutating func appendNamedPhrase(phrase: NamedPhrase){
        m_phrase.appendCluster(cluster: phrase.getPhrase())
    }
    
    mutating func processPhraseInfo(){
        m_phrase.processInfo()
    }
    
    func isValid()->Bool{
        if getClusterCount() > 0 {return true}
        return false
    }
    
    func getClusterList()->[dCluster]{
        return m_phrase.getClusterList()
    }
    
    func getClusterCount()->Int{
        return m_phrase.getClusterCount()
    }
    
    func getCluster(index: Int)->dCluster{
        if ( index >= 0 && index < getClusterCount() ){
            return m_phrase.getCluster(index: index)
        }
        return dCluster()
    }
    
    func getWordCountInCluster(index: Int)->Int{
        return getCluster(index: index).getAssociatedWordList().count
    }
    
    func getPhraseName()->String{
        return phraseName
    }
    
    func getPhrase()->dPhrase{
        return m_phrase
    }
    
    func getPhraseType()->ContextFreeSymbol{
        return phraseType
    }
    
    func getClauseType()->ContextFreeSymbol{
        return phraseType
    }
    
}
