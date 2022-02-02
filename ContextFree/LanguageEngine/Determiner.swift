//
//  ViperDeterminer.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation
import JumpLinguaHelpers

public class Determiner : Word {
    var type: DeterminerType
    
    public override init(){
        self.type = .definite
        super.init(word: "", wordType: .determiner)
    }
    
    public init(word: String, type : DeterminerType){
        self.type = type
        super.init(word: word, wordType: .determiner)
    }
    
    public init(json: JsonDeterminer, language: LanguageType){
        self.type = DeterminerType.indefinite
        
        switch(language){
        case .Spanish:  super.init(word: json.spanish, wordType: .determiner)
        case .French:  super.init(word: json.french, wordType: .determiner)
        case .English:  super.init(word: json.english, wordType: .determiner)
        default:
            super.init(word: json.spanish, wordType: .determiner)
        }
        self.spanish = json.spanish
        self.french = json.french
        self.english = json.english
        convertDeterminerTypeStringToDeterminerType(inputString: json.determinerType)
    }
    
    public func convertDeterminerTypeStringToDeterminerType(inputString: String){
        type = .partative
        if ( inputString == "I" ){type = .indefinite}
        if ( inputString == "D" ){type = .definite}
        if ( inputString == "P" ){type = .possessive}
        if ( inputString == "N" ){type = .interrogative}
        if ( inputString == "M" ){type = .demonstrative}
    }
}

public class EnglishDeterminer : Determiner {
    
    public override init(json: JsonDeterminer, language: LanguageType){
        super.init(json: json, language: language)
    }
    
    public override init(){
        super.init(word: "", type : .definite)
    }
    
    public override init(word: String, type: DeterminerType){
        super.init(word: word, type: type)
    }
    
    //this
    var plural = ""   //these
    
    public init(word:String, def: String, type : DeterminerType, plural: String){
        self.plural = plural
        super.init(word: word, type : type)
    }
    
    public func getForm(number: Number, person: Person, gender: Gender, wordStartsWithVowelSound : Bool)->String{
        var detForm = "the"
        switch type {
        case .definite:
            detForm = "the"
        case .indefinite:
            if number == .singular {
                detForm = "a"
                if wordStartsWithVowelSound {detForm = "an"}
            }
            else { detForm = "some" }
        case .possessive:
            switch person {
            case .S1:
                detForm = "my"
            case .S2:
                detForm = "your"
            case .S3:
                switch gender {
                case .masculine:
                    detForm = "his"
                case .feminine:
                    detForm = "her"
                case .either:
                    detForm = "their"
                }
                
            case .P1:
                detForm = "our"
            case .P2:
                detForm = "your"
            case .P3:
                detForm = "their"
            }
        case .demonstrative:
            if number == .singular { detForm = "that"  }
            else { detForm = "those"}
        case .interrogative:
            detForm = "this"
        case .partative:
            detForm = "the"
        }
        return detForm
    }
    
    public func isDeterminer(word: String)-> (Bool, DeterminerType, Number ){
        if ( word == self.word ){ return (true, type, .singular) }
        if ( word == self.plural ){ return (true, type, .plural) }
        return (false, type, .singular)
    }
}

public class RomanceDeterminer : Determiner {
                             //eso
    var femWord = ""      //esa
    var mascPlural = ""   //esos
    var femPlural = ""    //esas
    
    public override init(){
        super.init(word: "", type : .definite)
    }
    
    public override init(word:String, type : DeterminerType){
        super.init(word: word, type : type)
    }
    
    public init(word:String, type : DeterminerType, femWord:String, mascPlural:String, femPlural:String ){
        self.femWord = femWord
        self.mascPlural = mascPlural
        self.femPlural = femPlural
        super.init(word: word, type : type)
    }
    
    public override init(json: JsonDeterminer, language: LanguageType){
        super.init(json: json, language: language)
    }
    
    public func getForm(number: Number, person: Person, gender: Gender)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return femWord
            case .plural:
                return femPlural
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return word
            case .plural:
                return mascPlural
            }
        }  
    }
    
    public func isDeterminer(word: String)-> (Bool, DeterminerType, Gender, Number ){
        if ( word == word ){ return (true, type, .masculine, .singular) }
        if ( word == femWord ){ return (true, type, .feminine, .singular) }
        if ( word == mascPlural ){ return (true, type, .masculine, .plural) }
        if ( word == femPlural ){ return (true, type, .feminine, .plural) }
        return (false, type, .masculine, .singular)
    }
    
    
}

public class SpanishDeterminer : RomanceDeterminer {
    public override init(){
        super.init()
    }
    
    public override init(word: String, type: DeterminerType){
        super.init(word: word, type: type)
    }
    
    public init(json: JsonDeterminer){
        super.init(json: json, language: .Spanish)
    }
    
