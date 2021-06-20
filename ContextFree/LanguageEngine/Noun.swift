//
//  ViperNoun.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

class Noun : Word {
    var english = ""
    var spanish = ""
    var french = ""
    var plural = ""
    var spanishGender = Gender.masculine
    var frenchGender = Gender.masculine
    var nounType: NounType
    
    override init(){
        self.nounType = NounType.any
        super.init(word: "", def: "", wordType: .noun)
    }
    
    init(word: String, def: String, type : NounType){
        self.nounType = type
        super.init(word: word, def: def, wordType: .noun)
    }
    
    init(jsonNoun: JsonNoun, language: LanguageType){
        self.nounType = NounType.any
        self.english = jsonNoun.english
        self.french = jsonNoun.french
        self.spanish = jsonNoun.spanish
        switch(language){
        case .Spanish:  super.init(word: spanish, def: english, wordType: .noun)
        case .French:  super.init(word: french, def: english, wordType: .noun)
        case .English:  super.init(word: english, def: english, wordType: .noun)
        default:
            super.init(word: spanish, def: english, wordType: .noun)
        }
        spanishGender = .masculine
        if ( jsonNoun.spanishGender == "F" ){
            spanishGender = .feminine
        }
        frenchGender = .masculine
        if ( jsonNoun.frenchGender == "F" ){
            frenchGender = .feminine
        }
        
        convertNounTypeStringToNounTypes(inputString: jsonNoun.nounType)
        convertFavoriteVerbStringToFavoriteVerbs(inputString: jsonNoun.verbLikes)
        //convertFavoriteAdjectiveStringToFavoriteAdjectives(inputString: jsonNoun.adjectiveLikes)
    }
    
    func createJsonNoun()->JsonNoun{
        return JsonNoun(spanish: word, english: english, french: french,  spanishGender: spanishGender.rawValue, frenchGender: frenchGender.rawValue, nounType : "",
                        verbLikes: "", adjLikes: "")
    }
    
    func convertNounTypeStringToNounTypes(inputString: String){
        nounType = .person
        if ( inputString == "Any" ){nounType = .any}
        if ( inputString == "Pl" ){nounType = .place}
        if ( inputString == "A" ){nounType = .animal}
        if ( inputString == "T" ){nounType = .thing}
    }
    
    func convertFavoriteVerbStringToFavoriteVerbs(inputString: String){
        let util = VerbUtilities()
        let strList = getNounTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                print(str)
                //favoriteSubjects.append(getNounTypeFromString(str: str))}
            }
        }
    }
    
    func convertFavoriteAdjectiveStringToFavoriteAdjectives(inputString: String){
        let util = VerbUtilities()
        let strList = getNounTypesAsStringList()
        //let strList = getAdjectiveTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                print(str)
                //favoriteObjects.append(getNounTypeFromString(str: str))}
            }
        }
        
        func constructPlural(){
            plural = word + "s"
        }
    }
}

class RomanceNoun : Noun {
    var gender : Gender
    var number : Number = .singular
    
    override init(jsonNoun: JsonNoun, language: LanguageType){
        gender = .masculine
        super.init(jsonNoun: jsonNoun, language: language)
    }
    
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
        if word == self.word { return (true, nounType, .singular, gender)}
        if word == self.plural { return (true, nounType, .plural, gender)}
        return (false, nounType, .plural, gender)
    }
    
    func constructPlural(){
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
    var startsWithVowelSound = false
    init(jsonNoun: JsonNoun){
        super.init(jsonNoun: jsonNoun, language: .French)
        constructPlural()
        gender = frenchGender
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

class SpanishNoun : RomanceNoun {
    init(jsonNoun: JsonNoun){
        super.init(jsonNoun: jsonNoun, language: .Spanish)
        constructPlural()
        gender = spanishGender
    }
    
    override func constructPlural(){
        let util = VerbUtilities()
        var root = word
        root.removeLast()
        
        let suffix = util.getLastNCharactersInString(inputString: word, copyCount: 1)
        
        if ( suffix == "l" || suffix == "n" ){ plural = root + "es" }
        if ( suffix == "s" ){ plural = root}
        else{ plural = word + "s" }
    }
    
}


class EnglishNoun : Noun {
    override init(word: String, def: String, type: NounType ){
        super.init(word:word, def: def, type:type)
        //super.constructPlural()
    }
    
    func isNoun(word: String)->(Bool, NounType, Number){
        if word == word { return (true, nounType, .singular)}
        if word == plural { return (true, nounType, .plural)}
        return (false, nounType, .plural)
    }
}

