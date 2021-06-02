//
//  ViperNoun.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

class Noun : Word {

    var plural = ""
    var type: NounType
    
    init(word: String, def: String, type : NounType){
        self.type = type
        super.init(word: word, def: def, wordType: .noun)
    }

    func constructPlural(){
        plural = word + "s"
    }
}

class RomanceNoun : Noun {
    var gender : Gender
    var number : Number = .singular
    
    init(word: String, def: String, type: NounType, gender: Gender){
        self.gender = gender
        super.init(word: word, def: def, type : type)
        constructPlural()
    }
    
    func setNumber(number: Number){ self.number = number  }
    func getNumber()->Number{return number}
    func setGender(gender: Gender){ self.gender = gender  }
    func getGender ()->Gender {return gender }
    
    func getNounString(number : Number)->String {
        if number == .singular { return word }
        return plural
    }
    
    func isNoun(word: String)->(Bool, NounType, Number, Gender){
        if word == self.word { return (true, type, .singular, gender)}
        if word == self.plural { return (true, type, .plural, gender)}
        return (false, type, .plural, gender)
    }
    
    override func constructPlural(){
        let util = VerbUtilities()
        var root = word
        root.removeLast()
        
        let suffix = util.getLastNCharactersInString(inputString: word, copyCount: 1)

        if ( suffix == "z" ){ plural = root + "ces" }
        else if !util.isVowel(letter: suffix) || suffix == "Ì" || suffix == "˙" || suffix == "·" {
            plural = word + "es"
        }
        else{ plural = word + "s" }
    }
  
}

class FrenchNoun : RomanceNoun {
    
    override func constructPlural(){
        let util = VerbUtilities()
        var root = word
        root.removeLast()
        
        let suffix = util.getLastNCharactersInString(inputString: word, copyCount: 1)

        if ( suffix == "z" ){ plural = root + "ces" }
        else if !util.isVowel(letter: suffix) || suffix == "Ì" || suffix == "˙" || suffix == "·" {
            plural = word + "es"
        }
        else{ plural = word + "s" }
    }
  
}

class EnglishNoun : Noun {
    override init(word: String, def: String, type: NounType ){
        super.init(word:word, def: def, type:type)
        super.constructPlural()
    }
    
    func isNoun(word: String)->(Bool, NounType, Number){
        if word == word { return (true, type, .singular)}
        if word == plural { return (true, type, .plural)}
        return (false, type, .plural)
    }
}

