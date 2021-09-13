//
//  BRomanceVerb.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/24/21.
//

import Foundation

class BRomanceVerb: BVerb {
    var verbEnding : VerbEnding
    var m_verbStem = ""
    var m_isReflexive : Bool
    var m_stemChanging = false
    var m_stemFrom = ""
    var m_stemTo = ""
    
    
    var m_preposition = ""
    var bVerbModel = RomanceVerbModel(id: -1, modelVerb: "")
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
    
    var m_morphStruct = [MorphStruct]()
    var m_initialMorphObject = [MorphStruct]()

    var replaceMultipleList = [ReplaceMultipleForm]()
    var replaceModelList = [ReplaceModelForm]()
    var stemSingleList = [StemSingleForm]()
    var dropLettersList = [DropLettersForm]()
    var replaceEndingList = [ReplaceEndingForm]()
    
    init(verbPhrase: String, language: LanguageType){
        let verbStuff = VerbUtilities().analyzeWordPhrase(testString: verbPhrase)
        self.verbEnding = verbStuff.verbEnding
        self.m_isReflexive = verbStuff.isReflexive
        self.m_preposition = ""
        var constructedVerbPhrase = verbStuff.verbWord
        if ( verbStuff.isReflexive){constructedVerbPhrase += "se"}
        if verbStuff.residualPhrase.count>0 { constructedVerbPhrase += " " + verbStuff.residualPhrase  }
        super.init(verbPhrase: constructedVerbPhrase, verbWord: verbStuff.verbWord, languageType: language)
    }
        
    init(verbPhrase: String, verbWord: String, verbEnding: VerbEnding, languageType: LanguageType, isReflexive: Bool, preposition : String){
        self.verbEnding = verbEnding
        self.m_isReflexive = isReflexive
        self.m_preposition = preposition
        super.init(verbPhrase: verbPhrase, verbWord: verbWord, languageType: languageType)
    }
    
    override init(){
        self.verbEnding = .none
        self.m_isReflexive = false
        self.m_preposition = ""
        super.init(verbPhrase: "", verbWord: "", languageType: LanguageType.Spanish)
    }

    func isOrthoPresent(tense: Tense, person: Person)->Bool{
        if ( (tense == .present && person == .S1 ) || tense == .presentSubjunctive) && m_orthoPresent { return true }
        return false
    }

    
    func isOrthoPreterite(tense: Tense, person: Person)->Bool{
        if ( (tense == .preterite && person == .S1 ) || tense == .presentSubjunctive) && m_orthoPreterite { return true }
        return false
    }
    
