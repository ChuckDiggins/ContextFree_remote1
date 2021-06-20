//
//  Verb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation


//----------------------------------------------------------------------------------------

class Verb : Word {
    var bVerb = BVerb()
    var typeList = [VerbType]()
    var transitivity =  VerbTransitivity.transitive
    var passivity =  VerbPassivity.active
    var favoriteSubjects = [NounType]()
    var favoriteObjects = [NounType]()
    //var verbSemantics =  [VerbType]()
    //var typeListAsInt = [Int]()
    //var favoriteSubjectsAsInt = [Int]()
    //var favoriteObjectsAsInt = [Int]()
    //var verbSemanticsAsInt = [Int]()
    var tense = Tense.present
    var person = Person.S1
    var tensePersonSet = false
    var english = ""
    var spanish = ""
    var french = ""
    
    override init(){
        super.init(word: "", def : "", wordType : .verb)
    }
     
    init(spanish: String, french: String, english: String){
        self.spanish = spanish
        self.french = french
        self.english = english
        super.init(word: spanish, def: "", wordType: .verb)
    }
    
    init(word: String, def: String, type : VerbType){
        typeList.append(type)
        super.init(word: word, def: def, wordType: .verb)
    }
    
    init(word: String, def: String, type : VerbType, tense: Tense, person: Person){
        typeList.append(type)
        self.person = person
        self.tense = tense
        super.init(word: word, def: def, wordType: .verb)
    }
    
    init(word: String, def: String, wsd: WordStateData){
        typeList.append(wsd.verbType)
        self.person = wsd.person
        self.tense = wsd.tense
        self.transitivity = wsd.verbTransitivity
        self.passivity = wsd.verbPassivity
        super.init(word: word, def: def, wordType: .verb)
    }
    
    init(jsonVerb: JsonVerb, language: LanguageType){
        self.english = jsonVerb.english
        self.french = jsonVerb.french
        self.spanish = jsonVerb.spanish
        self.transitivity = jsonVerb.transitivity
        self.passivity = jsonVerb.passivity ?? VerbPassivity.passive
        switch(language){
        case .Spanish:  super.init(word: jsonVerb.spanish, def: jsonVerb.english, wordType: .verb)
        case .French:  super.init(word: jsonVerb.french, def: jsonVerb.english, wordType: .verb)
        case .English:  super.init(word: jsonVerb.english, def: jsonVerb.english, wordType: .verb)
        default:
            super.init(word: jsonVerb.spanish, def: jsonVerb.english, wordType: .verb)
        }
        
        convertVerbTypeStringToVerbTypes(inputString: jsonVerb.verbType)
        convertFavoriteSubjectStringToFavoriteNouns(inputString: jsonVerb.subjectLikes)
        convertFavoriteObjectStringToFavoriteNouns(inputString: jsonVerb.objectLikes)
    }
    
    func setBVerb(bVerb: BVerb){
        self.bVerb = bVerb
    }
    
    func getBVerb()->BVerb{
        return bVerb
    }
    
    func updateInfo(jsonVerb: JsonVerb){
        self.english = jsonVerb.english
        self.french = jsonVerb.french
        self.spanish = jsonVerb.spanish
        self.transitivity = jsonVerb.transitivity
        self.passivity = jsonVerb.passivity!
        convertVerbTypeStringToVerbTypes(inputString: jsonVerb.verbType)
        convertFavoriteSubjectStringToFavoriteNouns(inputString: jsonVerb.subjectLikes)
        convertFavoriteObjectStringToFavoriteNouns(inputString: jsonVerb.objectLikes)
        
    }
    
    func updateWords(english: String, french: String){
        self.english = english
        self.french = french
        self.spanish = word
    }
    
    func updateTransitivity(trans : VerbTransitivity){
        transitivity = trans
    }
    
    func updatePassivity(pass : VerbPassivity){
        passivity = pass
    }
    
    func updateVariables( vType: [String], subj : [String], obj : [String])
    {
        typeList.removeAll()
        for f in vType {
            typeList.append(getVerbTypeFromLetter(letter: f))
        }
        
        favoriteSubjects.removeAll()
        for f in subj {
            favoriteSubjects.append(getNounTypeFromString(str: f))
        }

        favoriteObjects.removeAll()
        for f in obj {
            favoriteObjects.append(getNounTypeFromString(str: f))
        }
    }

