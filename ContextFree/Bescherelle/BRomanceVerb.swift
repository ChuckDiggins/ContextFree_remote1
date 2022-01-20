//
//  BRomanceVerb.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/24/21.
//

import Foundation

class BRomanceVerb: BVerb {
    var m_verbStem = ""
    var m_stemChanging = false
    var m_stemFrom = ""
    var m_stemTo = ""
    //----------------------------------
    var bVerbModel = RomanceVerbModel()
    var m_orthoPresent = false
    var m_orthoPresentFrom = ""
    var m_orthoPresentTo = ""
    
    var m_orthoPreterite = false
    var m_orthoPreteriteFrom = ""
    var m_orthoPreteriteTo = ""
    
    var m_baseVerbInfinitive = ""
    var m_replacementVerbInfinitive = ""   //for replacing infinitive in Future and Conditional tenses
                                                // poder -> podr
    
    var restrictions = [String]()
    
    //var m_morphStruct = [MorphStruct]()
    //var m_initialMorphObject = [MorphStruct]()

    var replaceMultipleList = [ReplaceMultipleForm]()
    var replaceModelList = [ReplaceModelForm]()
    var stemSingleList = [StemSingleForm]()
    var dropLettersList = [DropLettersForm]()
    var replaceEndingList = [ReplaceEndingForm]()
    
    init(verbPhrase: String, language: LanguageType){
        super.init(verbPhrase: verbPhrase, languageType: language)
    }
    
    override init(){
        super.init(verbPhrase: "", languageType: .Agnostic)
    }

    func isOrthoPresent(tense: Tense, person: Person)->Bool{
        if ( (tense == .present && person == .S1 ) || tense == .presentSubjunctive) && m_orthoPresent { return true }
        return false
    }

    
    func isOrthoPreterite(tense: Tense, person: Person)->Bool{
        if ( (tense == .preterite && person == .S1 ) || tense == .presentSubjunctive) && m_orthoPreterite { return true }
        return false
    }
    
    func hasReplaceForm (tense: Tense, person: Person)->(String, String){
        for form in replaceModelList{
            if form.tense == tense && form.person == person {
                return (form.fromWord, form.toWord)
            }
        }
        return ("", "")
    }
    
    func hasMultipleReplaceForm (tense: Tense, person: Person)->(String, String){
        //pass through the multiple lists in case there is later (override) replacement for this tense/person
        var fromWord = ""
        var toWord = ""
        for form in replaceMultipleList{
            for p in form.personList {
                if form.tense == tense && p == person {
                    fromWord = form.fromWord
                    toWord = form.toWord
                    break
                }
            }
        }
        return (fromWord, toWord)
    }
    
    
    func hasReplaceEndingForm (tense: Tense, person: Person)->(String, String){
        for form in replaceEndingList{
            if form.tense == tense && form.person == person {
                return (form.fromWord, form.toWord)
            }
        }
        return ("", "")
    }
    
    func hasReplaceEndingForm (tense: Tense)->(String, String){
        for form in replaceEndingList{
            if form.tense == tense {
                return (form.fromWord, form.toWord)
            }
        }
        return ("", "")
    }
    
    func hasStemSingleForm (tense: Tense, person: Person)->(String, String){
        for form in stemSingleList{
            if form.tense == tense && form.person == person {
                return (form.fromWord, form.toWord)
            }
        }
        return ("", "")
    }
    
    func hasDropLettersForm (tense: Tense, person: Person)->(String){
        //pass through the multiple lists in case there is later (override) replacement for this tense/person
        var fromWord = ""

        for form in dropLettersList{
            for p in form.personList {
                if form.tense == tense && p == person {
                    fromWord = form.fromWord
                    break
                }
            }
        }
        return (fromWord)
    }

    func setRestrictions(){
        //var restrictions = [String]()
        if isStemChanging() { restrictions.append("stm")}
        if isOrthographicPresent() || isOrthographicPreterite() { restrictions.append("ort")}
        if isSpecial() { restrictions.append("spc")}
        if isIrregular() { restrictions.append("irr")}
        if isReflexive() {restrictions.append("rfl")}
        if hasPreposition() {restrictions.append("cls")}
    }
    
    func isSpecial()->Bool{
        return false
    }

    func isOrthographicPresent()->Bool{
        return m_orthoPresent
    }
    
    func isOrthographicPreterite()->Bool{
        return m_orthoPreterite
    }
    
    func isReflexive()->Bool{
        return m_isReflexive
    }
    
    func isVerbPhrase()->Bool{
        return m_residualPhrase.count>0
    }
 
    func hasPreposition()->Bool{
        return m_residualPhrase.count>0
    }
    
    func getVerbStem(verbWord: String, verbEnding : VerbEnding )->String {
        var verbStem = verbWord
        verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        if verbEnding == .RE {
            verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        }
        return verbStem
    }

    func isStemChanging()->Bool {
        return m_stemChanging
        //return bVerbModel.isStemChanging
    }

    func isPersonStem(person: Person)->Bool {
        if person == .P1 || person == .P2 {return false}
        return true
    }
    
    func isAR()->Bool{
        return m_verbEnding == VerbEnding.AR
    }
    
    func isER()->Bool{
        return m_verbEnding == VerbEnding.ER
    }
    
    
    func isIR()->Bool{
        return m_verbEnding == VerbEnding.IR
    }
    
    func isRE()->Bool{
        return m_verbEnding == VerbEnding.RE
    }
     
//    func initializeMorphStructs(){
//        //create and initialize the morph struct
//        
//        for person in Person.allCases {
//            var morphStep = MorphStep()
//            var verbForm = m_verbWord
//            if isReflexive() { verbForm = verbForm + "se" }
//            morphStep.verbForm = verbForm
//            morphStep.part1 = verbForm
//            morphStep.comment = "start with the infinitive ->" + morphStep.part1
//            let morphStruct = MorphStruct(person: person)
//            morphStruct.append(morphStep : morphStep)
//            morphStructManager.setBoth(person: person, ms: morphStruct)
//        }
//    }
    