    func hasReplaceEndingForm (tense: Tense, person: Person)->(String, String){
        for form in replaceEndingList{
            if form.tense == tense && form.person == person {
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
        return m_preposition.count>0
    }
 
    func hasPreposition()->Bool{
        return m_preposition.count>0
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
        return verbEnding == VerbEnding.AR
    }
    
    func isER()->Bool{
        return verbEnding == VerbEnding.ER
    }
    
    
    func isIR()->Bool{
        return verbEnding == VerbEnding.IR
    }
    
    func isRE()->Bool{
        return verbEnding == VerbEnding.RE
    }
    
     
     
    func initializeMorphStructs(){
        //create and initialize the morph struct
        
        for person in Person.allCases {
            //m_initialMorphObject.clear()
            m_initialMorphObject.append(MorphStruct(person: person))
            m_morphStruct.append(MorphStruct(person: person))
            var morphStep = MorphStep()
            var verbForm = m_verbWord
            if isReflexive() { verbForm = verbForm + "se" }
            morphStep.index = 0
            morphStep.morphType = .startWithInfinitive
            morphStep.verbForm = verbForm
            morphStep.part1 = verbForm
            morphStep.comment = "start with the infinitive ->" + morphStep.part1
            m_initialMorphObject[person.rawValue].clear()
            m_initialMorphObject[person.rawValue].append(morphStep : morphStep)
            m_morphStruct[person.rawValue].clear()
            m_morphStruct[person.rawValue].append(morphStep : morphStep)
            //if person == .S1 {
            //    print("initialize:  morphStepCount = \( m_morphStruct[person.rawValue].count())")
           // }
        }

    }
    func getBescherelleInfo()->String {
        return "Besch #\(bVerbModel.id) (\(bVerbModel.modelVerb))"
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
    
    func createPastParticiple(verb: BRomanceVerb)->String {
        let word = verb.m_verbStem
        switch verb.verbEnding {
        case .AR: return word + "ado"
        case .ER, .IR, .accentIR: return word + "ido"
        default: return word + "nada"
        }
    }
    
    func createGerund(verb: BRomanceVerb)->String {
        let word = verb.m_verbStem
        switch verb.verbEnding {
        case .AR: return word + "ando"
        case .ER, .IR, .accentIR: return word + "iendo"
        default: return word + "nada"
        }
    }
    
    func getConjugateForm(tense : Tense, person : Person)->String {
        let ms = getConjugatedMorphStruct( tense : tense, person : person , conjugateEntirePhrase : false)
        return ms.finalVerbForm()
    }
    
    func setPatterns (verbModel : RomanceVerbModel) {
        bVerbModel = verbModel
       
        //bRomanceVerb specific
        initializeMorphStructs()
        if isReflexive() { addReflexiveMorphing() }
        
        /*
        let printThis = false
        
        if printThis {
            for person in Person.allCases {
                print("In SetPatterns creating morph structs - final form \(person.getIndex()) = \(getFinalVerbForm(person : person))")
            }
        }
        
 */
        //do some other stuff while we are at it
        m_verbStem = getVerbStem(verbWord : m_verbWord , verbEnding: verbEnding)
        m_pastParticiple = createPastParticiple(verb : self)
        m_gerund = createGerund(verb : self)
        
        //extract verb model stuff
        /*
        m_verbModelParseList = bVerbModel.parseVerbModel()
       
        BSpanishVerbExtras().readModelParseStuff(verb: self)
        
        computeP3PreteriteForm()
        
        setRestrictions()
        */
        
    }//SetPatterns

    func addReflexiveMorphing(){
        //create and initialize the morph structs
        
        let vrp = Pronoun()
        
        for person in Person.allCases {
            var morphStep = MorphStep()
            morphStep.index = 0
            morphStep.morphType = .nada
            morphStep.verbForm = m_verbWord
            morphStep.part1 = m_verbWord
            morphStep.part2 = "se"
            morphStep.comment = "grab the reflexive pronoun -> se"
            m_initialMorphObject[person.rawValue].append(morphStep : morphStep)
            m_morphStruct[person.rawValue].append(morphStep : morphStep)
            
            morphStep = MorphStep()
            morphStep.index = 0
            morphStep.morphType = .nada
            //morphStep.verbForm = m_verbWord
            morphStep.part1 = ""
            morphStep.part2 = vrp.getReflexive(person: person) + " "
            morphStep.part3 = m_verbWord
            morphStep.verbForm = morphStep.part1 + morphStep.part2 + morphStep.part3
            morphStep.comment = "convert to person and move to front of the verb"
            m_initialMorphObject[person.rawValue].append(morphStep : morphStep)
            m_morphStruct[person.rawValue].append(morphStep : morphStep)
        }

    }
    
    func setMorphStruct(person : Person, morphStruct : MorphStruct){
        m_morphStruct[person.rawValue].copyContents(input: morphStruct)
    }
 
    func resetMorphStructs() {
        for p in 0..<6 {
            m_morphStruct[p].clear()
        }
    }
    
    func resetMorphStructIndices() {
        for p in 0..<6 {
            m_morphStruct[p].resetMorphIndex()
        }
    }

    func restartMorphSteps(person : Person){
        m_morphStruct[person.rawValue].resetMorphIndex()
    }
    
    func isFinalMorphStep(person : Person)->Bool{
        return m_morphStruct[person.rawValue].isFinalMorphStep()
    }
    
    func incrementMorphStep(person : Person)->MorphStep {
        m_morphStruct[person.rawValue].incrementIndex()
        return getCurrentMorphStep(person : person)
    }
    
    func getCurrentMorphIndex(person : Person)-> Int {
        return m_morphStruct[person.rawValue].getMorphIndex()
    }
    
    func getFinalVerbForm(person: Person)->String{
        getMorphStruct(person : person).finalVerbForm()
    }
    
    func getCurrentMorphStep(person : Person)->MorphStep{
        return m_morphStruct[person.rawValue].getCurrentMorphStep()
    }
    
    func getMorphStepCount(person: Person)->Int{
        return getMorphStruct(person : person).count()
    }
    
    func getMorphStruct(person : Person)-> MorphStruct {
        return m_morphStruct[person.rawValue]
    }
    


  
}
