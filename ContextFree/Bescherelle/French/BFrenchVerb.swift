//
//  BFrenchVerb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/26/21.
//

import Foundation

enum EndingType {
    case RE_ENDING
    case RE_ENDING1
    case RE_ENDING2
    case RE_ENDING3
    case IR_ENDING  //used by paraître imperfect
    case IR_ENDING1
    case IR_ENDING2
    case OIR_ENDING1
    case OIR_ENDING2
    case OIR_ENDING3
    case overrideER
    case none
}

struct ModelVerbEnding{
    var tense = Tense.gerund
    var type = EndingType.none
}

class BFrenchVerb : BRomanceVerb {
    
    var p3PreteriteWord = ""

    var m_useThis = false
    
    var m_specialModel = SpecialFrenchVerbModel.none
    var m_isImpersonal1 = false
    var m_isImpersonal2 = false
    
    var m_presentStemChanging = false
    var m_presentStemFrom = ""
    var m_presentStemTo = ""
    
    var m_presentSubjStemChanging = false
    var m_presentSubjStemFrom = ""
    var m_presentSubjStemTo = ""
    
    var m_modelVerbEndingList = [ModelVerbEnding]()
    
    var m_verbModelParseList = [ParsedExceptionStruct]()
    
    init(verbPhrase: String){
        super.init(verbPhrase: verbPhrase, language: .French)
    }
    
    init(verbPhrase: String, verbWord: String, verbEnding : VerbEnding, languageType : LanguageType, preposition: String, isReflexive: Bool){
        
        super.init(verbPhrase: verbPhrase, verbWord: verbWord, verbEnding : verbEnding, languageType: languageType, isReflexive : isReflexive, preposition : preposition)
    }
    
    override init(){
        
        super.init(verbPhrase: "", verbWord: "", verbEnding : .none, languageType: .Spanish, isReflexive : false, preposition : "")
    }
    
    override func setPatterns (verbModel : RomanceVerbModel) {
        bVerbModel = verbModel
       
        //bRomanceVerb specific
        initializeMorphStructs()
        if isReflexive() { addReflexiveMorphing() }
        

        //do some other stuff while we are at it
        m_verbStem = getVerbStem(verbWord : m_verbWord , verbEnding: verbEnding)
        
        m_verbModelParseList = bVerbModel.parseVerbModel()
        readModelParseStuff()
        
    }//SetPatterns
    
    override func getConjugateForm(tense : Tense, person : Person)->String {
        let ms = getConjugatedMorphStruct( tense : tense, person : person , conjugateEntirePhrase : false)
        return ms.finalVerbForm()
    }
    
    //these patterns are not mutually exclusive
    
    override func getConjugatedMorphStruct( tense : Tense, person : Person , conjugateEntirePhrase : Bool) -> MorphStruct {
        
        //simple indicative tenses
        let tenseIndex =  tense.getIndex()
        
        
        if tenseIndex <= Tense.future.getIndex() {
            let ms = ActiveVerbConjugationFrench().conjugateThisSimpleIndicativeNew( verb: self, tense : tense, person : person, conjugateEntirePhrase : conjugateEntirePhrase )
            setMorphStruct(person: person, morphStruct: ms)
            return ms
        }
        
        if ( tenseIndex == Tense.imperative.getIndex()){
            
            let ms = ActiveVerbConjugationFrench().conjugateThisImperativeForm(verb: self, person: person, conjugateEntirePhrase: conjugateEntirePhrase)
            setMorphStruct(person: person, morphStruct: ms)
            return ms
        }
        
        //simple subjunctive tenses
        
        if tenseIndex >= Tense.presentSubjunctive.getIndex() && tenseIndex <= Tense.imperfectSubjunctiveSE.getIndex() {
            //print("get p3 verb word = \(getP3PreteriteForm())")
            let ms = ActiveVerbConjugationFrench().conjugateThisSimpleIndicativeNew( verb: self, tense : tense, person : person, conjugateEntirePhrase : conjugateEntirePhrase )
            setMorphStruct(person: person, morphStruct: ms)
            return ms
        }
        
        //perfect tenses - indicative and subjunctive
        
        if tenseIndex >= Tense.presentPerfect.getIndex() && tenseIndex <= Tense.conditionalProgressive.getIndex() {
            let ms = ActiveVerbConjugationFrench().conjugateThisCompoundVerb( verb: self, tense : tense, person : person, conjugateEntirePhrase : conjugateEntirePhrase )
            setMorphStruct(person: person, morphStruct: ms)
            return ms
        }
    
        return MorphStruct(person: person)
    }
    
    func restoreMorphStructs()
    {
        for person in Person.allCases {
            restoreMorphStructs(person: person)
        }
    }
    
