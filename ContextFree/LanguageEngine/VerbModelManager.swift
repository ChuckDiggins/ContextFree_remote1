//
//  VerbManager.swift
//  VerbManager
//
//  Created by Charles Diggins on 11/2/21.
//

import Foundation

struct VerbModelManager{
    var romanceVerbModel = RomanceVerbModel()
    var englishVerbModel = EnglishVerbModel()
    var modelName = ""
    
    mutating func analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
        var verb = BVerb()
        
        switch language {
        case .Spanish:
            verb = createSpanishBVerb(verbPhrase: verbPhrase)
            return (true, verb)
        case .French:
            verb = createFrenchBVerb(verbPhrase: verbPhrase)
            return (true, verb)
        case .English:
            verb = createEnglishBVerb(verbPhrase: verbPhrase, separable: .separable)
            return (true, verb)
        default:
            return (false, BVerb())
        }
        
    }

    
    mutating func createEnglishBVerb(verbPhrase: String, separable: Separable ) -> BEnglishVerb {
        let brv = BEnglishVerb(verbPhrase : verbPhrase, separable: separable)
        englishVerbModel = m_englishVerbModelConjugation.getVerbModel(verbWord: brv.m_verbWord)
        brv.setModel(verbModel : englishVerbModel)
        modelName = brv.getBescherelleInfo()
        return brv
    }

    mutating func createSpanishBVerb(verbPhrase: String) -> BSpanishVerb {
        let brv = BSpanishVerb(verbPhrase : verbPhrase)
        romanceVerbModel = m_spanishVerbModelConjugation.getVerbModel(language: .Spanish, verbWord: brv.m_verbWord)
        brv.setPatterns(verbModel : romanceVerbModel)
        modelName = brv.getBescherelleInfo()
        return brv
    }
    
    mutating func createFrenchBVerb(verbPhrase: String) -> BFrenchVerb {
        let brv = BFrenchVerb(verbPhrase : verbPhrase)
        let verbModel = m_frenchVerbModelConjugation.getVerbModel(language: .French, verbWord: brv.m_verbWord)
        brv.setPatterns(verbModel : verbModel)
        modelName = brv.getBescherelleInfo()
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
