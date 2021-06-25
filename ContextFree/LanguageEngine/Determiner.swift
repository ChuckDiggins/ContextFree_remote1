//
//  ViperDeterminer.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

class Determiner : Word {
    var type: DeterminerType
    var english = ""
    var spanish = ""
    var french = ""
    
    override init(){
        self.type = .definite
        super.init(word: "", def: "", wordType: .determiner) 
    }
    
    init(word: String, def: String, type : DeterminerType){
        self.type = type
        super.init(word: word, def: def, wordType: .determiner)
    }
    
    init(json: JsonDeterminer, language: LanguageType){
        self.english = json.english
        self.french = json.french
        self.spanish = json.spanish
        self.type = DeterminerType.indefinite
        
        switch(language){
        case .Spanish:  super.init(word: spanish, def: english, wordType: .noun)
        case .French:  super.init(word: french, def: english, wordType: .noun)
        case .English:  super.init(word: english, def: english, wordType: .noun)
        default:
            super.init(word: spanish, def: english, wordType: .adjective)
            
            convertDeterminerTypeStringToDeterminerType(inputString: json.determinerType)
        }
    }
    
    func convertDeterminerTypeStringToDeterminerType(inputString: String){
        type = .partative
        if ( inputString == "I" ){type = .indefinite}
        if ( inputString == "D" ){type = .definite}
        if ( inputString == "P" ){type = .possessive}
        if ( inputString == "N" ){type = .interrogative}
        if ( inputString == "M" ){type = .demonstrative}
    }
}

class EnglishDeterminer : Determiner {
    override init(json: JsonDeterminer, language: LanguageType){
        super.init(json: json, language: language)
    }
    override init(){
        super.init(word: "", def: "", type : .definite)
    }
    
    //this
    var plural = ""   //these
    
    init(word:String, def: String, type : DeterminerType, plural: String){
        self.plural = plural
        super.init(word: word, def: def, type : type)
    }
    
    func getForm(number: Number)->String{
        switch number {
        case .singular:
            return word
        case .plural:
            if plural.count == 0 {
                if type == .definite {plural = "the"}
                else if type == .indefinite {plural = "some"}
                else if type == .possessive {plural = "my"}
            }
            return plural
        }
    }
    
    func isDeterminer(word: String)-> (Bool, DeterminerType, Number ){
        if ( word == self.word ){ return (true, type, .singular) }
        if ( word == self.plural ){ return (true, type, .plural) }
        return (false, type, .singular)
    }
}

class RomanceDeterminer : Determiner {
                             //eso
    var femWord = ""      //esa
    var mascPlural = ""   //esos
    var femPlural = ""    //esas
    
    override init(){
        super.init(word: "", def: "", type : .definite)
    }
    
    init(word:String, def:String, type : DeterminerType, femWord:String, mascPlural:String, femPlural:String ){
        self.femWord = femWord
        self.mascPlural = mascPlural
        self.femPlural = femPlural
        super.init(word: word, def: def, type : type)
    }
    
    override init(json: JsonDeterminer, language: LanguageType){
        super.init(json: json, language: language)
    }
    
    func getForm(gender: Gender, number: Number)->String{
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
    
    func isDeterminer(word: String)-> (Bool, DeterminerType, Gender, Number ){
        if ( word == word ){ return (true, type, .masculine, .singular) }
        if ( word == femWord ){ return (true, type, .feminine, .singular) }
        if ( word == mascPlural ){ return (true, type, .masculine, .plural) }
        if ( word == femPlural ){ return (true, type, .feminine, .plural) }
        return (false, type, .masculine, .singular)
    }
    
    
}

class SpanishDeterminer : RomanceDeterminer {
    override init(){
        super.init()
    }
    
    init(json: JsonDeterminer){
        super.init(json: json, language: .Spanish)
    }
    
    override func getForm(gender: Gender, number: Number)->String{
        switch type{
        case .indefinite:
            return getIndefiniteForm(gender: gender, number : number)
        case .definite:
            return getDefiniteForm(gender: gender, number : number)
        case .possessive:
            return getPossessiveForm( person: .S3, gender : gender, number : number)
        case .demonstrative:
            return getDemonstrativeForm(gender: gender, number : number)
        case .interrogative:
            return getInterrogativeForm(gender: gender, number : number)
        default:
            return ""
        }
    }
    
    
    func getIndefiniteForm( gender: Gender, number: Number)->String{
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
    
    func getDefiniteForm( gender: Gender, number: Number)->String{
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
    
    func getPossessiveForm( person: Person, gender : Gender, number : Number)->String{
        if gender == .masculine && number == .singular { return getSingularMasculinePossessiveForm(person: person)}
        if gender == .masculine && number == .plural { return getPluralMasculinePossessiveForm(person: person)}
        if gender == .feminine && number == .singular { return getSingularFemininePossessiveForm(person: person)}
        if gender == .feminine && number == .plural { return getPluralFemininePossessiveForm(person: person)}
        return "unknown possessive form"
    }
    
    func getSingularMasculinePossessiveForm(person : Person)->String{
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
    
    func getPluralMasculinePossessiveForm(person : Person)->String{
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
    
    func getSingularFemininePossessiveForm(person : Person)->String{
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
    
    func getPluralFemininePossessiveForm(person : Person)->String{
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
    
    func getInterrogativeForm( gender: Gender, number: Number)->String{
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
    
    func getDemonstrativeForm( gender: Gender, number: Number)->String{
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

class FrenchDeterminer : RomanceDeterminer {
    init(json: JsonDeterminer){
        super.init(json: json, language: .French)
    }
    
    override init(){
        super.init()
    }
    
    override func getForm(gender: Gender, number: Number)->String{
        switch type{
        case .indefinite:
            return getIndefiniteForm(gender: gender, number : number)
        case .definite:
            return getDefiniteForm(gender: gender, number : number)
        case .possessive:
            return getPossessiveForm( person: .S3, gender : gender, number : number)
        case .demonstrative:
            return getDemonstrativeForm(gender: gender, number : number)
        case .interrogative:
            return getInterrogativeForm(gender: gender, number : number)
        default:
            return ""
        }
    }
    
    
    func getIndefiniteForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "un"
            case .plural:
                return "des"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "une"
            case .plural:
                return "des"
            }
        }
    }
    
    func getDefiniteForm( gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return "le"
            case .plural:
                return "les"
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return "la"
            case .plural:
                return "les"
            }
        }
    }
    
    func getPossessiveForm( person: Person, gender : Gender, number : Number)->String{
        if gender == .masculine && number == .singular { return getSingularMasculinePossessiveForm(person: person)}
        if gender == .masculine && number == .plural { return getPluralMasculinePossessiveForm(person: person)}
        if gender == .feminine && number == .singular { return getSingularFemininePossessiveForm(person: person)}
        if gender == .feminine && number == .plural { return getPluralFemininePossessiveForm(person: person)}
        return "unknown possessive form"
    }
    
    func getSingularMasculinePossessiveForm(person : Person)->String{
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
    
    func getPluralMasculinePossessiveForm(person : Person)->String{
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
    
    func getSingularFemininePossessiveForm(person : Person)->String{
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
    
    func getPluralFemininePossessiveForm(person : Person)->String{
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
    func getInterrogativeForm( gender: Gender, number: Number)->String{
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
    
    func getDemonstrativeForm( gender: Gender, number: Number)->String{
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

