//
//  WordComponent.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/7/21.
//

import Foundation

class WordComponent: Identifiable, Hashable {
    init(word: String){
        self.word = word
    }
    
    static func == (lhs: WordComponent, rhs: WordComponent)->Bool{
        return lhs.word == rhs.word
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(word)
    }
    
    let word : String
}

//Articles, Adjectives, etc.

class ModifierComponent: WordComponent{
    var plural : String
    var femWord : String
    var femPlural : String
    
    init(word: String, femWord: String, plural: String, femPlural: String){
        self.femWord = femWord
        self.plural = plural
        self.femPlural = femPlural
        super.init(word: word)
    }
}

class VerbComponent: WordComponent{
    let pastParticiple : String
    let presentParticiple : String
    
    init(word: String, pastParticiple: String, presentParticiple: String){
        self.pastParticiple = pastParticiple
        self.presentParticiple = presentParticiple
        super.init(word: word)
        
    }
}

class NounComponent: WordComponent{
    let plural : String
    init(word: String, plural: String){
        self.plural = plural
        super.init(word: word)

    }
}


