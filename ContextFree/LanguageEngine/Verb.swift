//
//  ViperVerb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

class Verb : Word {
    var type: VerbType
    var tense = Tense.present
    var person = Person.S1
    var tensePersonSet = false
    
    init(word: String, def: String, type : VerbType){
        self.type = type
        super.init(word: word, def: def, wordType: .verb)
    }
    
    init(word: String, def: String, type : VerbType, tense: Tense, person: Person){
        self.type = type
        self.person = person
        self.tense = tense
        super.init(word: word, def: def, wordType: .verb)
    }
    
    func isTensePersonSet()->Bool {
        return tensePersonSet
    }
    
    func setTensePerson(tense : Tense, person: Person ){
        self.tense = tense
        self.person = person
        self.tensePersonSet = true
    }
    
    func getTense()->Tense{
        return tense
    }

    func getPerson()->Person{
        return person
    }

}

class RomanceVerb : Verb {
    var s1Form: String = ""
    var s2Form: String = ""
    var s3Form: String = ""
    var p1Form: String = ""
    var p2Form: String = ""
    var p3Form: String = ""
    
    
    override init(word: String, def: String, type: VerbType, tense: Tense, person: Person){
        super.init(word: word, def: def, type : type)
        setTensePerson(tense: tense, person: person)
    }
    
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
    }
    
    
    
    func setSimplePresentForms(s1: String, s2: String, s3: String, p1: String, p2:String, p3:String){
        s1Form = s1
        s2Form = s2
        s3Form = s3
        p1Form = p1
        p2Form = p2
        p3Form = p3
    }
    
    /*override func setTensePerson(tense : Tense, person: Person ){
        self.tense = tense
        self.person = person
        self.tensePersonSet = true
    }
    
    override func isTensePersonSet()->Bool {
        return tensePersonSet
    }
    */
    
    func getConjugateForm()->String{
        return getConjugateForm(tense: tense, person: person)
    }
    
    func getConjugateForm(tense: Tense, person : Person)->String{
        switch person {
        case .S1:
            return s1Form
        case .S2:
            return s2Form
        case .S3:
            return s3Form
        case .P1:
            return p1Form
        case .P2:
            return p2Form
        case .P3:
            return p3Form
        }
    }
    
    func isConjugateForm(word: String)->(Bool, Tense, Person){
        if ( word == s1Form ){return (true, .present, .S1)}
        if ( word == s2Form ){return (true, .present, .S2)}
        if ( word == s3Form ){return (true, .present, .S3)}
        if ( word == p1Form ){return (true, .present, .P1)}
        if ( word == p2Form ){return (true, .present, .P2)}
        if ( word == p3Form ){return (true, .present, .P3)}
        return (false, .present, .S1)
    }
    
    
    
}

class EnglishVerb : Verb {
    var singularForm = ""
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
        singularForm = word + "s"
    }
    
    func isConjugateForm(word: String)->(Bool, Tense, Person){
        if ( word == singularForm ){return (true, .present, .S3)}
        if ( word == self.word ){return (true, .present, .S1)}
        return (false, .present, .S1)
    }
}