    func getWordAtLanguage(language: LanguageType)->String{
        switch(language){
        case .Spanish: return spanish
        case .English: return english
        case .French: return french
        default:
            return english
        }
    }
    
    func convertVerbTypeStringToVerbTypes(inputString: String){
        let util = VerbUtilities()
        let strList = getVerbTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                typeList.append(getVerbTypeFromLetter(letter: str))
            }
        }
    }
    
    func convertFavoriteSubjectStringToFavoriteNouns(inputString: String){
        let util = VerbUtilities()
        let strList = getNounTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                favoriteSubjects.append(getNounTypeFromString(str: str))}
        }
    }
    
    func convertFavoriteObjectStringToFavoriteNouns(inputString: String){
        let util = VerbUtilities()
        let strList = getNounTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                favoriteObjects.append(getNounTypeFromString(str: str))}
        }
    }
    
    func getFavoriteSubjects()->[NounType]{
        return favoriteSubjects
    }
    
    func getFavoriteObjects()->[NounType]{
        return favoriteObjects
    }
    
    func getVerbTypes()->[VerbType]{
        return typeList
    }
    
    func convertFavoriteSubjectsToCompositeString()->String{
        var compositeString = ""
        for nt in favoriteSubjects{
            let fav = getNounTypeStringAtIndex(index: nt.rawValue)
                compositeString.append(fav)
        }
        return compositeString
    }
    
    func convertFavoriteObjectsToCompositeString()->String{
        var compositeString = ""
        for nt in favoriteObjects{
            compositeString.append(getNounTypeStringAtIndex(index: nt.rawValue))
        }
        return compositeString
    }
    
    func convertVerbTypesToCompositeString()->String{
        var compositeString = ""
        for vt in typeList{
            compositeString.append(getVerbTypeAsLetter(index: vt.rawValue))
        }
        return compositeString
    }
    
    func createJsonVerb()->JsonVerb{
        let jv : JsonVerb
        if ( passivity == .passive ){
            jv = JsonVerb(spanish: word, english: english, french: french, subjectLikes: convertFavoriteSubjectsToCompositeString())
        }
        else {
            jv = JsonVerb(spanish: word, english: english, french: french,   transitivity: transitivity, verbType : convertVerbTypesToCompositeString(),  passivity: passivity, subjectLikes: convertFavoriteSubjectsToCompositeString(), objectLikes: convertFavoriteObjectsToCompositeString())
        }
        return jv
    }
    
    
    func isNormal()->Bool{
        for vt in typeList{
            if vt == .normal { return true}
        }
        return false
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
    var pastParticiple = ""
    var presentParticiple = ""
    
    override init(jsonVerb: JsonVerb, language: LanguageType){
        super.init(jsonVerb: jsonVerb, language: language)
    }
    
    override init(word: String, def: String, type: VerbType, tense: Tense, person: Person){
        super.init(word: word, def: def, type : type)
        setTensePerson(tense: tense, person: person)
    }
    
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
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
    init(){
        super.init(word: "", def: "", type : .normal)
    }
    
    init(jsonVerb: JsonVerb){
        super.init(jsonVerb: jsonVerb, language: .French)
    }
    
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
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
    
    init(){
        super.init(word: "", def: "", type : .normal)
    }
    
    init(jsonVerb: JsonVerb){
        super.init(jsonVerb: jsonVerb, language: .Spanish)
    }
    
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
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
    
    override init(){
        super.init(word: "", def: "", type : .normal)
    }
    
    init(jsonVerb: JsonVerb){
        super.init(jsonVerb: jsonVerb, language: .English)
    }
    
    override init(word: String, def: String, type: VerbType){
        super.init(word: word, def: def, type : type)
        singularForm = word + "s"
    }
    
    func isConjugateForm(word: String)->(Bool, Tense, Person){
        if ( word == singularForm ){return (true, .present, .S3)}
        if ( word == self.word ){return (true, .present, .S1)}
        return (false, .present, .S1)
    }
    
    func getConjugateForm(tense: Tense, person : Person)->String{
        let bEnglishVerb = bVerb as! BEnglishVerb
        switch tense {
        case .pastParticiple: return bEnglishVerb.getPastParticiple()
        case .presentParticiple: return bEnglishVerb.getPresentParticiple()
        case .infinitive: return bEnglishVerb.m_verbWord
        default:  return bEnglishVerb.getConjugateForm(tense: tense, person: person)
        }
    }
    
}

