//
//  CFLesson.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/18/21.
//

import Foundation
import JumpLinguaHelpers

struct ContextFreeLesson {
    var m_lessonName : String
    var m_wsp : WordStringParser!
    var m_randomWord : RandomWordLists!
    private var namedPhraseList = [dPhrase]()
    
    private var activeLanguage = LanguageType.Spanish

    private var m_morphStruct = CFMorphStruct()
    private var morphIndex = 0
    
    //private var m_clause = dIndependentAgnosticClause()
    
    init (lessonName : String, wsp : WordStringParser){
        m_wsp = wsp
        m_randomWord = RandomWordLists(wsp: m_wsp)
        m_lessonName = lessonName
    }

    mutating func appendNamedPhrase(namedPhrase: dPhrase){
        namedPhraseList.append(namedPhrase)
    }
    
    mutating func createLesson(lessonName: String){
        m_lessonName = lessonName
    }
    
    func getNamePhraseCount()->Int{
        return namedPhraseList.count
    }
    
    func getNamedPhraseList()->[dPhrase]{
        return namedPhraseList
    }
    
    func getNamedPhraseAt(index: Int)->dPhrase{
        if index >= 0 && index < getNamePhraseCount(){
            return namedPhraseList[index]}
        return dPhrase()
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
