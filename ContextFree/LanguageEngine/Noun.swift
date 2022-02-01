//
//  ViperNoun.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

public class Noun : Word {

    var plural = ""
    var englishPlural = ""
    var spanishGender = Gender.masculine
    var frenchGender = Gender.masculine
    var nounType: NounType
    
    public override init(){
        self.nounType = NounType.any
        super.init(word: "", wordType: .noun)
    }
    
    public init(word: String, type : NounType){
        self.nounType = type
        super.init(word: word,  wordType: .noun)
    }
    
    public init(jsonNoun: JsonNoun, language: LanguageType){
        self.nounType = NounType.any

        switch(language){
        case .Spanish:  super.init(word: jsonNoun.spanish, wordType: .noun)
        case .French:  super.init(word: jsonNoun.french,  wordType: .noun)
        case .English:
            super.init(word: jsonNoun.english, wordType: .noun)
            plural = jsonNoun.englishPlural
            englishPlural = jsonNoun.englishPlural
        case .Agnostic:  super.init(word: jsonNoun.spanish, wordType: .noun)
            englishPlural = jsonNoun.englishPlural
        default:
            super.init(word: jsonNoun.spanish,  wordType: .noun)
        }
        english = jsonNoun.english
        french = jsonNoun.french
        spanish = jsonNoun.spanish
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
    
    public func createJsonNoun()->JsonNoun{
        return JsonNoun(spanish: word, english: english, french: french,  spanishGender: spanishGender.rawValue, frenchGender: frenchGender.rawValue, englishPlural: englishPlural, nounType : "",
                        verbLikes: "", adjLikes: "")
    }
    
    
    public func convertNounTypeStringToNounTypes(inputString: String){
        nounType = .person
        if ( inputString == "Any" ){nounType = .any}
        if ( inputString == "Pl" ){nounType = .place}
        if ( inputString == "A" ){nounType = .animal}
        if ( inputString == "T" ){nounType = .thing}
    }
    
    public func convertFavoriteVerbStringToFavoriteVerbs(inputString: String){
        let util = VerbUtilities()
        let strList = getNounTypesAsStringList()
        for str in strList {
            if util.doesWordContainLetter(inputString: inputString, letter: str) {
                print(str)
                //favoriteSubjects.append(getNounTypeFromString(str: str))}
            }
        }
    }
    
    public func convertFavoriteAdjectiveStringToFavoriteAdjectives(inputString: String){
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

public class RomanceNoun : Noun {
    var gender : Gender
    var number : Number = .singular
    
    public override init(jsonNoun: JsonNoun, language: LanguageType){
        gender = .masculine
        super.init(jsonNoun: jsonNoun, language: language)
    }
    
    public init(word: String, type: NounType, gender: Gender){
        self.gender = gender
        super.init(word: word, type : type)
        constructPlural()
    }
    
    public func setNumber(number: Number){ self.number = number  }
    public func getNumber()->Number{return number}
    public func setGender(gender: Gender){ self.gender = gender  }
    public func getGender ()->Gender {return gender }
    
    public func getNounString(number : Number)->String {
        if number == .singular { return word }
        return plural
    }
    
    public func isNoun(word: String)->(Bool, NounType, Number, Gender){
        if word == self.word { return (true, nounType, .singular, gender)}
        if word == self.plural { return (true, nounType, .plural, gender)}
        return (false, nounType, .plural, gender)
    }
    
    public func constructPlural(){
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

public  class FrenchNoun : RomanceNoun {
    var startsWithVowelSound = false
    public init(jsonNoun: JsonNoun){
        super.init(jsonNoun: jsonNoun, language: .French)
        constructPlural()
        gender = frenchGender
    }
    
    public override init(word: String, type: NounType, gender: Gender ){
        super.init(word:word, type:type, gender: gender)
        constructPlural()
    }
    
    
    public override func constructPlural(){
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

public class SpanishNoun : RomanceNoun {
    
    public override init(word: String, type: NounType, gender: Gender ){
        super.init(word:word, type:type, gender: gender)
        constructPlural()
    }
    
    public init(jsonNoun: JsonNoun){
        super.init(jsonNoun: jsonNoun, language: .Spanish)
        constructPlural()
        gender = spanishGender
    }
    
    public override func constructPlural(){
        let util = VerbUtilities()
        var root = word
        //root.removeLast()
        
        //ó  á í é
        
        switch root {
        case "examen":
            plural = "exámen"
            return
        case "joven":
            plural = "jóvenes"
            return
        case "crimen":
            plural = "crímenes"
            return
        case "ciempiés":
            plural = "ciempiés"
            return
        case "pasapuré":
            plural = "pasapuré"
            return
        case "análisis":
            plural = "análisis"
            return
        case "jueves":
            plural = "jueves"
            return
        case "tórax":
            plural = "tórax"
            return
        default: break
        }
              
        let suffix = util.getLastNCharactersInString(inputString: word, copyCount: 1)
        switch suffix {
        case "l", "n", "r", "d", "z", "j", "s","x":
            plural = word + "es"
            return
        case "ú", "í":
            plural = word + "es"
            return
        default:
            break
        }
        
        let suffix2  = util.getLastNCharactersInString(inputString: word, copyCount: 2)
        switch suffix2 {
        case "ch", "ay", "ey", "iy", "oy", "uy":
            plural = word + "es"
            return
        default:
            break
        }
        
        switch suffix2 {
        case "ón":  //ocasión = ocasiones
            root.removeLast(2)
            plural = root + "ones"
            return
        case "és":  //francés = franceses
            root.removeLast(2)
            plural = root + "eses"
            return
        default:
            break
        }
        plural = word + "s"
    }
    
}


public class EnglishNoun : Noun {
    var m_baseString = ""
    var endsInY = false
    var endsInE = false
        
    public init(word: String, type: NounType, englishPlural: String ){
        super.init(word:word, type:type)
        plural = englishPlural
    }
    
    public override init(word: String, type: NounType ){
        super.init(word:word, type:type)
        constructPlural()
    }
    
    public init(jsonNoun: JsonNoun){
        super.init(jsonNoun: jsonNoun, language: .English)
        if jsonNoun.englishPlural.count > 0 {plural = englishPlural}
        else { constructPlural()}
    }
    
    public func isNoun(word: String)->(Bool, NounType, Number){
        if word == word { return (true, nounType, .singular)}
        if word == plural { return (true, nounType, .plural)}
        return (false, nounType, .plural)
    }
    
    public func constructPlural(){
        if englishPlural.count > 0 {return}
        var root = word
        root.removeLast()
        
        let stem = prepareStem()
        if endsInY {plural = stem + "ies"}
        else if endsInE {
            plural = stem + "es"
        }
        else { plural = stem + "s" }
    }
    
    public func prepareStem()->String{
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
            // boxes, approaches, bosses
            let last2 = util.getLastNCharactersInString(inputString: stem, copyCount: 2)
            if last == "e" || last == "x" || last2 == "ch" || last2 == "sh" || last2 == "ss"  {
                endsInE = true
            }
        }
        return stem
    }
    
    public func getString(number: Number)->String{
        switch number {
        case .singular:
            return word
        case .plural:
            return plural
        }
    }
}

