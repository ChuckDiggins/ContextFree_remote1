//
//  CFLesson.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/18/21.
//

import Foundation

struct NamedClause : Identifiable{
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
    private var phraseName : String
    private var phraseType = ContextFreeSymbol.UNK
    private var m_phrase = dPhrase()
    
    private var m_randomWord : RandomWordLists!
    
    init(){
        self.phraseName = ""
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
        case .NP: m_phrase = dNounPhrase()
        case .VP: m_phrase = dVerbPhrase()
        case .AdvP: m_phrase = dAdverbPhrase()
        case .PP: m_phrase = dPrepositionPhrase()
        case .AP: m_phrase = dAdjectivePhrase()
        default: break
        }
    }
    
    mutating func appendCluster(cfs: ContextFreeSymbol, isSubject: Bool=false){
        m_phrase.appendCluster(cluster: m_randomWord.getAgnosticRandomWordAsSingle(wordType: cfs, isSubject:isSubject))
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
    
    func getPhraseName()->String{
        return phraseName
    }
    
    func getPhrase()->dPhrase{
        return m_phrase
    }
    
}

struct ContextFreeLesson {
    var m_lessonName : String
    var m_wsp : WordStringParser!
    var m_randomWord : RandomWordLists!
    private var namedPhraseList = [NamedPhrase]()
    
    private var activeLanguage = LanguageType.Spanish

    private var m_morphStruct = CFMorphStruct()
    private var morphIndex = 0
    
    //private var m_clause = dIndependentAgnosticClause()
    
    init (lessonName : String, wsp : WordStringParser){
        m_wsp = wsp
        m_randomWord = RandomWordLists(wsp: m_wsp)
        m_lessonName = lessonName
    }

    mutating func appendNamedPhrase(namedPhrase: NamedPhrase){
        namedPhraseList.append(namedPhrase)
    }
    
    mutating func createLesson(lessonName: String){
        m_lessonName = lessonName
    }
    
    func getNamePhraseCount()->Int{
        return namedPhraseList.count
    }
    
    func getNamedPhraseList()->[NamedPhrase]{
        return namedPhraseList
    }
    
    func getNamedPhraseAt(index: Int)->NamedPhrase{
        if index >= 0 && index < getNamePhraseCount(){
            return namedPhraseList[index]}
        return NamedPhrase()
    }
    
    mutating func createAClause(){}
 
    
}

struct LessonManager {
    private var  lessonList = [ContextFreeLesson]()
    
    mutating func appendLesson(lesson: ContextFreeLesson){
        lessonList.append(lesson)
    }
    
    mutating func getLesson(index: Int)->ContextFreeLesson{
        return lessonList[index]
    }
}
