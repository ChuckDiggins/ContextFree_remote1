//
//  ViperDeterminer.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

class Determiner : Word {
    var type: DeterminerType
    
    init(word: String, def: String, type : DeterminerType){
        self.type = type
        super.init(word: word, def: def, wordType: .determiner)
    }
}

class EnglishDeterminer : Determiner {
                        //this
    var plural: String   //these
    
    init(word:String, def: String, type : DeterminerType, plural: String){
        self.plural = plural
        super.init(word: word, def: def, type : type)
    }
    
    func getForm(number: Number)->String{
        switch number {
        case .singular:
            return word
        case .plural:
            return plural
        }
    }
    
    func isDeterminer(word: String)-> (Bool, DeterminerType, Number ){
        if ( word == self.word ){ return (true, type, .singular) }
        if ( word == self.plural ){ return (true, type, .plural) }
        return (false, type, .singular)
    }
}

class RomanceDeterminer : Determiner {
                             //eso
    var femWord: String      //esa
    var mascPlural: String   //esos
    var femPlural: String    //esas
    
    init(word:String, def:String, type : DeterminerType, femWord:String, mascPlural:String, femPlural:String ){
        self.femWord = femWord
        self.mascPlural = mascPlural
        self.femPlural = femPlural
        super.init(word: word, def: def, type : type)
    }
    
    func getForm(gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return femWord
            case .plural:
                return femPlural
            }
        case .masculine:
            switch number {
            case .singular:
                return word
            case .plural:
                return mascPlural
            }
        }  
    }
    
    func isDeterminer(word: String)-> (Bool, DeterminerType, Gender, Number ){
        if ( word == word ){ return (true, type, .masculine, .singular) }
        if ( word == femWord ){ return (true, type, .feminine, .singular) }
        if ( word == mascPlural ){ return (true, type, .masculine, .plural) }
        if ( word == femPlural ){ return (true, type, .feminine, .plural) }
        return (false, type, .masculine, .singular)
    }
    
}
