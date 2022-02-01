//
//  Verb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation


//----------------------------------------------------------------------------------------

public class Verb : Word {
    var bVerb = BVerb()
    var typeList = [VerbType]()
    var transitivity =  VerbTransitivity.transitive
    var passivity =  VerbPassivity.active
    var tense = Tense.present
    var person = Person.S1
    var tensePersonSet = false
    var m_isPassive = false
    
    public override init(){
        super.init(word: "", wordType : .verb)
    }
     
    public init(spanish: String, french: String, english: String){
        super.init(word: spanish, wordType: .verb)
        self.spanish = spanish
        self.french = french
        self.english = english
    }
    
    public init(word: String, type : VerbType){
        typeList.append(type)
        super.init(word: word, wordType: .verb)
    }
    
    public init(word: String, type : VerbType, tense: Tense, person: Person){
        typeList.append(type)
        self.person = person
        self.tense = tense
        if type == .passive {
            m_isPassive = true
        }
        super.init(word: word, wordType: .verb)
    }
    
    public init(word: String, wsd: WordStateData){
        typeList.append(wsd.verbType)
        self.person = wsd.person
        self.tense = wsd.tense
        self.transitivity = wsd.verbTransitivity
        self.passivity = wsd.verbPassivity
        super.init(word: word, wordType: .verb)
    }
    
    public init(jsonVerb: JsonVerb, language: LanguageType){
        self.transitivity = jsonVerb.transitivity
        switch(language){
        case .Spanish:  super.init(word: jsonVerb.spanish, wordType: .verb)
        case .French:  super.init(word: jsonVerb.french, wordType: .verb)
        case .English:  super.init(word: jsonVerb.english, wordType: .verb)
        case .Agnostic:  super.init(word: jsonVerb.english, wordType: .verb)
        default:
            super.init(word: jsonVerb.spanish, wordType: .verb)
        }
        self.spanish = jsonVerb.spanish
        self.french = jsonVerb.french
        self.english = jsonVerb.english
        
        convertVerbTypeStringToVerbTypes(inputString: jsonVerb.verbType)
    
        for type in typeList {
            if type == .passive {
                m_isPassive = true
            }
        }
    }
    
    public func setBVerb(bVerb: BVerb){
        self.bVerb = bVerb
    }
    
    public func getBVerb()->BVerb{
        return bVerb
    }
    
    public func updateInfo(jsonVerb: JsonVerb){
        self.english = jsonVerb.english
        self.french = jsonVerb.french
        self.spanish = jsonVerb.spanish
        self.transitivity = jsonVerb.transitivity
        convertVerbTypeStringToVerbTypes(inputString: jsonVerb.verbType)
        
    }
    
    public func updateWords(english: String, french: String){
        self.english = english
        self.french = french
        self.spanish = word
    }
    
    public func updateTransitivity(trans : VerbTransitivity){
        transitivity = trans
    }
    
    public func isTransitive()->Bool{
        if ( transitivity == .intransitive ){return false}
            return true
    }
    
    public func updatePassivity(pass : VerbPassivity){
        passivity = pass
    }
    
    public func isPassive()->Bool{
        if ( passivity == .passive ){return true}
            return false
    }
    
    public func isBackward()->Bool {
        for type in typeList {
            if type == VerbType.backward {
                return true
            }
        }
        return false
    }
    
    public func updateType( vType: [String])
    {
        typeList.removeAll()
        for f in vType {
            typeList.append(getVerbTypeFromLetter(letter: f))
        }
    }
    public func getWordAtLanguage(language: LanguageType)->String{
        switch(language){
        case .Spanish: return spanish
        case .English: return english
        case .French: return french
        default:
            return english
        }
    }
    