    func getBescherelleInfo()->String {
        return "Besch #\(bVerbModel.id) (\(bVerbModel.modelVerb))"
    }

    func createPastParticiple()->String {
        return ""
    }
    
    func createGerund()->String {
        return ""
    }
    
    func getConjugateForm(tense : Tense, person : Person)->String {
        let _ = getConjugatedMorphStruct( tense : tense, person : person , conjugateEntirePhrase : false)
        return morphStructManager.getFinalVerbForm(person: person)
    }
    
    func setPatterns (verbModel : RomanceVerbModel) {
        bVerbModel = verbModel
       
        //bRomanceVerb specific
        initializeMorphStructs()
        if isReflexive() { addReflexiveMorphing() }
        
        //do some other stuff while we are at it
        m_verbStem = getVerbStem(verbWord : m_verbWord , verbEnding: m_verbEnding)
        m_pastParticiple = createPastParticiple()
        m_gerund = createGerund()
        
        //extract verb model stuff
        /*
        m_verbModelParseList = bVerbModel.parseVerbModel()
       
        BSpanishVerbExtras().readModelParseStuff(verb: self)
        
        computeP3PreteriteForm()
        
        setRestrictions()
        */
        
    }//SetPatterns
    
    // - MARK: Reflexive Morphing

    func addFrenchReflexiveMorphing(){
        
        //create and initialize the morph structs
        
        let vrp = Pronoun()
        let startsWithVowelSound = VerbUtilities().startsWithVowelSound(characterArray: m_verbWord)
        
        //for reflexive verbs, start morphing with grabbing the reflexive pronoun
        
        for person in Person.allCases {
//            var morphStruct = morphStructManager.get(person: person)
            var morphStruct = MorphStruct(person: person)
            var morphStep = MorphStep()
            morphStep.verbForm = m_verbWord
            morphStep.part1 = ""
            morphStep.part2 = "se "
            morphStep.part3 = m_verbWord
            morphStep.comment = "grab reflexive pronoun -> se"
            morphStruct.append(morphStep : morphStep)
            
            //if this is a contraction, do not add space  m' or me
            var contractThis = true
            if person == .P1 || person == .P2 { contractThis = false }
            if !startsWithVowelSound { contractThis = false }
            
            morphStep = MorphStep()
            morphStep.part1 = ""
            morphStep.part2 = vrp.getReflexive(language: languageType, person: person, startsWithVowelSound: startsWithVowelSound)   //only relevant for French
            if !contractThis { morphStep.part2 += " " }
            morphStep.part3 = m_verbWord
            morphStep.verbForm = morphStep.part1 + morphStep.part2 + morphStep.part3
            if startsWithVowelSound && contractThis {
                morphStep.comment = "\(m_verbWord) starts with vowel sound: convert 'se' to \(morphStep.part2) "}
            else {
                morphStep.comment = "convert to \(morphStep.part2)"
            }
            morphStruct.append(morphStep : morphStep)
            morphStructManager.setBoth(person: person, ms: morphStruct)
        }

    }
    
    func addReflexiveMorphing(){
        
        //create and initialize the morph structs  
        let vrp = Pronoun()
        
        for person in Person.allCases {
            var morphStruct = MorphStruct(person: person)
            var morphStep = MorphStep()
            morphStep.verbForm = m_verbWord
            morphStep.part1 = m_verbWord
            morphStep.part2 = "se"
            morphStep.comment = "grab the reflexive pronoun -> se"
            morphStruct.append(morphStep : morphStep)

            let startsWithVowelSound = VerbUtilities().startsWithVowelSound(characterArray: m_verbWord)
            morphStep = MorphStep()
            morphStep.part1 = ""
            morphStep.part2 = vrp.getReflexive(language: languageType, person: person, startsWithVowelSound: startsWithVowelSound) + " "
            morphStep.part3 = m_verbWord
            morphStep.verbForm = morphStep.part1 + morphStep.part2 + morphStep.part3
            morphStep.comment = "convert to \(morphStep.part2) and move in front of the verb"
            morphStruct.append(morphStep : morphStep)
            morphStructManager.setBoth(person: person, ms: morphStruct)
        }
    }
    
//    func setMorphStruct(person : Person, morphStruct : MorphStruct){
//        morphStructManager.set(person: person, ms: morphStruct)
//    }
//
//    func resetMorphStructs() {
//        morphStructManager.restoreToInitialState()
//    }
//
//    func resetMorphStructIndices() {
//        morphStructManager.resetCurrentMorphStepIndices()
//    }
//
//    func restartMorphSteps(person : Person){
//        morphStructManager.resetCurrentMorphStepIndex(person: person)
//    }
//
//    func isFinalMorphStep(person : Person)->Bool{
//        morphStructManager.get(person: person).isFinalMorphStep()
//    }
//
//    func incrementMorphStep(person : Person)->MorphStep {
//        morphStructManager.getNextMorphStep(person: person)
//    }
//
//    func getCurrentMorphIndex(person : Person)-> Int {
//        morphStructManager.getCurrentMorphStepIndex(person: person)
//    }
//
//    func getCurrentMorphStep(person : Person)->MorphStep{
//        morphStructManager.getCurrentMorphStep(person: person)
//    }
//
//    func getMorphStepCount(person: Person)->Int{
//        morphStructManager.getMorphStepCount(person: person)
//    }
//
//    func getMorphStruct(person : Person)-> MorphStruct {
//        morphStructManager.get(person: person)
//    }
//
}
