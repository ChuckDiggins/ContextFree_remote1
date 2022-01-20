//
//  BEnglishVerb.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/17/21.
//

import Foundation

class BEnglishVerb : BVerb {
    
    var verbModel = EnglishVerbModel()
    var m_presentS3Form = ""
    var m_preteriteForm = ""
    var m_suffix1 = ""
    var m_suffix2 = ""
    var m_preteriteStem = ""
    var m_presentS3Stem = ""
    var endsInE = false
    var endsInLL = false
    var endsInConsonant = true
    var endsInDKNRT = false
    var endsInConsonantY = false
    var endsInN = false
    var m_baseString = ""
    var m_separable = Separable.both
    
    init(verbPhrase: String, separable: Separable){
        m_separable = separable
        super.init(verbPhrase: verbPhrase, languageType: .English)
        createRegularDefaultForms()  //these will be overridden later if there is a model for this verb
    }
    
    func getBescherelleInfo()->String {
        if verbModel.id == 0 {return "Regular verb"}
        return "Besch #\(verbModel.id) (\(verbModel.infinitive))"
    }
    
    func prepareStemNew(){
        let util = VerbUtilities()
        m_baseString = m_verbWord
        m_presentS3Stem = m_verbWord
        m_preteriteStem = m_verbWord
        var prev1 = ""
        var prev2 = ""
        m_suffix1 = util.getLastNCharactersInString(inputString: m_verbWord, copyCount: 1)
        m_suffix2 = util.getLastNCharactersInString(inputString: m_verbWord, copyCount: 2)
        var m_suffix3 = ""
        if m_verbWord.count > 3 {m_suffix3 = util.getLastNCharactersInString(inputString: m_verbWord, copyCount: 3)}
        
        if util.isVowel(letter: m_suffix1){
            endsInConsonant = false
            m_presentS3Stem = m_verbWord
            m_preteriteStem = m_verbWord
            // boxes, approaches,
            if m_suffix1 == "e" {
                m_presentS3Stem.removeLast()
                m_preteriteStem.removeLast()
                endsInE = true
            }
        }
        else if m_suffix2 == "ll" {
            endsInLL = true
        }
        else if m_suffix1 == "y" {
            endsInConsonant = false
            endsInConsonantY = true
            //only remove the y if preceded by a consonant - "hurry" -> "hurries", but not "pray" -> "prays"
            var nextToLast = util.getLastNCharactersInString(inputString: m_verbWord, copyCount: 2)
            nextToLast.removeLast()
            //if letter previous to y is a consonant, then remove the "y" so we can add "ies" and "ied"
            if !util.isVowel(letter: nextToLast){
                m_presentS3Stem.removeLast()
                m_preteriteStem.removeLast()
            }
            else {
                endsInConsonantY = false
            }
        }
        //at this point, the last letter must be a consonant
        
        else
        {
            if m_suffix3.count > 2 {
                //strip off the final consonant
                m_suffix3.removeLast()
                //if previous 2 letters are both vowels, then do not double the final consonant ( need-needed, peep-peeped )
                prev1 = util.getLastNCharactersInString(inputString: m_suffix3, copyCount: 1)
                m_suffix3.removeLast()
                prev2 = util.getLastNCharactersInString(inputString: m_suffix3, copyCount: 1)
            }
            //if only one vowel preceding the consonant, then final consonant will double for past and gerund (admit - admitted, flap - flapped)
            
            //if only a single vowel, then double up the final consonant ( permit -> permitt )
            if util.isVowel(letter: prev1){
                m_preteriteStem += m_suffix1
                if ( m_verbWord == "open" ){ m_preteriteStem.removeLast() }  //exception for "open"
            }
            //if both previous letters are vowels, then forget the double consonant
            if util.isVowel(letter: prev1) && util.isVowel(letter: prev2){
                m_preteriteStem.removeLast()
            }
            if m_suffix1 == "d" || m_suffix1 == "k" || m_suffix1 == "n" || m_suffix1 == "r" || m_suffix1 == "t" {
                endsInDKNRT = true   //mar = marred, marring
                if ( m_suffix2 == "er"){
                    m_preteriteStem.removeLast()
                }  //considered. considers.
            }
        }
    }
    
    func createRegularDefaultForms(){
        prepareStemNew()
        
        m_preteriteForm = m_preteriteStem + "d"
        m_presentS3Form = m_presentS3Stem + "s"
        
        m_gerund = m_verbWord + "ing"
        if endsInConsonantY {
            m_presentS3Form = m_presentS3Stem + "ies"
            m_preteriteForm = m_preteriteStem + "ied"
        }
        else if endsInE {
            m_gerund = m_preteriteStem + "ing"
            m_presentS3Form = m_presentS3Stem + "es"
            m_preteriteForm = m_preteriteStem + "ed"
        }
        
        if endsInConsonant {
            m_gerund = m_preteriteStem + "ing"
            m_presentS3Form = m_presentS3Stem + "es"
            m_preteriteForm = m_preteriteStem + "ed"
        }
        if endsInDKNRT || endsInLL {
            m_gerund = m_preteriteStem + "ing"
            m_presentS3Form = m_presentS3Stem + "s"
            m_preteriteForm = m_preteriteStem + "ed"
        }
        
        m_pastParticiple = m_preteriteForm
        //exception
        if m_verbWord == "have" {
            m_presentS3Form = "has"
        }
    }
    
