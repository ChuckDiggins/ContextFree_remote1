//
//  DtsInfo.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

class dtsInfo {
    var m_wordIndex = 0
    var m_wordType = WordType.unknown
    var m_gender = Gender.feminine
    
    func setWordIndex(index: Int){ m_wordIndex = index}
    func setWordType(type: WordType){( m_wordType = type)}
    func getWordType()->WordType{return m_wordType}
    func getWordIndex()->Int{return m_wordIndex}
    func getGender()->Gender{return m_gender}
    func setGender(value: Gender){m_gender = value}
}

class dtsInfoVerb : dtsInfo {
    var m_type = VerbType.normal
    var m_tense = Tense.present
    var m_person = Person.S1
    var m_number = Number.singular
    
    func getType()->VerbType{return m_type}
    func setTense(value: Tense){m_tense = value}
    func setPerson(value: Person){m_person = value}
    func setNumber(value: Number){m_number = value}
    
    func setType(type: VerbType){m_type = type}
    func getTense()->Tense {return m_tense}
    func getPerson()->Person{return m_person}
    func getNumber()->Number{return m_number}
    
}

class dtsInfoNoun : dtsInfo {
    var m_type = NounType.any
    func setType(type: NounType){m_type = type}
    func getType()->NounType{return m_type}
}

class dtsInfoPronoun : dtsInfo {
    var m_type = PronounType.none
    func setType(type: PronounType){m_type = type}
    func getType()->PronounType{return m_type}
}

class dtsInfoAdjective : dtsInfo {
    var m_type = AdjectiveType.any
    func setType(type: AdjectiveType){m_type = type}
    func getType()->AdjectiveType{return m_type}
}
