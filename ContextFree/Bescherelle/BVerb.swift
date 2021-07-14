//
//  BVerb.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/23/21.
//

import Foundation

struct ReplaceModelForm {
var tense = Tense.present
var person = Person.S1
var fromWord = ""
var toWord = ""
}

struct ReplaceMultipleForm {
    var tense = Tense.present
    var personList = [Person]()
    var fromWord = ""
    var toWord = ""
}

struct DropLettersForm {
    var tense = Tense.present
    var personList = [Person]()
    var fromWord = ""
}


struct ReplaceEndingForm {
var tense = Tense.present
var person = Person.S1
var fromWord = ""
var toWord = ""
}

struct StemSingleForm {
var tense = Tense.present
var person = Person.S1
var fromWord = ""
var toWord = ""
}

class BVerb : Word, Identifiable {
    var id = UUID()
    
    var m_verbPhrase : String
    var m_verbWord : String
    var languageType : LanguageType
    var m_isPassive = false
    var m_isIrregular = false
    
    var m_pastParticiple = ""
    var m_gerund = ""
    private var m_isConjugated = false
    
    override init(){
        self.m_verbPhrase = ""
        self.m_verbWord = ""
        self.languageType = LanguageType.Spanish
        super.init(word: m_verbWord, wordType: .verb)
    }
    
    init(verbPhrase: String, verbWord: String, languageType: LanguageType){
        self.m_verbPhrase = verbPhrase
        self.m_verbWord = verbWord
        self.languageType = languageType
        super.init(word: m_verbWord, wordType: .verb)
    }

    func getInfinitiveAndParticiples()->(String, String, String){
        return (word, m_pastParticiple, m_gerund)
    }
    
    func getPresentParticiple()->String{
        return m_gerund
    }
    
    func getPastParticiple()->String{
        return m_pastParticiple
    }
    
    func getId()->UUID{return id}
    
    //if any form is irregular, then the verb is irregular
    func isIrregular()->Bool{
        return m_isIrregular
    }
    
    func unConjugate(verbForm : String)->BVerb{
        let verb = BVerb()
        return verb
    }
    
    func isConjugated()->Bool{
        return m_isConjugated
    }
    
    func setIsConjugated(flag: Bool){
        m_isConjugated = flag
    }
    
    func getPhrase()->String{
        return m_verbPhrase
    }
    
    func getConjugatedMorphStruct( tense : Tense, person : Person , conjugateEntirePhrase : Bool) -> MorphStruct {
        return MorphStruct(person: person)
    }
}
