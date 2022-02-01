//
//  enumUtilities.swift
//  enumUtilities
//
//  Created by Charles Diggins on 1/29/22.
//

import Foundation

public func getClusterTypeFromString(str: String)->ContextFreeSymbol{
    switch str{
    case "N": return .N
    case "V": return .V
    case "Adj": return .Adj
    case "Adv": return .Adv
    case "P": return .P
    case "C": return .C
    case "NP": return .NP
    case "VP": return .VP
    case "PP": return .PP
    case "AP": return .AP
    case "AdvP": return .AdvP
    default: return .AMB
    }
}
                
public func getWordTypeFromString(str: String)->WordType{
    switch str{
    case "determiner": return .determiner
    case "noun": return .noun
    case "verb": return .verb
    case "adjective": return .adjective
    case "adverb": return .adverb
    case "preposition": return .preposition
    case "conjunction": return .conjunction
    default: return .ambiguous
    }
}

public func getStringFromWordType(wordType: WordType)->String{
    switch wordType{
    case .noun: return "noun"
    case .verb: return "verb"
    case .adjective: return "adjective"
    case .adverb: return  "adverb"
    case .preposition: return "preposition"
    case .conjunction: return "conjunction"
    case .determiner: return "determiner"
    default: return "ambiguous"
    }
}


public func getTenseFromString(str: String)->Tense{
    switch str.lowercased(){
    case "present": return .present
    case "imperfect": return .imperfect
    case "preterite": return .preterite
    case "conditional": return .conditional
    case "future": return .future
    case "presentPerfect": return .presentPerfect
    case "pastPerfect": return .pastPerfect
    case "preteritePerfect": return .preteritePerfect
    case "futurePerfect": return .futurePerfect
    case "conditionalPerfect": return .conditionalPerfect
    case "presentSubjunctive": return .presentSubjunctive
    case "imperfectSubjunctiveRA": return .imperfectSubjunctiveRA
    case "imperfectSubjunctiveSE": return .imperfectSubjunctiveSE
    case "imperative": return .imperative
    case "gerund": return .gerund
    case "pastParticiple": return .pastParticiple
    default: return .gerund
    }
}
