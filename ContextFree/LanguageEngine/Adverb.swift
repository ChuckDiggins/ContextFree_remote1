//
//  Adverb.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

class Adverb : Word {

    var type: AdverbType
    
    init(word: String, def: String, type : AdverbType){
        self.type = type
        super.init(word: word, def: def, wordType: .adverb)
    }
}

class FrenchAdverb : Adverb {
    override init(word: String, def: String, type : AdverbType){
        super.init(word: word, def: def, type: type)
    }
    
    func isAdverb(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}


class SpanishAdverb : Adverb {
    override init(word: String, def: String, type : AdverbType){
        super.init(word: word, def: def, type: type)
    }
    
    func isAdverb(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}

class EnglishAdverb : Adverb {
    override init(word: String, def: String, type : AdverbType){
        super.init(word: word, def: def, type: type)
    }
    
    func isAdverb(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
}