    public override func getForm(number: Number, person: Person, gender: Gender)->String{
        switch type{
        case .indefinite:
            return getIndefiniteForm(gender: gender, number : number)
        case .definite:
            return getDefiniteForm(gender: gender, number : number)
        case .possessive:
            return getPossessiveForm( person: person, gender : gender, number : number)
        case .demonstrative:
            return getDemonstrativeForm(gender: gender, number : number)
        case .interrogative:
            return getInterrogativeForm(gender: gender, number : number)
        default:
            return ""
        }
    }
    
    
    public func getIndefiniteForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "una"
            case .plural:
                return "unas"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "un"
            case .plural:
                return "unos"
            }
        }
    }
    
    public func getDefiniteForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "la"
            case .plural:
                return "las"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "el"
            case .plural:
                return "los"
            }
        }
    }
    
    public func getPossessiveForm( person: Person, gender : Gender, number : Number)->String{
        if gender == .masculine && number == .singular { return getSingularMasculinePossessiveForm(person: person)}
        if gender == .masculine && number == .plural { return getPluralMasculinePossessiveForm(person: person)}
        if gender == .feminine && number == .singular { return getSingularFemininePossessiveForm(person: person)}
        if gender == .feminine && number == .plural { return getPluralFemininePossessiveForm(person: person)}
        return "unknown possessive form"
    }
    
    public func getSingularMasculinePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mi"
        case .S2:
            return "tu"
        case .S3:
            return "su"
        case .P1:
            return "nuestro"
        case .P2:
            return "vuestro"
        case .P3:
            return "su"
        }
    }
    
    public func getPluralMasculinePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mis"
        case .S2:
            return "tus"
        case .S3:
            return "sus"
        case .P1:
            return "nuestros"
        case .P2:
            return "vuestros"
        case .P3:
            return "sus"
        }
    }
    
    public func getSingularFemininePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mi"
        case .S2:
            return "tu"
        case .S3:
            return "su"
        case .P1:
            return "nuestra"
        case .P2:
            return "vuestra"
        case .P3:
            return "su"
        }
    }
    
    public func getPluralFemininePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mis"
        case .S2:
            return "tus"
        case .S3:
            return "sus"
        case .P1:
            return "nuestras"
        case .P2:
            return "vuestras"
        case .P3:
            return "sus"
        }
    }
    
    public func getInterrogativeForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        }
    }
    
    public func getDemonstrativeForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        }
    }
    
}

public class FrenchDeterminer : RomanceDeterminer {
    public init(json: JsonDeterminer){
        super.init(json: json, language: .French)
    }
    
    public override init(word: String, type: DeterminerType){
        super.init(word: word, type: type)
    }
    
    public override init(){
        super.init()
    }
    
    public override func getForm(number: Number, person: Person, gender: Gender)->String{
        switch type{
        case .indefinite:
            return getIndefiniteForm(gender: gender, number : number)
        case .definite:
            return getDefiniteForm(gender: gender, number : number)
        case .possessive:
            return getPossessiveForm( person: person, gender : gender, number : number)
        case .demonstrative:
            return getDemonstrativeForm(gender: gender, number : number)
        case .interrogative:
            return getInterrogativeForm(gender: gender, number : number)
        default:
            return ""
        }
    }
    
    
    public func getIndefiniteForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "une"
            case .plural:
                return "des"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "un"
            case .plural:
                return "des"
            }
        }
    }
    
    public func getDefiniteForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "la"
            case .plural:
                return "les"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "le"
            case .plural:
                return "les"
            }
        }
    }
    
    public func getPossessiveForm( person: Person, gender : Gender, number : Number)->String{
        if gender == .masculine && number == .singular { return getSingularMasculinePossessiveForm(person: person)}
        if gender == .masculine && number == .plural { return getPluralMasculinePossessiveForm(person: person)}
        if gender == .feminine && number == .singular { return getSingularFemininePossessiveForm(person: person)}
        if gender == .feminine && number == .plural { return getPluralFemininePossessiveForm(person: person)}
        return "unknown possessive form"
    }
    
    public func getSingularMasculinePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mon"
        case .S2:
            return "ton"
        case .S3:
            return "son"
        case .P1:
            return "notre"
        case .P2:
            return "votre"
        case .P3:
            return "leur"
        }
    }
    
    public func getPluralMasculinePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mes"
        case .S2:
            return "tes"
        case .S3:
            return "ses"
        case .P1:
            return "nos"
        case .P2:
            return "vos"
        case .P3:
            return "leurs"
        }
    }
    
    public  func getSingularFemininePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mon"
        case .S2:
            return "ton"
        case .S3:
            return "son"
        case .P1:
            return "notre"
        case .P2:
            return "votre"
        case .P3:
            return "leur"
        }
    }
    
    public func getPluralFemininePossessiveForm(person : Person)->String{
        switch person {
        case .S1:
            return "mes"
        case .S2:
            return "tes"
        case .S3:
            return "ses"
        case .P1:
            return "nos"
        case .P2:
            return "vos"
        case .P3:
            return "leurs"
        }
    }
    //need to be corrected
    public func getInterrogativeForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        }
    }
    
    public func getDemonstrativeForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "xxx"
            case .plural:
                return "xxx"
            }
        }
    }

    
}

