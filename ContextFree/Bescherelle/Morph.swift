//
//  Morph.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 11/15/20.
//

import Foundation

enum    eMorphType : String
{
    case nada = "nada"
    case startWithInfinitive = "Start with infinitive phrase"
    case removeVerbEnding = "Remove 2-letter verb ending"
    case removeModelVerb = "Remove model verb"
    case appendStem = "Append verb stem"
    case appendEnding = "Append ending"
    case onlyAppendEnding = "Only append ending"
    case appendReflexivePronoun = "Append reflexive pronoun"
    case appendWord = "Append word"
    case appendOrthoChange = "Append ortho change"
    case appendPresentEnding = "Append present ending"
    case appendImperfectEnding = "Append imperfect ending"
    case appendPreteriteEnding = "Append preterite ending"
    case appendConditionalEnding = "Append conditional ending"
    case appendFutureEnding = "Append future ending"
    case removeFutureEnding = "Remove future ending"
    case removeExistingStem = "Remove existing stem"
    case replaceWithNewStem = "Replace with new stem"
    case replaceWithIrregularWord = "Replace with irregular word"
    case replaceWithIrregularStem = "Replace with irregular stem"
    case startWithS1PresentTense = "Start with yo-form of present tense"
    case startWithP3PreteriteTense = "Start with ellos-form of preterite tense"
    case replaceThis = "Replace "
    case withThis = " with "
    case stemChanging = "Stem changing verb"
    case orthoChanging = "Ortho changing verb"
    case irregular = "Irregular verb"
    case useThirdPersonSingular = "Use 3rd person singular"
    case insertLetter = "Insert letter"
    case insertLetters = "Insert letters"
    case removeI = "Remove I"
    case removeLastLetter = "Remove last letter"
    case removeLetter = "Remove letter"
    case removeLetters = "Remove letters"
    case uyEnding = "Add UY ending"
    case grabReflexivePronoun = "Grab reflexive pronoun"
    case insertPersonalPronoun = "Insert personal pronoun"
    case insertReflexivePronoun = "Insert reflexive pronoun"
    case contractedReflexivePronoun = "Insert contracted reflexive pronoun" //french
    case addResidualPhrase = "Add residual phrase"
    case insertAuxillaryVerb = "Insert auxillary verb"
    case replaceFinalLetter = "Replace final letter"
    case replaceFinalLetterWithPronoun = "Replace final letter with pronoun"
    case replaceWithAccentedLetter = "Replace with accented letter"
    case removeAccentedLetter = "Remove accented letter"
    case replaceWithPreteriteP3 = "Replace with preterite form at P3"
    case replaceWithPreteriteS3 = "Replace with preterite form at S3"
    case replaceWithFutureS3 = "Replace with future form at S3"
    case highlightAndComment = "Highlight and comment"
    case removeReflexivePronoun = "Remove reflexive pronoun"
    case getS1PresentForm = "Get the S1 present form"
    case getS1FutureForm = "Get the S1 future form"
    case getS3FutureForm = "Get the S3 future form"
    case replaceWithPresentParticiple = "Replace with present participle"
    case replaceWithPastParticiple = "Replace with past participle"
    case replaceSubjectWithContractedForm = "Replace subject with contracted form"
    case replaceReflexivePronounWithContractedForm = "Replace reflexive pronoun with contracted form"
    case replaceConjunctionWithContractedForm = "Replace conjunction with contracted form"
    case contractSubjectAuxiliaryVerb  = "Replace subject auxiliary verb"  //she + would  = she'd  (also, she had)
    case contractAuxiliaryVerb  = "Contract auxiliary verb" //would + have = would've
    case contractAuxiliaryNegative  = "Contract auxiliary negative"     //would + not  = wouldn't
    case comment = "Comment"
    case total = "Total"
}

enum MorphFlag {
    case orthoPresent
    case orthoPreterite
    case stem
    case pretStem
    case pretStem2
    case pretStem3
    case irregular
    case futureStem
}

struct MorphStep {
    var index : Int = -1
    var verbForm : String = ""
    var morphType : eMorphType = .comment
    var comment : String = ""
    var part1 : String = ""
    var part2 : String = ""
    var part3: String = ""
    
    var preposition : String = ""
    var isOrthoPresent = false
    var isOrthoPreterite = false
    var isStem = false
    var isPretStem = false
    var isPretStem2 = false
    var isPretStem3 = false
    var isIrregular = false
    var isFutureStem = false

    mutating func setTrue (flag : MorphFlag ){
        switch (flag){
        case .orthoPresent:
            isOrthoPresent = true
        case .orthoPreterite:
            isOrthoPreterite = true
        case .stem:
            isStem = true
        case .pretStem:
            isPretStem = true
        case .pretStem2:
            isPretStem2 = true
        case .pretStem3:
            isPretStem3 = true
        case .irregular:
            isIrregular = true
        case .futureStem:
            isFutureStem = true
        }
    }
    
    
    init(index:Int, verbForm:String, morphType:eMorphType, comment:String, preposition:String, part1:String, part2:String, part3:String){
        self.index = index
        self.verbForm = verbForm
        self.morphType = morphType
        self.comment = comment
        self.preposition = preposition
        self.part1 = part1
        self.part2 = part2
        self.part3 = part3
        self.isOrthoPresent = false
        self.isOrthoPreterite = false
        self.isStem = false
        self.isPretStem = false
        self.isPretStem2 = false
        self.isPretStem3 = false
        self.isIrregular = false
        self.isFutureStem = false
    }
    
