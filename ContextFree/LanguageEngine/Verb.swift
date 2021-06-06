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
    
    /*init(word: String, def: String, type : VerbType, tense: Tense, person: Person){
        self.type = type
        self.person = person
        self.tense = tense
        super.init(word: word, def: def, wordType: .verb)
     }
    */
    
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
    var bVerb : BVerb
    var verbForm = Array<String>()
    /*
    override init(word: String, def: String, type: VerbType, tense: Tense, person: Person){
        super.init(word: word, def: def, type : type)
        setTensePerson(tense: tense, person: person)
    }
    */
    init(bVerb: BVerb){
        self.bVerb = bVerb
        super.init(word: bVerb.m_verbWord, def: "", type : VerbType.normal)
    }
    
    func setBVerb(bVerb : BVerb){
        self.bVerb = bVerb
    }
    
    func getBVerb()->BVerb{
        return bVerb
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
    init(bVerb: BFrenchVerb){
        super.init(bVerb: bVerb)
        var test = getConjugateForm(tense: .preterite, person : .S3)
    }
    
    
    func conjugateAndSetSimplePresentForms(){
        let bFrVerb = bVerb as! BFrenchVerb
        for p in 0..<6 {
            let person = Person.allCases[p]
            _ = bFrVerb.getConjugatedMorphStruct(tense: .present, person: person, conjugateEntirePhrase : false )
            verbForm.append(bFrVerb.getFinalVerbForm(person : person))
        }
    }
    
    override func getConjugateForm(tense: Tense, person : Person)->String{
        let bFrVerb = bVerb as! BFrenchVerb
        switch tense {
        case .pastParticiple: return bFrVerb.getPastParticiple()
        case .presentParticiple: return bFrVerb.getPresentParticiple()
        case .infinitive: return bFrVerb.m_verbWord
        default:  return bFrVerb.getConjugateForm(tense: tense, person: person)
        }
    }
}

class SpanishVerb : RomanceVerb {
    override init(bVerb: BVerb){
        super.init(bVerb: bVerb)
        var test = getConjugateForm(tense: .preterite, person : .S3)
    }
    
    func conjugateAndSetSimplePresentForms(){
        let bSpVerb = bVerb as! BSpanishVerb
        for p in 0..<6 {
            let person = Person.allCases[p]
            _ = bSpVerb.getConjugatedMorphStruct(tense: .present, person: person, conjugateEntirePhrase : false )
            verbForm.append(bSpVerb.getFinalVerbForm(person : person))
        }
    }
    
    override func getConjugateForm(tense: Tense, person : Person)->String{
        let bSpVerb = bVerb as! BSpanishVerb
        switch tense {
        case .pastParticiple: return bSpVerb.getPastParticiple()
        case .presentParticiple: return bSpVerb.getPresentParticiple()
        case .infinitive: return bSpVerb.m_verbWord
        default:  return bSpVerb.getConjugateForm(tense: tense, person: person)
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

