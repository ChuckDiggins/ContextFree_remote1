//
//  Preposition.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

class Preposition : Word {

    var type: PrepositionType
    
    init(word: String, def: String, type : PrepositionType){
        self.type = type
        super.init(word: word, def: def, wordType: .preposition)
    }
}

class RomancePreposition : Preposition {
    override init(word: String, def: String, type : PrepositionType){
        super.init(word: word, def: def, type: type)
    }
    
    func isPreposition(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
    
    func getPrepositionString()->String {
        return word
    }
}

class EnglishPreposition : Preposition {
    override init(word: String, def: String, type : PrepositionType){
        super.init(word: word, def: def, type: type)
    }
    
    func isPreposition(word:String)->Bool{
        if word == self.word {return true}
        return false
    }
    
    func getPrepositionString()->String {
        return word
    }
}


