//
//  Conjunction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/18/21.
//

import Foundation

class Conjunction : Word {

    var type: ConjunctionType
    
    init(word: String, type : ConjunctionType){
        self.type = type
        super.init(word: word, wordType: .conjunction)
    }
    
    init(json: JsonConjunction, language: LanguageType){
        self.type = ConjunctionType.and
        
        switch(language){
        case .Spanish:  super.init(word: json.spanish, wordType: .conjunction)
        case .French:  super.init(word: json.french, wordType: .conjunction)
        case .English:  super.init(word: json.english, wordType: .conjunction)
        default:
            super.init(word: json.spanish, wordType: .conjunction)
        }
        convertConjunctionTypeStringToConjunctionType(inputString: json.conjunctionType)
        self.spanish = json.spanish
        self.french = json.french
        self.english = json.english
    }
    
    func convertConjunctionTypeStringToConjunctionType(inputString: String){
        type = .and
        if ( inputString == "C" ){type = .and}
        else if ( inputString == "S" ){type = .subordinating}
    }
    
    
    func isConjunction(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}

class RomanceConjunction : Conjunction {
    override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }
    
    override init(json: JsonConjunction, language: LanguageType){
        super.init(json: json, language: language)
    }
}

class FrenchConjunction : RomanceConjunction {

    override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }

    init(json: JsonConjunction){
        super.init(json: json, language: .French)
    }
    
    override func isConjunction(word:String)->Bool{
        if word == self.french {return true}
        return false
    }
    
    func getForm()->String{
        return french
    }
    
}

class SpanishConjunction : RomanceConjunction {

    override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }

    init(json: JsonConjunction){
        super.init(json: json, language: .Spanish)
    }
    
    override func isConjunction(word:String)->Bool{
        if word == self.spanish {return true}
        return false
    }
    func getForm()->String{
        return spanish
    }
}


class EnglishConjunction : Conjunction {
    override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }
    
    init(json: JsonConjunction){
        super.init(json: json, language: .English)
    }
    
    override func isConjunction(word:String)->Bool{
        if word == self.english {return true}
        return false
    }
    
    func getForm()->String{
        return english
    }
}
