//
//  AgnosticPhraseMapping.swift
//  AgnosticPhraseMapping
//
//  Created by Charles Diggins on 1/1/22.
//

import Foundation

struct PhraseIndexMapping {
    var cfs : ContextFreeSymbol
    var agnosticIndex : Int
    var spanishIndex : Int
    var frenchIndex : Int
    var englishIndex : Int
    
    mutating func setMapIndex(language: LanguageType, index: Int){
        switch language {
        case .Spanish: spanishIndex = index
        case .French: frenchIndex = index
        case .English: englishIndex = index
        case .Agnostic: agnosticIndex = index
        default: agnosticIndex = index
        }
    }
    
    func getMapIndex(language: LanguageType)->Int{
        switch language {
        case .Spanish: return spanishIndex
        case .French: return frenchIndex
        case .English: return englishIndex
        case .Agnostic: return agnosticIndex
        default: return agnosticIndex
        }
    }
    
    func getAgnosticIndex()->Int{
        return agnosticIndex
    }
    
    mutating func setAgnosticIndex(index: Int){
        agnosticIndex = index
    }
}