    init(){
        self.index  = -1
        self.verbForm = ""
        self.morphType  = .comment
        self.comment  = ""
        self.preposition  = ""
        self.part1 = ""
        self.part2 = ""
        self.part3 = ""
        self.isOrthoPresent = false
        self.isOrthoPreterite = false
        self.isStem = false
        self.isPretStem = false
        self.isPretStem2 = false
        self.isPretStem3 = false
        self.isIrregular = false
        self.isFutureStem = false
    }

}

//all the morphsteps should relate to a single person
class MorphStruct  {
    var currentIndex = 0
    var person : Person = .S1
    var morphArray = [MorphStep]()
    var isOrtho = false
    var isStem = false
    var isIrreg = false
    
    init (person: Person){
        self.person = person
    }
    
    func getPerson()->Person{ return person }
    func clear(){ morphArray.removeAll() }
    func count()->Int { return morphArray.count}
    func append( morphStep : MorphStep ){
        morphArray.append(morphStep)
    }
    
    func isOrthoChanging()->Bool{
        for morph in morphArray {
            if ( morph.isOrthoPresent || morph.isOrthoPreterite ){
                return true
            }
        }
        return false
    }
    
    func isStemChanging()->Bool{
        for morph in morphArray {
            if ( morph.isStem || morph.isPretStem || morph.isPretStem2 || morph.isPretStem3  ){
                return true
            }
        }
        return false
    }
    
    func isIrregular()->Bool{
        for morph in morphArray {
            if ( morph.isIrregular || morph.isFutureStem ){
                return true
            }
        }
        return false
    }

    func createAndAppendMorphStep(locIndex:Int, verbForm:String, morphType:eMorphType, comment:String, preposition:String, part1: String, part2:String, part3:String )->Int{
        let ms = MorphStep(index: locIndex, verbForm:verbForm, morphType:morphType, comment:comment, preposition:preposition, part1: part1, part2: part2, part3: part3)
        morphArray.append(ms)
        return morphArray.count
    }
    //append all of the morphSteps in the incoming struct with the existing morphStep array
    
    func appendMorphStruct(morphStruct: MorphStruct){
        for morph in morphStruct.morphArray {
            morphArray.append(morph)
        }
    }
    
    func copyContents(input: MorphStruct){
        for i in 0..<input.count() {
            let morphStep = input.getMorphStep(index: i)
            let ms = MorphStep(index: morphStep.index, verbForm: morphStep.verbForm, morphType: morphStep.morphType, comment: morphStep.comment, preposition: morphStep.preposition, part1: morphStep.part1, part2: morphStep.part2, part3: morphStep.part3)
            morphArray.append(ms)
        }
    }
    
    func copyContentsSetFlag(input: MorphStruct, morphFlag : MorphFlag){
        for i in 0..<input.count() {
            let morphStep = input.getMorphStep(index: i)
            var ms = MorphStep(index: morphStep.index, verbForm: morphStep.verbForm, morphType: morphStep.morphType, comment: morphStep.comment, preposition: morphStep.preposition, part1: morphStep.part1, part2: morphStep.part2, part3: morphStep.part3)
            ms.setTrue(flag: morphFlag)
            morphArray.append(ms)
        }
    }
    
    func hasEnding()->Bool{
        if ( morphArray.count == 0 ){ return false }
        
        let mt = getMorphStep(index: morphArray.count-1).morphType
        return ( mt == .appendEnding
                    || mt == .appendWord
                    || mt == .replaceWithIrregularWord
                    || mt == .appendPresentEnding
                    || mt == .appendPreteriteEnding
                    || mt == .appendImperfectEnding
                    || mt == .appendFutureEnding
                    || mt == .appendConditionalEnding )
    }
    
    func startVerbForm()->String {
        return getMorphStep(index: 0).verbForm
    }
    
    func currentMorphForm()->String {
        return getMorphStep(index: currentIndex).verbForm
    }
    
    func currentMorphComment()->String {
        return getMorphStep(index: currentIndex).comment
    }
  
    func incrementIndex(){
        if ( currentIndex < morphArray.count-1 ){
            currentIndex += 1
        }
        //reset
        else {
            currentIndex = 0
        }
    }
    
    func getMorphIndex()-> Int {
        return currentIndex
    }
    
    func isFinalMorphStep()->Bool{
        if currentIndex == morphArray.count-1 {return true}
        return false
    }
    
    func resetMorphIndex(){
        currentIndex = 0
    }
    
    func finalVerbForm()->String {
        getMorphStep(index: morphArray.count-1).verbForm.lowercased()
    }
    
    func getCurrentMorphStep()->MorphStep {
        return getMorphStep(index: currentIndex)
    }
    
    func getMorphStep(index : Int)-> MorphStep {
            if index == 0 || index < morphArray.count { return morphArray[index]}
            return MorphStep()
    }
    
    func getPersonIndex()->Int {
        return person.rawValue
    }

}
