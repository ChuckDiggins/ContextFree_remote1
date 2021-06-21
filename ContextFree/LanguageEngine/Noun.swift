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
    var englishPlural = ""
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
        case .English:
            super.init(word: english, def: english, wordType: .noun)
            plural = jsonNoun.englishPlural
            englishPlural = jsonNoun.englishPlural
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
        return JsonNoun(spanish: word, english: english, french: french,  spanishGender: spanishGender.rawValue, frenchGender: frenchGender.rawValue, englishPlural: englishPlural, nounType : "",
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
    var m_baseString = ""
    var endsInY = false
    var endsInE = false
        
    override init(word: String, def: String, type: NounType ){
        super.init(word:word, def: def, type:type)
        constructPlural()
    }
    
    init(jsonNoun: JsonNoun){
        super.init(jsonNoun: jsonNoun, language: .English)
        constructPlural()
    }
    
    func isNoun(word: String)->(Bool, NounType, Number){
        if word == word { return (true, nounType, .singular)}
        if word == plural { return (true, nounType, .plural)}
        return (false, nounType, .plural)
    }
    
    func constructPlural(){
        if plural.count > 0 {return}
        let util = VerbUtilities()
        var root = word
        root.removeLast()
        
        var stem = prepareStem()
        if endsInY {plural = stem + "ies"}
        else if endsInE {
            plural = stem + "es"
        }
        else { plural = stem + "s" }
    }
    
    func prepareStem()->String{
        let util = VerbUtilities()
        m_baseString = word
        var stem = word
        let last = util.getLastNCharactersInString(inputString: stem, copyCount: 1)
        
        if util.isVowel(letter: last){
            stem = word
        }
        else if last == "y" {
            endsInY = true
            //only remove the y if preceded by a consonant - eg, "hurry" -> "hurries", but not "pray" -> "prays"
            var nextToLast = util.getLastNCharactersInString(inputString: word, copyCount: 2)
            nextToLast.removeLast()
            if !util.isVowel(letter: nextToLast){
                stem.removeLast()
            }
        }
        else {
            // boxes, approaches,
            let last2 = util.getLastNCharactersInString(inputString: stem, copyCount: 2)
            if last == "e" || last == "x" || last2 == "ch" || last2 == "sh" {
                endsInE = true
            }
        }
        return stem
    }
    
    func getString(number: Number)->String{
        switch number {
        case .singular:
            return word
        case .plural:
            return plural
        }
    }
}

