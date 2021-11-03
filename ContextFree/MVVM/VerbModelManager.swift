//
//  VerbModelManager.swift
//  VerbModelManager
//
//  Created by Charles Diggins on 9/15/21.
//

import Foundation

struct VerbModelManager {
    /*
    mutating func  analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
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
    //-------------------------------------------------------------------------------------------
    //
    //logic for handling the more advanced BVerb
    //
    //-------------------------------------------------------------------------------------------

    
    func isValidVerbEnding(verbEnding: VerbEnding )->Bool {
        return true
    }
    
    mutating func analyzeAndCreateNewVerb(verbPhrase: String)->(isValid: Bool, verb: BRomanceVerb){
        let verbStuff = VerbUtilities().analyzeWordPhrase(testString: verbPhrase)
        
        if ( isValidVerbEnding(verbEnding: verbStuff.verbEnding)){
            if verbStuff.verbWord.count>1 {
                let verb = createNewBVerb(verbWord:verbStuff.verbWord, verbEnding: verbStuff.verbEnding, residualPhrase: verbStuff.residualPhrase, isReflexive: verbStuff.isReflexive)
                return (true, verb)
            }
            else {
                return (false, BRomanceVerb())
            }
        }
        return (false, BRomanceVerb())
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
                               languageType: .Spanish,
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
                                languageType: .French,
                               preposition: residualPhrase, isReflexive: isReflexive)
        
        let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: verbWord)
        brv.setPatterns(verbModel : verbModel)
        return brv
    }
    
    mutating func createNewBVerb(verbWord: String, verbEnding: VerbEnding, residualPhrase: String, isReflexive: Bool) -> BRomanceVerb {
        
        //reconstruct the clean-up verb phrase here
        let currentLanguage = LanguageType.Spanish
        var constructedVerbPhrase = verbWord
        if ( isReflexive){constructedVerbPhrase += "se"}
        if residualPhrase.count>0 {
            constructedVerbPhrase += " " + residualPhrase
        }
        
        switch currentLanguage {
        case .Spanish:
            let brv = BSpanishVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                   languageType: .Spanish,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            
            let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        case .French:
            let brv = BFrenchVerb(verbPhrase : constructedVerbPhrase,
                                   verbWord: verbWord,
                                   verbEnding: verbEnding,
                                  languageType: .French,
                                   preposition: residualPhrase, isReflexive: isReflexive)
            let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: verbWord)
            brv.setPatterns(verbModel : verbModel)
            return brv
        default:
            return BRomanceVerb()
        }
        
    }



}
