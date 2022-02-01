//
//  Conjunction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/18/21.
//

import Foundation

public class Conjunction : Word {

    var type: ConjunctionType
    
    public  init(word: String, type : ConjunctionType){
        self.type = type
        super.init(word: word, wordType: .conjunction)
    }
    
    public init(json: JsonConjunction, language: LanguageType){
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
    
    public func convertConjunctionTypeStringToConjunctionType(inputString: String){
        type = .and
        if ( inputString == "C" ){type = .and}
        else if ( inputString == "S" ){type = .subordinating}
    }
    
    
    public func isConjunction(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}

public class RomanceConjunction : Conjunction {
    public override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }
    
    public override init(json: JsonConjunction, language: LanguageType){
        super.init(json: json, language: language)
    }
}

public class FrenchConjunction : RomanceConjunction {

    public override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }

    public init(json: JsonConjunction){
        super.init(json: json, language: .French)
    }
    
    public override func isConjunction(word:String)->Bool{
        if word == self.french {return true}
        return false
    }
    
    public func getForm()->String{
        return french
    }
    
}

public class SpanishConjunction : RomanceConjunction {

    public override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }

    public init(json: JsonConjunction){
        super.init(json: json, language: .Spanish)
    }
    
    public  override func isConjunction(word:String)->Bool{
        if word == self.spanish {return true}
        return false
    }
    public func getForm()->String{
        return spanish
    }
}


public class EnglishConjunction : Conjunction {
    public  override init(word: String, type : ConjunctionType){
        super.init(word: word, type: type)
    }
    
    public init(json: JsonConjunction){
        super.init(json: json, language: .English)
    }
    
    public override func isConjunction(word:String)->Bool{
        if word == self.english {return true}
        return false
    }
    
    public func getForm()->String{
        return english
    }
}
