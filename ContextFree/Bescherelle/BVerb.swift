///
//  BVerb.swift
//  ContextFree
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
        super.init(word: m_verbWord, def: "", wordType: .verb)
    }
    
    init(verbPhrase: String, verbWord: String, languageType: LanguageType){
        self.m_verbPhrase = verbPhrase
        self.m_verbWord = verbWord
        self.languageType = languageType
        super.init(word: m_verbWord, def: "", wordType: .verb)
    }

    func getId()->UUID{return id}
    
    //if any form is irregular, then the verb is irregular
    func isIrregular()->Bool{
        return m_isIrregular
    }
    
    func unConjugate(verbForm : String)->BVerb{
        var verb = BVerb()
        return verb
    }
    
    func isConjugated()->Bool{
        return m_isConjugated
    }
    
    func setIsConjugated(flag: Bool){
        m_isConjugated = flag
    }
}

