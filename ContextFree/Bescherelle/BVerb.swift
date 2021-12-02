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

//Chuck - NOvember 25
class BVerb : Word, Identifiable {
    var id = UUID()
    
    var m_verbPhrase : String
    var m_verbWord : String
    var languageType : LanguageType
    var m_isPassive = false
    var m_isIrregular = false
    var m_residualPhrase = ""
    var m_isReflexive = false           //not used for English
    var m_verbEnding = VerbEnding.AR    //not used for English
    var m_pastParticiple = ""
    var m_gerund = ""
    private var m_isConjugated = false
    var morphStructManager : MorphStructManager
    
    let verbStuff : (verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool)
    
    override init(){
        self.morphStructManager = MorphStructManager(verbPhrase: "", tense: .present)
        self.m_verbPhrase = ""
        self.m_verbWord = ""
        self.languageType = LanguageType.Agnostic
        verbStuff = ("", .ER, "", false)
        super.init(word: "", wordType: .verb)
    }
    
    init(verbPhrase: String, languageType: LanguageType){
        self.m_verbPhrase = verbPhrase
        self.languageType = languageType
        
        switch (languageType){
        case .Spanish:
            verbStuff = VerbUtilities().analyzeSpanishWordPhrase(testString: verbPhrase)
        case .French:
            verbStuff = VerbUtilities().analyzeFrenchWordPhrase(phraseString: verbPhrase)
        case .English:
            verbStuff = VerbUtilities().analyzeEnglishWordPhrase(testString: verbPhrase)
        default:
            verbStuff = ("", .ER, "", false)
        }
        self.morphStructManager = MorphStructManager(verbPhrase: verbPhrase, tense: .present)
        m_verbWord = verbStuff.verbWord
        m_residualPhrase = verbStuff.residualPhrase
        m_isReflexive = verbStuff.isReflexive
        m_verbEnding = verbStuff.verbEnding
        super.init(word: m_verbWord, wordType: .verb)
    }
    
    func initializeMorphStructs(){
        //create and initialize the morph struct
        
        for person in Person.allCases {
            var morphStep = MorphStep()
            var verbForm = m_verbWord
            if m_isReflexive { verbForm = verbForm + "se" }
            morphStep.verbForm = verbForm
            morphStep.part1 = verbForm
            morphStep.comment = "start with the infinitive ->" + morphStep.part1
            var morphStruct = MorphStruct(person: person)
            morphStruct.append(morphStep : morphStep)
            morphStructManager.setBoth(person: person, ms: morphStruct)
        }
        morphStructManager.dumpSkinny(message: "BVerb: initializeMorphStructs")
        
    }
    func isPhrasalVerb()->Bool{
        m_residualPhrase.count > 1
    }
    
    func getResidualPhrase()->String{
        m_residualPhrase
    }
    
    func getInfinitiveAndParticiples()->(String, String, String){
        return (word, m_pastParticiple, m_gerund)
    }
    
    func getPresentParticiple()->String{
        m_gerund
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
    
    func getConjugatedMorphStruct( tense : Tense, person : Person , conjugateEntirePhrase : Bool) {
        //morphStructManager.get(person: person)
    }
    
    func getMorphStruct(person: Person) -> MorphStruct {
        morphStructManager.get(person: person)
    }
    
    func getMorphStructManager()->MorphStructManager{
        morphStructManager
    }

    func getFinalVerbForm(person: Person)->String{
        morphStructManager.getFinalVerbForm(person: person)
    }

    func setMorphStruct(person : Person, morphStruct : MorphStruct){
        morphStructManager.set(person: person, ms: morphStruct)
    }
 
    func resetMorphStructs() {
        morphStructManager.restoreToInitialState()
    }
    
    func resetMorphStructIndices() {
        morphStructManager.resetCurrentMorphStepIndices()
    }

    func restartMorphSteps(person : Person){
        morphStructManager.resetCurrentMorphStepIndex(person: person)
    }
    
    func isFinalMorphStep(person : Person)->Bool{
        morphStructManager.get(person: person).isFinalMorphStep()
    }
   
    func incrementMorphStep(person : Person)->MorphStep {
        morphStructManager.getNextMorphStep(person: person)
    }
    
    func getCurrentMorphIndex(person : Person)-> Int {
        morphStructManager.getCurrentMorphStepIndex(person: person)
    }
    
    func getCurrentMorphStep(person : Person)->MorphStep{
        morphStructManager.getCurrentMorphStep(person: person)
    }
    
    func getMorphStepCount(person: Person)->Int{
        morphStructManager.getMorphStepCount(person: person)
    }
    
    

}
