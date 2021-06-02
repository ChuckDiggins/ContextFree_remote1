//
//  Conjunction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/18/21.
//

import Foundation

class Conjunction : Word {

    var type: ConjunctionType
    
    init(word: String, def: String, type : ConjunctionType){
        self.type = type
        super.init(word: word, def: def, wordType: .conjunction)
    }
    
    func isConjunction(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}

class FrenchConjunction : Conjunction {
    override init(word: String, def: String, type : ConjunctionType){
        super.init(word: word, def: def, type: type)
    }
    
    
}

class SpanishConjunction : Conjunction {
    override init(word: String, def: String, type : ConjunctionType){
        super.init(word: word, def: def, type: type)
    }
    
}


class EnglishConjunction : Conjunction {
    override init(word: String, def: String, type : ConjunctionType){
        super.init(word: word, def: def, type: type)
    }
    
}
