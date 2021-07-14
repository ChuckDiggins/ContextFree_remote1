//
//  Adverb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

class Adverb : Word {

    var type: AdverbType
    
    init(word: String, type : AdverbType){
        self.type = type
        super.init(word: word, wordType: .adverb)
    }
    
    init(json: JsonAdverb, language: LanguageType){
        self.type = AdverbType.manner
        
        switch(language){
        case .Spanish:  super.init(word: json.spanish, wordType: .noun)
        case .French:  super.init(word: json.french,  wordType: .noun)
        case .English:  super.init(word: json.english, wordType: .noun)
        default:
            super.init(word: json.spanish, wordType: .adjective)
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
    func convertAdverbTypeStringToAdverbType(inputString: String){
        type = .manner
        if ( inputString == "M" ){type = .manner}
        else if ( inputString == "P" ){type = .place}
        else if ( inputString == "T" ){type = .time}
        else if ( inputString == "I" ){type = .intensity}
        else if ( inputString == "D" ){type = .doubt}
        else if ( inputString == "A" ){type = .affirmation}
        else if ( inputString == "E" ){type = .exclusion}
    }
    
    func isAdverb(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}

class RomanceAdverb : Adverb {
    override init(word: String, type : AdverbType){
        super.init(word: word, type: type)
    }
    
    override init(json: JsonAdverb, language: LanguageType){
        super.init(json: json, language: language)
    }
    
}



class FrenchAdverb : RomanceAdverb {
    override init(word: String, type : AdverbType){
        super.init(word: word, type: type)
    }
    
    init(json: JsonAdverb){
        super.init(json: json, language: .French)
    }
    
    override func isAdverb(word:String)->Bool{
        if word == self.french {return true}
        return false
    }
    
    func getForm()->String{
        return french
    }
}


class SpanishAdverb : Adverb {
    override init(word: String, type : AdverbType){
        super.init(word: word,type: type)
    }
    
    init(json: JsonAdverb){
        super.init(json: json, language: .Spanish)
    }
    
    override func isAdverb(word:String)->Bool{
        if word == self.spanish {return true}
        return false
    }
    
    func getForm()->String{
        return spanish
    }
}

class EnglishAdverb : Adverb {
    override init(word: String, type : AdverbType){
        super.init(word: word, type: type)
    }
    
    init(json: JsonAdverb){
        super.init(json: json, language: .English)
    }
    
    override func isAdverb(word:String)->Bool{
        if word == self.english {return true}
        return false
    }
    
    func getForm()->String{
        return english
    }
}
