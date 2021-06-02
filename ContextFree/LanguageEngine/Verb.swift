//
//  ViperVerb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

class Verb : Word {
    var type: VerbType
    var transitivity =  VerbTransitivity.transitive
    var passivity =  VerbPassivity.active
    var modality = VerbModality.notModal
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
    
    init(word: String, def: String, wsd: WordStateData){
        self.type = wsd.verbType
        self.person = wsd.person
        self.tense = wsd.tense
        self.transitivity = wsd.verbTransitivity
        self.passivity = wsd.verbPassivity
        self.modality = wsd.verbModality
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
    var verbForm = Array<String>()
    override init(word: String, def: String, type: VerbType, tense: Tense, person: Person){
        super.init(word: word, def: def, type : type)
        setTensePerson(tense: tense, person: person)
    }
    
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
    }
    
    
    func setSimplePresentForms(s1: String, s2: String, s3: String, p1: String, p2:String, p3:String){
        verbForm.removeAll()
        verbForm.append(s1)
        verbForm.append(s2)
        verbForm.append(s3)
        verbForm.append(p1)
        verbForm.append(p2)
        verbForm.append(p3)
    }
    
    func getConjugateForm()->String{
        return getConjugateForm(tense: tense, person: person)
    }
    
    func getConjugateForm(tense: Tense, person : Person)->String{ return verbForm[person.getIndex()] }
    
    func isConjugateForm(word: String)->(Bool, Tense, Person){
        for p in 0..<6 {
            let person = Person.allCases[p]
            if word == verbForm[p]{return (true, .present, person)}
        }
        return (false, .present, .S1)
    }
    
}

class FrenchVerb : RomanceVerb {
    
}

class SpanishVerb : RomanceVerb {
    var bVerb : BSpanishVerb
    init(bVerb: BSpanishVerb){
        self.bVerb = bVerb
        super.init(word: bVerb.m_verbWord, def: bVerb.def, type : VerbType.normal)
        conjugateAndSetSimplePresentForms()
    }
    
    func getBVerb()->BSpanishVerb{
        return bVerb
    }
    
    func conjugateAndSetSimplePresentForms(){
        for p in 0..<6 {
            let person = Person.allCases[p]
            _ = bVerb.getConjugatedMorphStruct(tense: .present, person: person, conjugateEntirePhrase : false )
            verbForm.append(bVerb.getFinalVerbForm(person : person))
        }
    }
    
    override func getConjugateForm(tense: Tense, person : Person)->String{
        switch tense {
        case .pastParticiple: return bVerb.getPastParticiple()
        case .presentParticiple: return bVerb.getPresentParticiple()
        case .infinitive: return bVerb.m_verbWord
        default:  return bVerb.getConjugateForm(tense: tense, person: person)
        }
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

