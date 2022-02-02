//
//  ClausePronounManager.swift
//  ClausePronounManager
//
//  Created by Charles Diggins on 1/22/22.
//

import Foundation
import JumpLinguaHelpers

//pulls subject and object pronoun phrases from a given clause

public struct ClausePronounPhraseManager{
    var clause : dIndependentAgnosticClause
    
    
    
    public func getPronoun(language: LanguageType, type : PronounType)->Pronoun{
        switch type{
        case .SUBJECT: return getSubjectPronoun(language: language)
        case .DIRECT_OBJECT: return getDirectObjectPronoun(language: language)
        case .INDIRECT_OBJECT: return getIndirectObjectPronoun(language: language)
        default: return Pronoun()
        }
    }
    
    public  func getPronounString(language: LanguageType, type : PronounType)->String{
        let pronoun = getPronoun(language: language, type: type)
        let person = clause.getPerson()
        let gender = clause.getGender()
        switch language {
        case .Spanish:
            let sp = pronoun as! SpanishPronoun
            return sp.getForm(gender: gender, person: person)
        case .French:
            let fr = pronoun as! FrenchPronoun
            return fr.getForm(gender: gender, person: person)
        case .English:
            let en = pronoun as! EnglishPronoun
            return en.getForm(gender: gender, person: person)
        default:
            return ""
        }
    }
    
//    func getSubjectPronounStringA(language: LanguageType)->String{
//        let pronoun = getSubjectPronoun(language: language)
//        switch language {
//        case .Spanish:
//            let sp = pronoun as! SpanishPronoun
//            return sp.getForm(gender: clause.getGender(), person: clause.getPerson())
//        case .French:
//            let fr = pronoun as! FrenchPronoun
//            return fr.getForm(gender: clause.getGender(), person: clause.getPerson())
//        case .English:
//            let en = pronoun as! EnglishPronoun
//            return en.getForm(gender: clause.getGender(), person: clause.getPerson())
//        default:
//            break
//        }
//        return ""
//    }
//    
    public func getSubjectPronoun(language: LanguageType)->Pronoun
    {
    if ( clause.headNoun.getClusterType() == .UNK){
        clause.setHeadNounAndHeadVerb()
    }
    if clause.headNoun.getClusterType() != .UNK{
        let hnp = clause.headNoun as! dNounPhrase
        return hnp.getEquivalentPronoun(language: language, type : .SUBJECT)
    }
    return Pronoun()
    }
    
    public func getDirectObjectPronoun(language: LanguageType)->Pronoun{
        let hvp = clause.headVerb as! dVerbPhrase
        if hvp.hasClusterFunction(fn: .DirectObject){
            let c = hvp.getClusterAtFunction(fn: .DirectObject)
            let dp = c as! dPhrase
            return dp.getEquivalentPronoun(language: language, type : .DIRECT_OBJECT)
        }
        return Pronoun()
    }
    
    public func getIndirectObjectPronoun(language: LanguageType)->Pronoun{
        let hvp = clause.headVerb as! dVerbPhrase
        if hvp.hasClusterFunction(fn: .DirectObject){
            let c = hvp.getClusterAtFunction(fn: .IndirectObject)
            let dp = c as! dPhrase
            return dp.getEquivalentPronoun(language: language, type : .INDIRECT_OBJECT)
        }
        return Pronoun()
    }
    
    
    
    
    public func getDirectObjectPronounString(language: LanguageType)->String{
        let hvp = clause.headVerb as! dVerbPhrase
        if hvp.hasClusterFunction(fn: .DirectObject){
            let c = hvp.getClusterAtFunction(fn: .DirectObject)
            let dp = c as! dPhrase
            return dp.getEquivalentPronounString(language: language, type : .DIRECT_OBJECT)
        }
        return ""
    }
    
    public func getIndirectObjectPronounString(language: LanguageType)->String{
        let hvp = clause.headVerb as! dVerbPhrase
        if hvp.hasClusterFunction(fn: .IndirectObject){
            let c = hvp.getClusterAtFunction(fn: .IndirectObject)
            let dp = c as! dPhrase
            return dp.getEquivalentPronounString(language: language, type : .INDIRECT_OBJECT)
        }
        return ""
    }
    
}
