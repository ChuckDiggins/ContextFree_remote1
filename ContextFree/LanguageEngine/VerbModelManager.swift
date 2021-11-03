//
//  VerbManager.swift
//  VerbManager
//
//  Created by Charles Diggins on 11/2/21.
//

import Foundation

struct VerbModelManager{
    mutating func analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
        var verb = BVerb()
        let util = VerbUtilities()
        
        switch language {
        case .Spanish:
            let verbStuff = util.analyzeWordPhrase(testString: verbPhrase)
            //var reconstructedVerbPhrase = util.reconstructVerbPhrase(verbWord: verbStuff.verbWord, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
            if verbStuff.verbEnding == .none {return (false, BVerb())}
            verb = createSpanishBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                      residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
            return (true, verb)
        case .French:
            let verbStuff = util.analyzeWordPhrase(testString: verbPhrase)
            //var reconstructedVerbPhrase = util.reconstructVerbPhrase(verbWord: verbStuff.verbWord, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
            if verbStuff.verbEnding == .none {return (false, BVerb())}
            verb = createFrenchBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding,
                                     residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
            return (true, verb)
        case .English:
            let verbStuff = util.analyzeEnglishWordPhrase(testString: verbPhrase)
            var verb = BVerb()
            verb = createEnglishBVerb(verbWord:verbStuff.verbWord)
            return (true, verb)
        default:
            return (false, BVerb())
        }
        
    }
    
    mutating func createNewBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BRomanceVerb {
        
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        switch m_currentLanguage {
        case .Spanish:
            let brv = BSpanishVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                   languageType: m_currentLanguage,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            
            let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        case .French:
            let brv = BFrenchVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                   languageType: m_currentLanguage,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        default:
            return BRomanceVerb()
        }
        
    }
    
    mutating func createEnglishBVerb(verbWord: String) -> BEnglishVerb {
        //reconstruct the clean-up verb phrase here
        
        let constructedVerbPhrase = verbWord
        
        let brv = BEnglishVerb(verbPhrase : constructedVerbPhrase, verbWord: verbWord)
        
        let verbModel = m_englishVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setModel(verbModel : verbModel)

        return brv
    }

    mutating func createSpanishBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BSpanishVerb {
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        let brv = BSpanishVerb(verbPhrase : constructedVerbPhrase,
                               verbWord: verbWord,
                               verbEnding: verbEnding,
                               languageType: m_currentLanguage,
                               preposition: residualPhrase, isReflexive: isReflexive)
        
        let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setPatterns(verbModel : verbModel)
        return brv
    }
    
    mutating func createFrenchBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BFrenchVerb {
        //reconstruct the clean-up verb phrase here
        
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        let brv = BFrenchVerb(verbPhrase : constructedVerbPhrase,
                               verbWord: verbWord,
                               verbEnding: verbEnding,
                               languageType: m_currentLanguage,
                               preposition: residualPhrase, isReflexive: isReflexive)
        
        let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setPatterns(verbModel : verbModel)
        return brv
    }
    
    /*
    func unConjugate(verbForm : String)->( BSpanishVerb, Tense, Person)  {
        var conjugateForm = ""
        //var verb = BSpanishVerb()
        
        var count = 0
        for v in m_masterVerbList {
            let verb = v as! BSpanishVerb
            for tense in Tense.indicativeAll {
                for person in Person.all {
                    conjugateForm = verb.getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : false ).finalVerbForm()
                    conjugateForm = Utilities().removeLeadingOrFollowingBlanks(characterArray: conjugateForm)
                    if conjugateForm == verbForm {
                        print("\(count) verb forms were searched")
                        return (verb, tense, person)
                    }
                    count += 1
                }
            }
            
            for tense in Tense.subjunctiveAll {
                for person in Person.all {
                    conjugateForm = verb.getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : false ).finalVerbForm()
                    conjugateForm = Utilities().removeLeadingOrFollowingBlanks(characterArray: conjugateForm)
                    if conjugateForm == verbForm {
                        print("\(count) verb forms were searched")
                        return (verb, tense, person)
                    }
                    count += 1
                }
            }
        }
        print("\(count) verb forms were searched")
        return (BSpanishVerb(), .present, .S1)
    }
 */
    
}