    func restoreMorphStructs(person : Person)
    {
        m_morphStruct[person.rawValue].clear()
        m_morphStruct[person.rawValue].copyContents(input: m_initialMorphObject[person.rawValue])
    }

    
    func readModelParseStuff(){
        
        for parseStruct in m_verbModelParseList {
            if ( parseStruct.pattern == .IMPERSONAL1){
                m_isImpersonal1 = true
            }
            
            if ( parseStruct.pattern == .IMPERSONAL2){
                m_isImpersonal2 = true
            }
            
            if ( parseStruct.pattern == .SPECIAL){
                m_isIrregular = true
                switch parseStruct.from {
                case "avoir" : m_specialModel = SpecialFrenchVerbModel.AVOIR
                case "être" : m_specialModel = SpecialFrenchVerbModel.ETRE  //using the model, so far
                
                default: break
                }
            }
            //if this exists, use it
            
            if ( parseStruct.pattern == .REPLACEINFINITIVE){
                m_isIrregular = true
                m_baseVerbInfinitive = parseStruct.from
                m_replacementVerbInfinitive = parseStruct.to
            }
            
            if ( parseStruct.pattern == .STEM && parseStruct.tense == .present){
                m_presentStemChanging = true
                m_presentStemFrom = parseStruct.from
                m_presentStemTo = parseStruct.to
            }
            
            if ( parseStruct.pattern == .STEM && parseStruct.tense == .presentSubjunctive){
                m_presentSubjStemChanging = true
                m_presentSubjStemFrom = parseStruct.from
                m_presentSubjStemTo = parseStruct.to
            }
            
            //if replacing, add it to the list
            
            if ( parseStruct.pattern == .REPLACE){
                m_isIrregular = true
                var replaceMultipleForm = ReplaceMultipleForm()
                replaceMultipleForm.personList = parseStruct.personList
                replaceMultipleForm.tense = parseStruct.tense
                replaceMultipleForm.fromWord = parseStruct.from
                replaceMultipleForm.toWord = parseStruct.to
                replaceMultipleList.append(replaceMultipleForm)
            }
            
            //if replacing, add it to the list
            
            if ( parseStruct.pattern == .REPLACEIT){
                m_isIrregular = true
                var replaceForm = ReplaceModelForm()
                replaceForm.person = parseStruct.personList[0]
                replaceForm.tense = parseStruct.tense
                replaceForm.fromWord = parseStruct.from
                replaceForm.toWord = parseStruct.to
                replaceModelList.append(replaceForm)
            }
            
            //if use different ending - such as Tenir --
            // right now:  tense=gerund means all relevant tenses will have short ending
            //             tense=present, or other tense, means only this tense will have short ending
            
            switch parseStruct.pattern{
            case .RE_ENDING: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .RE_ENDING))
            case .RE_ENDING1: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .RE_ENDING1))
            case .RE_ENDING2: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .RE_ENDING2))
            case .RE_ENDING3: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .RE_ENDING3))
            case .IR_ENDING: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .IR_ENDING))
            case .IR_ENDING1: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .IR_ENDING1))
            case .IR_ENDING2: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .IR_ENDING2))
            case .OIR_ENDING1: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .OIR_ENDING1))
            case .OIR_ENDING2: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .OIR_ENDING2))
            case .OIR_ENDING3: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .OIR_ENDING3))
            case .OVERRIDE_ER: m_modelVerbEndingList.append(ModelVerbEnding(tense: parseStruct.tense, type: .overrideER))
            default: break
            }
            
            //if replacing, add it to the list
            
            if ( parseStruct.pattern == .STEMSINGLE){
                var stemSingleForm = StemSingleForm()
                stemSingleForm.person = parseStruct.personList[0]
                stemSingleForm.tense = parseStruct.tense
                stemSingleForm.fromWord = parseStruct.from
                stemSingleForm.toWord = parseStruct.to
                stemSingleList.append(stemSingleForm)
            }
            
            
            //if replacing, add it to the list
            
            if ( parseStruct.pattern == .DROPLETTERS){
                var dropLettersForm = DropLettersForm()
                dropLettersForm.personList = parseStruct.personList
                dropLettersForm.tense = parseStruct.tense
                dropLettersForm.fromWord = parseStruct.from
                dropLettersList.append(dropLettersForm)
            }
            
            //if replacing, add it to the list
            
            if ( parseStruct.pattern == .REPLACEENDING){
                m_isIrregular = true
                var form = ReplaceEndingForm()
                form.person = parseStruct.personList[0]
                form.tense = parseStruct.tense
                form.fromWord = parseStruct.from
                form.toWord = parseStruct.to
                replaceEndingList.append(form)
            }
            
            if ( parseStruct.pattern == .ORTHO){
                if ( parseStruct.tense == .present ){
                    m_orthoPresent = true
                    m_orthoPresentFrom = parseStruct.from
                    m_orthoPresentTo = parseStruct.to
                }
                if ( parseStruct.tense == .preterite ){
                    m_orthoPreterite = true
                    m_orthoPreteriteFrom = parseStruct.from
                    m_orthoPreteriteTo = parseStruct.to
                }
            }
        }

    }
        

}
