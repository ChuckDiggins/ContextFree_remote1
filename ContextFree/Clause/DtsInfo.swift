//
//  DtsInfo.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

public class dtsInfo {
    var m_wordIndex = 0
    var m_wordType = WordType.unknown
    var m_gender = Gender.feminine
    
    public func setWordIndex(index: Int){ m_wordIndex = index}
    public func setWordType(type: WordType){( m_wordType = type)}
    public func getWordType()->WordType{return m_wordType}
    public func getWordIndex()->Int{return m_wordIndex}
    public func getGender()->Gender{return m_gender}
    public func setGender(value: Gender){m_gender = value}
}

public class dtsInfoVerb : dtsInfo {
    var m_type = VerbType.normal
    var m_tense = Tense.present
    var m_person = Person.S1
    var m_number = Number.singular
    
    public func getType()->VerbType{return m_type}
    public func setTense(value: Tense){m_tense = value}
    public func setPerson(value: Person){m_person = value}
    public func setNumber(value: Number){m_number = value}
    
    public func setType(type: VerbType){m_type = type}
    public func getTense()->Tense {return m_tense}
    public func getPerson()->Person{return m_person}
    public func getNumber()->Number{return m_number}
    
}

public class dtsInfoNoun : dtsInfo {
    var m_type = NounType.any
    public func setType(type: NounType){m_type = type}
    public func getType()->NounType{return m_type}
}

public class dtsInfoPronoun : dtsInfo {
    var m_type = PronounType.none
    public func setType(type: PronounType){m_type = type}
    public func getType()->PronounType{return m_type}
}

public class dtsInfoAdjective : dtsInfo {
    var m_type = AdjectiveType.any
    public func setType(type: AdjectiveType){m_type = type}
    public func getType()->AdjectiveType{return m_type}
}
