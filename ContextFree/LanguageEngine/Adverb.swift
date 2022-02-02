//
//  Adverb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation
import JumpLinguaHelpers

public class Adverb : Word {

    var type: AdverbType
    
    public init(word: String, type : AdverbType){
        self.type = type
        super.init(word: word, wordType: .adverb)
    }
    
    public  init(json: JsonAdverb, language: LanguageType){
        self.type = AdverbType.manner
        
        switch(language){
        case .Spanish:  super.init(word: json.spanish, wordType: .adverb)
        case .French:  super.init(word: json.french,  wordType: .adverb)
        case .English:  super.init(word: json.english, wordType: .adverb)
        default:
            super.init(word: json.spanish, wordType: .adverb)
        }
        convertAdverbTypeStringToAdverbType(inputString: json.adverbType)
        self.spanish = json.spanish
        self.french = json.french
        self.english = json.english
    }
    
    // M = manner - bien, así, mejor
    // P = place - aquí, arriba, dónde
    // T = time - hoy, ahora,
    // I = intensity - poco, más, cuanto
    // D = doubt - posiblemente, tal vez
    // A = affirmation - ciertamente
    // E = exclusion - apenas
    public func convertAdverbTypeStringToAdverbType(inputString: String){
        type = .manner
        if ( inputString == "M" ){type = .manner}
        else if ( inputString == "P" ){type = .place}
        else if ( inputString == "T" ){type = .time}
        else if ( inputString == "I" ){type = .intensity}
        else if ( inputString == "D" ){type = .doubt}
        else if ( inputString == "A" ){type = .affirmation}
        else if ( inputString == "E" ){type = .exclusion}
    }
    
    public func isAdverb(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}

public class RomanceAdverb : Adverb {
    public override init(word: String, type : AdverbType){
        super.init(word: word, type: type)
    }
    
    public override init(json: JsonAdverb, language: LanguageType){
        super.init(json: json, language: language)
    }
    
}



public class FrenchAdverb : RomanceAdverb {
    public override init(word: String, type : AdverbType){
        super.init(word: word, type: type)
    }
    
    public init(json: JsonAdverb){
        super.init(json: json, language: .French)
    }
    
    public override func isAdverb(word:String)->Bool{
        if word == self.french {return true}
        return false
    }
    
    public func getForm()->String{
        return french
    }
}


public  class SpanishAdverb : Adverb {
    public override init(word: String, type : AdverbType){
        super.init(word: word,type: type)
    }
    
    public init(json: JsonAdverb){
        super.init(json: json, language: .Spanish)
    }
    
    public override func isAdverb(word:String)->Bool{
        if word == self.spanish {return true}
        return false
    }
    
    public func getForm()->String{
        return spanish
    }
}

public class EnglishAdverb : Adverb {
    public override init(word: String, type : AdverbType){
        super.init(word: word, type: type)
    }
    
    public init(json: JsonAdverb){
        super.init(json: json, language: .English)
    }
    
    public override func isAdverb(word:String)->Bool{
        if word == self.english {return true}
        return false
    }
    
    public func getForm()->String{
        return english
    }
}