    public func convertVerbTypeStringToVerbTypes(inputString: String){
        let util = VerbUtilities()
        let strList = getVerbTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                typeList.append(getVerbTypeFromLetter(letter: str))
            }
        }
    }
    
    func getVerbTypes()->[VerbType]{
        return typeList
    }
    
    public func convertVerbTypesToCompositeString()->String{
        var compositeString = ""
        for vt in typeList{
            compositeString.append(getVerbTypeAsLetter(index: vt.rawValue))
        }
        return compositeString
    }
    
    public func createJsonVerb()->JsonVerb{
        let jv : JsonVerb
        if ( passivity == .passive ){
            jv = JsonVerb(spanish: word, english: english, french: french)
        }
        else {
            jv = JsonVerb(spanish: word, english: english, french: french,   transitivity: transitivity, verbType : convertVerbTypesToCompositeString())
        }
        return jv
    }
    
    public func createBVerb(){
    }
    
    public func isNormal()->Bool{
        for vt in typeList{
            if vt == .normal { return true}
        }
        return false
    }
    
    public func isTensePersonSet()->Bool {
        return tensePersonSet
    }
    
    public func setTensePerson(tense : Tense, person: Person ){
        self.tense = tense
        self.person = person
        self.tensePersonSet = true
    }
    
    public func getTense()->Tense{
        return tense
    }

    public func getPerson()->Person{
        return person
    }
    
    public func getResidualPhrase()->String {
        getBVerb().getResidualPhrase()
    }

    public func getMorphStruct(tense: Tense, person: Person)->MorphStruct{
        MorphStruct(person: person)
    }
    
}

public class RomanceVerb : Verb {
    
    var verbForm = Array<String>()
    var pastParticiple = ""
    var presentParticiple = ""
    
    public override init(jsonVerb: JsonVerb, language: LanguageType){
        super.init(jsonVerb: jsonVerb, language: language)
    }
    
    public override init(word: String, type: VerbType, tense: Tense, person: Person){
        super.init(word: word, type : type)
        setTensePerson(tense: tense, person: person)
    }
    
    public override init(word: String, type: VerbType){
        super.init(word: word, type : type)
    }
    
    public func getConjugateForm()->String{
        return getConjugateForm(tense: tense, person: person, showResidualPhrase: false)
    }
    
    public func getConjugateForm(tense: Tense, person : Person, showResidualPhrase: Bool)->String{ return verbForm[person.getIndex()] }
    
    public func isConjugateForm(word: String)->(Bool, Tense, Person){
        for p in 0..<6 {
            let person = Person.allCases[p]
            if word == verbForm[p]{return (true, .present, person)}
        }
        return (false, .present, .S1)
    }
    
    public override func getMorphStruct(tense: Tense, person: Person)->MorphStruct{
        MorphStruct(person: person)
    }
    
    public override func createBVerb(){
    }

}


public class FrenchVerb : RomanceVerb {
    public init(){
        super.init(word: "", type : .normal)
    }
    
    public init(jsonVerb: JsonVerb){
        super.init(jsonVerb: jsonVerb, language: .French)
    }
    
    public override init(word: String, type: VerbType){
        super.init(word: word, type : type)
    }
    
    public override func createBVerb(){
        if ( bVerb.m_verbWord.count == 0){
            let bv = BFrenchVerb(verbPhrase: french)
            let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: bv.m_verbWord)
            bv.setPatterns(verbModel : verbModel)
            setBVerb(bVerb: bv)
        }
    }
    public override func getConjugateForm(tense: Tense, person : Person, showResidualPhrase: Bool)->String{
        createBVerb()
        let bFrVerb = bVerb as! BFrenchVerb
        switch tense {
        case .pastParticiple: return bFrVerb.getPastParticiple()
        case .presentParticiple: return bFrVerb.getPresentParticiple()
        case .infinitive: return bFrVerb.m_verbWord
        default:
            var conjugateString = bFrVerb.getConjugateForm(tense: tense, person: person)
            if showResidualPhrase && bFrVerb.getResidualPhrase().count > 0 { conjugateString += " " + bFrVerb.getResidualPhrase() }
            return conjugateString
        }
    }
    
    public func isReflexive()->Bool{
        let bFrVerb = bVerb as! BFrenchVerb
        return bFrVerb.m_isReflexive
    }
    
    public override func getMorphStruct(tense: Tense, person: Person)->MorphStruct{
        return getBVerb().getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : true )
        //return getMorphStruct(tense: tense, person: person)
    }
}

