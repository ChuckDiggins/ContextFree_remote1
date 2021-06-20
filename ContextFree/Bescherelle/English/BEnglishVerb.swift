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
    var m_suffix = ""
    var endsInE = false
    var endsInY = false
    var m_baseString = ""
    
    init(verbPhrase: String, verbWord: String){
        super.init(verbPhrase: verbPhrase, verbWord: verbWord, languageType: .English)
        createRegularDefaultForms()
    }
    
    func getBescherelleInfo()->String {
        if verbModel.id == 0 {return "Regular verb"}
        return "Besch #\(verbModel.id) (\(verbModel.infinitive))"
    }
    
    func prepareStem()->String{
        let util = VerbUtilities()
        m_baseString = m_verbWord
        var stem = m_verbWord
        let last = util.getLastNCharactersInString(inputString: stem, copyCount: 1)
        
        if util.isVowel(letter: last){
            stem = m_verbWord
        }
        else if last == "y" {
            endsInY = true
            //only remove the y if preceded by a consonant - eg, "hurry" -> "hurries", but not "pray" -> "prays"
            var nextToLast = util.getLastNCharactersInString(inputString: m_verbWord, copyCount: 2)
            nextToLast.removeLast()
            if !util.isVowel(letter: nextToLast){
                stem.removeLast()
            }
        }
        else {
            // boxes, approaches,
            let last2 = util.getLastNCharactersInString(inputString: stem, copyCount: 2)
            if last == "e" || last == "x" || last2 == "ch" || last2 == "sh" {
                endsInE = true
            }
        }
        return stem
    }
    
    func createRegularDefaultForms(){
        let stem = prepareStem()
        m_pastParticiple = stem + "d"
        m_preteriteForm = stem + "d"
        m_gerund = m_verbWord + "ing"
        if endsInY {m_presentS3Form = stem + "ies"}
        else if endsInE {
            m_presentS3Form = stem + "es"
            m_preteriteForm = stem + "ed"
        }
        else { m_presentS3Form = stem + "s" }
    }
    
    func createGerund(){
        m_gerund = m_verbWord + "ing"
    }
    
    func setModel(verbModel: EnglishVerbModel){
        self.verbModel = verbModel
        
        //if verbModel.id == 0 {
        //     createRegularDefaultForms()
        //}
        
        if verbModel.id == 1 {
            m_gerund = "being"
            m_pastParticiple = "been"
        }
        
        if verbModel.id > 1 {
            m_pastParticiple = verbModel.pastPart
            m_preteriteForm = verbModel.preterite
            m_verbWord = verbModel.infinitive
            let stem = prepareStem()
            if endsInY {m_presentS3Form = stem + "ies"}
            else if endsInE {
                m_presentS3Form = stem + "es"
                m_preteriteForm = stem + "ed"
            }
            else { m_presentS3Form = stem + "s" }
            
            //irregular forms
            if m_verbWord == "go" {m_presentS3Form = "goes"; m_preteriteForm = "went"}
            if m_verbWord == "do" {m_presentS3Form = "does"; m_preteriteForm = "did"}
            if m_verbWord == "have" {m_presentS3Form = "has"; m_preteriteForm = "had"}
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
        var stem = m_verbWord
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
            if person == .S1 { return "was " + m_gerund }
            else { return "were " + m_gerund}
        case .future:
            return "will " + m_verbWord
        case .conditional:
            return "would " + m_verbWord
        case .presentPerfect:
            if person == .S1 || person == .P1  { return "have " + m_pastParticiple }
            else { return "has " + stem}
        case .pastPerfect:
            return "was having " + m_pastParticiple
        case .preteritePerfect:
            return "had " + m_pastParticiple
        case .futurePerfect:
            return "will have " + m_pastParticiple
        case .conditionalPerfect:
            return "would have " + m_pastParticiple
        default: break
        }
        return "this tense not implememted yet"
    }
    
    func getRegularForm(tense : Tense, person : Person)->String {
        var stem = m_verbWord
        switch tense {
        case .present:
            if person == .S3 { return m_presentS3Form }
            else {return m_verbWord}
        case .preterite:
            return m_preteriteForm
        case .imperfect:
            if person == .S1 { return "was " + m_gerund }
            else { return "were " + m_gerund}
        case .future:
            return "will " + m_verbWord
        case .conditional:
            return "would " + m_verbWord
        case .presentPerfect:
            if person == .S1 || person == .P1  { return "have " + m_pastParticiple }
            else { return "has " + stem}
        case .pastPerfect:
            return "was having " + m_pastParticiple
        case .preteritePerfect:
            return "had " + m_pastParticiple
        case .futurePerfect:
            return "will have " + m_pastParticiple
        case .conditionalPerfect:
            return "would have " + m_pastParticiple
        default: break
        }
        return "this tense not implememted yet"
    }
    
    
}
