//
//  Preposition.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

class Preposition : Word {
    var type: PrepositionType
    
    override init(){
        self.type = .general
        super.init(word: "", wordType: .preposition)
    }
    
    init(word: String, type : PrepositionType){
        self.type = type
        super.init(word: word, wordType: .preposition)
    }
    
    init(json: JsonPreposition, language: LanguageType){
        self.type = PrepositionType.general
        
        switch(language){
        case .Spanish:  super.init(word: json.spanish, wordType: .preposition)
        case .French:  super.init(word: json.french, wordType: .preposition)
        case .English:  super.init(word: json.english, wordType: .preposition)
        default:
            super.init(word: json.spanish, wordType: .preposition)
        }
        convertPrepositionTypeStringToPrepositionType(inputString: json.prepositionType)
        self.spanish = json.spanish
        self.french = json.french
        self.english = json.english
    }
    
    func convertPrepositionTypeStringToPrepositionType(inputString: String){
        type = .general
        if ( inputString == "G" ){type = .general}
        if ( inputString == "A" ){type = .assignment}
        if ( inputString == "P" ){type = .possessive}
        if ( inputString == "S" ){type = .spatial}
        if ( inputString == "T" ){type = .temporal}
    }
}

class RomancePreposition : Preposition {
    override init(word: String, type : PrepositionType){
        super.init(word: word, type: type)
    }
    
    override init(json: JsonPreposition, language: LanguageType){
        super.init(json: json, language: language)
    }
    
    
    func isPreposition(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
    
    func getPrepositionString()->String {
        return word
    }
}

class SpanishPreposition : RomancePreposition {
    override init(word: String, type : PrepositionType){
        super.init(word: word, type: type)
    }
    
    init(json: JsonPreposition){
        super.init(json: json, language: .Spanish)
    }
    
}

class FrenchPreposition : RomancePreposition {
    override init(word: String, type : PrepositionType){
        super.init(word: word, type: type)
    }
    
    init(json: JsonPreposition){
        super.init(json: json, language: .French)
    }
    
}

class EnglishPreposition : Preposition {
    override init(word: String, type : PrepositionType){
        super.init(word: word, type: type)
    }
    
    override init(json: JsonPreposition, language: LanguageType){
        super.init(json: json, language: language)
    }
    
    func isPreposition(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
    
    func getPrepositionString()->String {
        return word
    }
}