public class SpanishVerb : RomanceVerb {
    
    public init(){
        super.init(word: "", type : .normal)
    }
    
    public init(jsonVerb: JsonVerb){
        super.init(jsonVerb: jsonVerb, language: .Spanish)
    }
    
    public override init(word: String, type: VerbType){
        super.init(word: word, type : type)
    }
    
    public override func createBVerb(){
        if ( bVerb.m_verbWord.count == 0){
            let bv = BSpanishVerb(verbPhrase: spanish)
            let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: bv.m_verbWord)
            bv.setPatterns(verbModel : verbModel)
            setBVerb(bVerb: bv)
        }
    }
    
    public override func getConjugateForm(tense: Tense, person : Person, showResidualPhrase: Bool)->String {
        createBVerb()
        let bSpVerb = bVerb as! BSpanishVerb
        
        switch tense {
        case .pastParticiple: return bSpVerb.getPastParticiple()
        case .presentParticiple: return bSpVerb.getPresentParticiple()
        case .infinitive: return bSpVerb.m_verbWord
        default:
            var conjugateString = bSpVerb.getConjugateForm(tense: tense, person: person)
            if showResidualPhrase && bSpVerb.getResidualPhrase().count > 0 {
                conjugateString += " " + bSpVerb.getResidualPhrase() }
            return conjugateString
        }
    }
    
    public func isReflexive()->Bool{
        let bSpVerb = bVerb as! BSpanishVerb
        return bSpVerb.m_isReflexive
    }
    
    public override func getMorphStruct(tense: Tense, person: Person)->MorphStruct{
        return getBVerb().getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : true )
//        return getMorphStruct(tense: tense, person: person)
    }
    
}

public class EnglishVerb : Verb {
    public var singularForm = ""
    
    public override init(){
        super.init(word: "", type : .normal)
    }
    
    public init(jsonVerb: JsonVerb){
        super.init(jsonVerb: jsonVerb, language: .English)
    }
    
    public override init(word: String, type: VerbType){
        super.init(word: word, type : type)
        singularForm = word + "s"
    }
    
    public override func getMorphStruct(tense: Tense, person: Person)->MorphStruct{
        return getBVerb().getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : true )
        //return getMorphStruct(tense: tense, person: person)
    }
    
    public func isConjugateForm(word: String)->(Bool, Tense, Person){
        if ( word == singularForm ){return (true, .present, .S3)}
        if ( word == self.word ){return (true, .present, .S1)}
        return (false, .present, .S1)
    }
    
    public override func createBVerb(){
        if ( bVerb.m_verbWord.count == 0){
            let bv = BEnglishVerb(verbPhrase: english, separable: .both)
            setBVerb(bVerb: bv)
        }
    }
    
    public func getConjugateForm(tense: Tense, person : Person, showResidualPhrase: Bool)->String{
        createBVerb()
        let bEnglishVerb = bVerb as! BEnglishVerb
        switch tense {
        case .pastParticiple: return bEnglishVerb.getPastParticiple()
        case .presentParticiple: return bEnglishVerb.getPresentParticiple()
        case .infinitive: return bEnglishVerb.m_verbWord
        default:
            var conjugateString = bEnglishVerb.getConjugateForm(tense: tense, person: person)
            if showResidualPhrase && bEnglishVerb.getResidualPhrase().count > 0 {
                conjugateString += " " + bEnglishVerb.getResidualPhrase() }
            return conjugateString
        }
    }
    
    public func isReflexive()->Bool{
        false
    }
    
}