    func createGerund(){
        m_gerund = m_verbWord + "ing"
    }
    
    func setModel(verbModel: EnglishVerbModel){
        self.verbModel = verbModel
       
        
        if verbModel.id == 0 {
             createRegularDefaultForms()
        }
        
        if verbModel.id == 1 {
            m_gerund = "being"
            m_pastParticiple = "been"
        }
        
        if verbModel.id > 1 {
            m_pastParticiple = verbModel.pastPart
            m_preteriteForm = verbModel.preterite
            m_gerund = verbModel.gerund
            m_verbWord = verbModel.infinitive
            prepareStemNew()
            if endsInConsonantY {m_presentS3Form = m_presentS3Stem + "ies"}
            else if endsInE {
                m_presentS3Form = m_presentS3Stem + "es"
                if m_verbWord == "have" {m_presentS3Form="has"}
            }
            else { m_presentS3Form = m_presentS3Stem + "s" }
        }
    }
    
    func getConjugateForm(tense : Tense, person : Person)->String {
        switch verbModel.id{
        case 0:
            return getRegularForm(tense: tense, person: person)
        case 1:
            return getBeForm(tense: tense, person: person)
        default:
            return getRegularForm(tense: tense, person: person)
        }
    }
    
    func getBeForm(tense : Tense, person : Person)->String {

        switch tense {
        case .present:
            switch person{
            case .S1: return "am"
            case .S2: return "are"
            case .S3: return "is"
            case .P1: return "are"
            case .P2: return "are"
            case .P3: return "are"
            }
        case .preterite:
            switch person{
            case .S1: return "was"
            case .S2: return "were"
            case .S3: return "was"
            case .P1: return "were"
            case .P2: return "were"
            case .P3: return "were"
            }
        case .imperfect:
            switch person{
            case .S1: return "was " + m_gerund
            case .S2: return "were " + m_gerund
            case .S3: return "was " + m_gerund
            case .P1: return "were " + m_gerund
            case .P2: return "were " + m_gerund
            case .P3: return "were " + m_gerund
            }
        case .future:
            return "will " + m_verbWord
        case .conditional:
            return "would " + m_verbWord
        case .presentPerfect:
            if person == .S3 { return "has " + m_pastParticiple }
            else { return "have " + m_pastParticiple}
        case .pastPerfect:
            switch person{
            case .S1: return "was having " + m_gerund
            case .S2: return "were having " + m_gerund
            case .S3: return "was having " + m_gerund
            case .P1: return "were having " + m_gerund
            case .P2: return "were having " + m_gerund
            case .P3: return "were having " + m_gerund
            }
        case .preteritePerfect:
            return "had " + m_pastParticiple
        case .futurePerfect:
            return "will have " + m_pastParticiple
        case .conditionalPerfect:
            return "would have " + m_pastParticiple
        default: break
        }
        return "this tense not implemented yet"
    }
    
    func getRegularForm(tense : Tense, person : Person)->String {
        switch tense {
        case .present:
            if person == .S3 {
                return m_presentS3Form
            }
            else {return m_verbWord}
        case .preterite:
            return m_preteriteForm
        case .imperfect:
            if person == .S1 || person == .S3 { return "was " + m_gerund }
            else { return "were " + m_gerund}
        case .future:
            return "will " + m_verbWord
        case .conditional:
            return "would " + m_verbWord
        case .presentPerfect:
            if person == .S3  { return "has " + m_pastParticiple }
            else { return "have " + m_pastParticiple}
        case .pastPerfect:
            if person == .S1 || person == .S3 { return "was having " + m_pastParticiple }
            else { return "were having " + m_pastParticiple}
        case .preteritePerfect:
            return "had " + m_pastParticiple
        case .futurePerfect:
            return "will have " + m_pastParticiple
        case .conditionalPerfect:
            return "would have " + m_pastParticiple
        default: break
        }
        return "this tense not implemented yet"
    }
    
    override func getConjugatedMorphStruct( tense : Tense, person : Person , conjugateEntirePhrase : Bool, isPassive: Bool = false)->MorphStruct {
        var ms = self.morphStructManager.get(person: person)
        let verbForm = getConjugateForm(tense: tense, person: person)
        var morphStep = MorphStep()
        morphStep.isFinalStep = true
        morphStep.verbForm = verbForm
        morphStep.comment = "Conjugated form  -> \(verbForm)"
        morphStep.part1 = verbForm
        morphStep.part2 = " "
        morphStep.part3 = " "
        ms.append(morphStep : morphStep)
        
        //add residual phrase here
        if conjugateEntirePhrase && m_residualPhrase.count > 0 {
            let finalForm = ms.finalVerbForm()
            var morphStep = MorphStep()
            morphStep.isFinalStep = true
            morphStep.comment = "Add residual phrase -> \(m_residualPhrase)"
            morphStep.part1 = finalForm
            morphStep.part2 += " " + m_residualPhrase
            morphStep.verbForm = finalForm + " " + m_residualPhrase
            ms.append(morphStep : morphStep)
        }
        
        setMorphStruct(person: person, morphStruct: ms)
        return ms
    }
    
    
}
