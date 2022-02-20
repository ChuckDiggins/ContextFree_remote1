////
////  NewNamedPhrase.swift
////  NewNamedPhrase
////
////  Created by Charles Diggins on 1/19/22.
////

import Foundation

//class  NewNamedPhrase : dPhrase {
//    var id = UUID()
//    static func == (lhs: NewNamedPhrase, rhs: NewNamedPhrase) -> Bool {
//        return lhs.phraseName == rhs.phraseName && lhs.m_clusterType == rhs.m_clusterType
//    }
//    
//    private var phraseName : String
//    private var isSingleton = false  //has only a single phrase cluster == dSingle?
//    
//    private var m_randomWord : RandomWordLists!
//    
//    override init(){
//        phraseName = "No name yet"
//        super.init(word: Word(), clusterType: ContextFreeSymbol.AMB, data: WordStateData())
//    }
//    
//    init(inputPhrase: NewNamedPhrase, phraseName: String){
//        m_randomWord = inputPhrase.m_randomWord
//        self.phraseName = phraseName
//        for c in inputPhrase.getClusterList() {
//            var isSubject = false
//            let wordType = c.getWordType()
//            if wordType == .N {
//                let np = c as! dNounSingle
//                isSubject = np.isSubject()
//            }
//        }
//        super.init(word: Word(), clusterType: inputPhrase.getClusterType(), data: inputPhrase.getSentenceData())
//    }
//    
//    init(clusterType : ContextFreeSymbol){       //an empty phrase, to be named and filled later
//        self.phraseName = ""
//        isSingleton = true
//        super.init(word: Word(), clusterType: clusterType, data: WordStateData())
//    }
//    
//    init(randomWord:RandomWordLists, phraseName: String, clusterType: ContextFreeSymbol){
//        m_randomWord = randomWord
//        self.phraseName = phraseName
//        super.init(word: Word(), clusterType: clusterType, data: WordStateData())
//        //        createPhrase(phraseType: clusterType)
//    }
//    
//    
//    
//    //
//    //func createPhrase(phraseType: ContextFreeSymbol){
//    //    switch phraseType{
//    //    case .N: self = dNounSingle()
//    //    case .V: m_phrase = dVerbSingle()
//    //    case .Adj: m_phrase = dAdjectiveSingle()
//    //    case .Det: m_phrase = dDeterminerSingle()
//    //    case .Adv: m_phrase = dAdverbSingle()
//    //    case .P: m_phrase = dPrepositionSingle()
//    //    case .C: m_phrase = dConjunctionSingle()
//    //
//    //    case .NP: m_phrase = dNounPhrase()
//    //    case .VP: m_phrase = dVerbPhrase()
//    //    case .AdvP: m_phrase = dAdverbPhrase()
//    //    case .PP: m_phrase = dPrepositionPhrase()
//    //    case .AP: m_phrase = dAdjectivePhrase()
//    //    default: break
//    //    }
//    //}
//    
//    func getAssociatedWordsForCluster(index: Int)->[Word]{
//        return getCluster(index: index).getAssociatedWordList()
//    }
//    
//    func appendRandomCluster(cfs: ContextFreeSymbol, isSubject: Bool=false){
//        appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: cfs, isSubject:isSubject))
//    }
//    
//    func appendNonRandomCluster(cfs: ContextFreeSymbol, isSubject: Bool=false){
//        appendCluster(cluster: dSingle(clusterType: cfs))
//    }
//    
//    
//    override func createNewRandomPhrase(){
//        var index = 0
//        var newCluster = dCluster()
//        var newClusterWord = Word()
//        var replaceClusterWord = false
//        for cluster in getClusterList(){
//            replaceClusterWord = false
//            if cluster.getAssociatedWordListCount()>0 {
//                cluster.replaceClusterWordWithRandomAssociatedWord()
//                newClusterWord = cluster.m_clusterWord
//                replaceClusterWord = true
//                //                print("createNewPhrase: type \(cluster.getClusterType().rawValue): newWord \(newClusterWord.spanish)" )
//            }
//            let single = cluster as! dSingle
//            newCluster = m_randomWord.getAgnosticRandomWordAsSingle(wordType: single.getWordType(), isSubject:false)
//            if replaceClusterWord {
//                newCluster.m_clusterWord = newClusterWord
//                newCluster.putAssociatedWordList(wordList: cluster.getAssociatedWordList())
//            }
//            replaceCluster(index: index, cluster: newCluster)
//            index += 1
//        }
//    }
//    
//    func appendNamedPhrase(phrase: NamedPhrase){
//        appendCluster(cluster: phrase.getPhrase())
//    }
//    
//    func processPhraseInfo(){
//        processInfo()
//    }
//    
//    func isValid()->Bool{
//        if getClusterCount() > 0 {return true}
//        return false
//    }
//    
//    func getWordCountInCluster(index: Int)->Int{
//        return getCluster(index: index).getAssociatedWordList().count
//    }
//    
//    func getPhraseName()->String{
//        return phraseName
//    }
//    
//    //    func getPhrase()->dPhrase{
//    //        return m_phrase
//    //    }
//    //
//    //    func getPhraseType()->ContextFreeSymbol{
//    //        return phraseType
//    //    }
//    //
//    //    func getClauseType()->ContextFreeSymbol{
//    //        return phraseType
//    //    }
//    
//}
