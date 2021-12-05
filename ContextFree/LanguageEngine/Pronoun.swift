//
//  ViperPronoun.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//
//    ,,,
import Foundation

class Pronoun : Word {
    var type: PronounType
    
    init(word: String, type : PronounType){
        self.type = type
        super.init(word: word, wordType: .pronoun)
    }
    
    override init(){
        self.type = PronounType.PERSONAL
        super.init(word: "", wordType: .pronoun)
    }
    
    
    init(json: JsonPronoun, language: LanguageType){
        type = PronounType.SUBJECT
        super.init(word: json.spanish, wordType: .pronoun)
        self.spanish = json.spanish
        self.french = json.french
        self.english = json.english
        convertPronounTypeStringToPronounType(inputString: json.pronounType)
    }
    
    func convertPronounTypeStringToPronounType(inputString: String){
        type = .SUBJECT
        if ( inputString == "S" ){type = .SUBJECT}
        if ( inputString == "IO" ){type = .INDIRECT_OBJECT}
        if ( inputString == "DO" ){type = .DIRECT_OBJECT}
        if ( inputString == "P" ){type = .PREPOSITIONAL}
        if ( inputString == "R" ){type = .REFLEXIVE}
    }
    
    func isPronoun(word: String)->[PronounType]{
        var pt = Array<PronounType>()
        
        var result =  isSubjectPronoun(word: word)
        if (result.0 == .SUBJECT){pt.append(result.0)}
        result =  isReflexivePronoun(word: word)
        if (result.0 == .REFLEXIVE){pt.append(result.0)}
        result =  isIndirectObjectPronoun(word: word)
        if (result.0 == .INDIRECT_OBJECT){pt.append(result.0)}
        result =  isDirectObjectPronoun(word: word)
        if (result.0 == .DIRECT_OBJECT){pt.append(result.0)}
        result =  isPrepositionalPronoun(word: word)
        if (result.0 == .PREPOSITIONAL){pt.append(result.0)}
        
        return pt
    }
    
    func getReflexive(language: LanguageType, person: Person, startsWithVowelSound: Bool)->String{
        switch language {
        case .Spanish: return SpanishPronoun().getReflexive(person: person)
        case .French:
            if startsWithVowelSound { return FrenchPronoun().getReflexiveContraction(person: person)}
            else {return FrenchPronoun().getReflexive(person: person)}
        case .English: return EnglishPronoun().getReflexive(person: person)
        default: break
        }
        return ""
    }
    
    func isReflexivePronoun(word: String)->(PronounType, Gender, Person){
        return(.none, .masculine, .S1)
    }
    
    func isIndirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        return(.none, .masculine, .S1)
    }
    
    func isDirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        return(.none, .masculine, .S1)
    }
    
    func isPrepositionalPronoun(word: String)->(PronounType, Gender, Person){
        return(.none, .masculine, .S1)
    }
    
    func isSubjectPronoun(word: String)->(PronounType, Gender, Person){
        return(.none, .masculine, .S1)
    }
    
}

class EnglishPronoun : Pronoun {

    func getForm(gender:Gender, person: Person)->String {
        switch type {
        case .SUBJECT: return getSubject(gender: gender, person: person)
        case .DIRECT_OBJECT: return getDirectObject(gender: gender, person: person)
        case .INDIRECT_OBJECT: return getIndirectObject(gender: gender, person: person)
        case .REFLEXIVE: return getReflexive(person: person)
        case .PREPOSITIONAL: return getPrepositional(gender: gender, person: person)
        default: return ""
        }
    }
    
    func getSubject(gender: Gender, person: Person)->String{
        switch person{
        case .S1: return "I"
        case .S2: return "you"
        case .S3:
            if gender == .masculine {return "he"}
            else {return "she"}
        case .P1: return "we"
        case .P2: return "you"
        case .P3: return "they"
        }
    }

    func getReflexive(person: Person)->String{
        switch person{
        case .S1: return "myself"
        case .S2: return "yourself"
        case .S3: return "himself"
        case .P1: return "ourselves"
        case .P2: return "yourselves"
        case .P3: return "themselves"
        }
    }
    
    func getIndirectObject(gender: Gender, person: Person)->String{
            switch person{
            case .S1: return "me"
            case .S2: return "you"
            case .S3:
                if gender == .masculine {return "him"}
                else {return "her"}
            case .P1: return "us"
            case .P2: return "you"
            case .P3: return "them"
            }
    }
    
    func getDirectObject(gender: Gender, person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "you"
        case .S3:
            if gender == .masculine {return "him"}
            else {return "her"}
        case .P1: return "us"
        case .P2: return "you"
        case .P3:
            switch(gender){
            case .masculine, .either: return "them"
            case .feminine: return "them"
            }
        }
    }
    
    func getPrepositional(gender: Gender, person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "you"
        case .S3:
            if gender == .masculine {return "him"}
            else {return "her"}
        case .P1: return "us"
        case .P2: return "you"
        case .P3:
            switch(gender){
            case .masculine, .either: return "them"
            case .feminine: return "them"
            }
        }
    }


    
    override func isSubjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "I"){return(.SUBJECT, .masculine, .S1)}
        if (word == "you"){return(.SUBJECT, .masculine, .S2)}
        if (word == "he"){return(.SUBJECT, .masculine, .S3)}
        if (word == "she"){return(.SUBJECT, .masculine, .S3)}
        if (word == "we"){return(.SUBJECT, .masculine, .P1)}
        if (word == "they"){return(.SUBJECT, .masculine, .P3)}
        return (.none, .feminine, .S1)
    }
    
    
}

enum ThirdPersonForm{
    case el
    case ella
    case usted
    case si
}

class FrenchPronoun : Pronoun {
    func getForm(gender:Gender, person: Person)->String {
        switch type {
        case .SUBJECT: return getSubject(gender: gender, person: person, formal: false)
        case .DIRECT_OBJECT: return getDirectObject(gender: gender, person: person)
        case .INDIRECT_OBJECT: return getIndirectObject(person: person)
        case .REFLEXIVE: return getReflexive(person: person)
        case .PREPOSITIONAL: return getPrepositional(person: person, thirdPersonForm: .el)
        default: return ""
        }
    }
    
    func getSubject(gender:Gender, person: Person, formal: Bool)->String{
        switch gender {
        case .masculine, .either:
            switch person{
            case .S1: return "je"
            case .S2: return "tu"
            case .S3: return "il"
            case .P1: return "nous"
            case .P2: return "vous"
            case .P3: return "ils"
            }
        case .feminine:
            switch person{
            case .S1: return "je"
            case .S2: return "tu"
            case .S3: return "elle"
            case .P1: return "nous"
            case .P2: return "vour"
            case .P3: return "elles"
            }
        }
    }
    
    func getReflexive(person: Person, startsWithVowelSound: Bool)->String{
        if startsWithVowelSound {return getReflexiveContraction(person: person)}
        return getReflexive(person: person)
    }
    
    func getReflexive(person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3: return "se"
        case .P1: return "nous"
        case .P2: return "vous"
        case .P3: return "se"
        }
    }
    
    func getReflexiveContraction(person: Person)->String{
        switch person{
        case .S1: return "m'"
        case .S2: return "t'"
        case .S3: return "s'"
        case .P1: return "nous"
        case .P2: return "vous"
        case .P3: return "s'"
        }
    }
    
    func getIndirectObject(person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3: return "lui"
        case .P1: return "nos"
        case .P2: return "os"
        case .P3: return "leur"
        }
    }
    
    func getDirectObject(gender: Gender, person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3:
            switch(gender){
            case .masculine, .either: return "le"
            case .feminine: return "la"
            }
        case .P1: return "nos"
        case .P2: return "os"
        case .P3:
            switch(gender){
            case .masculine, .either: return "les"
            case .feminine: return "les"
            }
        }
    }
    
    func getPrepositional(person: Person, thirdPersonForm : ThirdPersonForm)->String{
        switch person{
        case .S1: return "moi"
        case .S2: return "toi"
        case .S3:
            switch (thirdPersonForm){
            case .el: return "lui"
            case .ella: return "elle"
            default: return "lui"
            }
        case .P1: return "nous"
        case .P2: return "vous"
        case .P3:
            switch (thirdPersonForm){
            case .el: return "eux"
            case .ella: return "elles"
            default: return "eux"
            }
        }
    }
    
    
    override func isSubjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "je"){return(.SUBJECT, .masculine, .S1)}
        if (word == "tu"){return(.SUBJECT, .masculine, .S2)}
        if (word == "il" ){return(.SUBJECT, .masculine, .S3)}
        if (word == "elle"){return(.SUBJECT, .feminine, .S3)}
        if (word == "nous" ){return(.SUBJECT, .feminine, .P1)}
        if (word == "vous" ){return(.SUBJECT, .feminine, .P2)}
        if (word == "elles"){return(.SUBJECT, .masculine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    override func isReflexivePronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.REFLEXIVE, .masculine, .S1)}
        if (word == "te"){return(.REFLEXIVE, .masculine, .S2)}
        if (word == "se"){return(.REFLEXIVE, .masculine, .S3)}  //first one
        if (word == "nous"){return(.REFLEXIVE, .masculine, .P1)}
        if (word == "vous"){return(.REFLEXIVE, .masculine, .P2)}
        return(.none, .masculine, .S1)
    }
    
    override func isPrepositionalPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "moi"){return(.PREPOSITIONAL, .masculine, .S1)}
        if (word == "toi"){return(.PREPOSITIONAL, .masculine, .S2)}
        if (word == "lui" ){return(.PREPOSITIONAL, .masculine, .S3)}
        if (word == "elle"){return(.PREPOSITIONAL, .feminine, .S3)}
        if (word == "nous"){return(.PREPOSITIONAL, .masculine, .P1)}
        if (word == "vous"){return(.PREPOSITIONAL, .masculine, .P2)}
        if (word == "eux"){return(.PREPOSITIONAL, .masculine, .P3)}
        if (word == "elles"){return(.PREPOSITIONAL, .feminine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    override func isDirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.DIRECT_OBJECT, .masculine, .S1)}
        if (word == "te"){return(.DIRECT_OBJECT, .masculine, .S2)}
        if (word == "le"){return(.DIRECT_OBJECT, .masculine, .S3)}
        if (word == "nous"){return(.DIRECT_OBJECT, .masculine, .P1)}
        if (word == "vous"){return(.DIRECT_OBJECT, .masculine, .P2)}
        if (word == "les"){return(.DIRECT_OBJECT, .masculine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    override func isIndirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.INDIRECT_OBJECT, .masculine, .S1)}
        if (word == "te"){return(.INDIRECT_OBJECT, .masculine, .S2)}
        if (word == "lui"){return(.INDIRECT_OBJECT, .masculine, .S3)}  //first one
        if (word == "nos"){return(.INDIRECT_OBJECT, .masculine, .P1)}
        if (word == "os"){return(.INDIRECT_OBJECT, .masculine, .P2)}
        if (word == "leur"){return(.INDIRECT_OBJECT, .masculine, .P3)}
        return(.none, .masculine, .S1)
    }
    
}


class SpanishPronoun : Pronoun {
    func getForm(gender:Gender, person: Person)->String {
        switch type {
        case .SUBJECT: return getSubject(gender: gender, person: person, formal: false)
        case .DIRECT_OBJECT: return getDirectObject(gender: gender, person: person)
        case .INDIRECT_OBJECT: return getIndirectObject(person: person)
        case .REFLEXIVE: return getReflexive(person: person)
        case .PREPOSITIONAL: return getPrepositional(person: person, thirdPersonForm: .el)
        default: return ""
        }
    }
    
    func getSubject(gender:Gender, person: Person, formal: Bool)->String{
        
        if formal {
            switch gender {
            case .masculine, .either:
                switch person{
                case .S1: return "yo"
                case .S2: return "tú"
                case .S3: return "él"
                case .P1: return "nosotros"
                case .P2: return "vosotros"
                case .P3: return "ellos"
                }
            case .feminine:
                switch person{
                case .S1: return "yo"
                case .S2: return "tú"
                case .S3: return "ella"
                case .P1: return "nosotras"
                case .P2: return "vosotras"
                case .P3: return "ellas"
                }
            }
        } else {
            switch gender {
            case .masculine, .either:
                switch person{
                case .S1: return "yo"
                case .S2: return "tú"
                case .S3: return "él"
                case .P1: return "nosotros"
                case .P2: return "vosotros"
                case .P3: return "ellos"
                }
            case .feminine:
                switch person{
                case .S1: return "yo"
                case .S2: return "tú"
                case .S3: return "ella"
                case .P1: return "nosotras"
                case .P2: return "vosotras"
                case .P3: return "ellas"
                }
            }
        }
        
    }
    
    func getReflexive(person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3: return "se"
        case .P1: return "nos"
        case .P2: return "os"
        case .P3: return "se"
        }
    }
    
    
    
    func getIndirectObject(person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3: return "le"
        case .P1: return "nos"
        case .P2: return "os"
        case .P3: return "les"
        }
    }
    
    
    func getDirectObject(gender: Gender, person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3:
            switch(gender){
            case .masculine, .either: return "lo"
            case .feminine: return "la"
            }
        case .P1: return "nos"
        case .P2: return "os"
        case .P3:
            switch(gender){
            case .masculine, .either: return "los"
            case .feminine: return "las"
            }
        }
    }
    
    
    func getPrepositional(person: Person, thirdPersonForm : ThirdPersonForm)->String{
        switch person{
        case .S1: return "mí"
        case .S2: return "ti"
        case .S3:
            switch (thirdPersonForm){
            case .el: return "él"
            case .ella: return "ella"
            case .usted: return "Ud."
            case .si: return "sí"
            }
        case .P1: return "nosotros"
        case .P2: return "vosotros"
        case .P3:
            switch (thirdPersonForm){
            case .el: return "ellos"
            case .ella: return "ellas"
            case .usted: return "Uds."
            case .si: return "sí"
            }
        }
    }
    
    override func isDirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.DIRECT_OBJECT, .masculine, .S1)}
        if (word == "te"){return(.DIRECT_OBJECT, .masculine, .S2)}
        if (word == "lo"){return(.DIRECT_OBJECT, .masculine, .S3)}
        if (word == "la"){return(.DIRECT_OBJECT, .feminine, .S3)}
        if (word == "nos"){return(.DIRECT_OBJECT, .masculine, .P1)}
        if (word == "os"){return(.DIRECT_OBJECT, .masculine, .P2)}
        if (word == "los"){return(.DIRECT_OBJECT, .masculine, .P3)}
        if (word == "las"){return(.DIRECT_OBJECT, .feminine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    
    override func isPrepositionalPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "mí"){return(.PREPOSITIONAL, .masculine, .S1)}
        if (word == "ti"){return(.PREPOSITIONAL, .masculine, .S2)}
        if (word == "él" || word == "sí"){return(.PREPOSITIONAL, .masculine, .S3)}
        if (word == "ella"){return(.PREPOSITIONAL, .feminine, .S3)}
        if (word == "Usted" || word == "Ud"){return(.PREPOSITIONAL, .feminine, .S3)}
        if (word == "nosotros"){return(.PREPOSITIONAL, .masculine, .P1)}
        if (word == "vosotros"){return(.PREPOSITIONAL, .masculine, .P2)}
        if (word == "nosotras"){return(.PREPOSITIONAL, .feminine, .P1)}
        if (word == "vosotras"){return(.PREPOSITIONAL, .feminine, .P2)}
        if (word == "ellos"){return(.PREPOSITIONAL, .masculine, .P3)}
        if (word == "ellas"){return(.PREPOSITIONAL, .feminine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    override func isReflexivePronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.REFLEXIVE, .masculine, .S1)}
        if (word == "te"){return(.REFLEXIVE, .masculine, .S2)}
        if (word == "se"){return(.REFLEXIVE, .masculine, .S3)}  //first one
        if (word == "nos"){return(.REFLEXIVE, .masculine, .P1)}
        if (word == "os"){return(.REFLEXIVE, .masculine, .P2)}
        return(.none, .masculine, .S1)
    }
    
    override func isIndirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.INDIRECT_OBJECT, .masculine, .S1)}
        if (word == "te"){return(.INDIRECT_OBJECT, .masculine, .S2)}
        if (word == "le"){return(.INDIRECT_OBJECT, .masculine, .S3)}  //first one
        if (word == "nos"){return(.INDIRECT_OBJECT, .masculine, .P1)}
        if (word == "os"){return(.INDIRECT_OBJECT, .masculine, .P2)}
        if (word == "les"){return(.INDIRECT_OBJECT, .masculine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    
    
    override func isSubjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "yo"){return(.SUBJECT, .masculine, .S1)}
        if (word == "tú"){return(.SUBJECT, .masculine, .S2)}
        if (word == "él" ){return(.SUBJECT, .masculine, .S3)}
        if (word == "ella"){return(.SUBJECT, .feminine, .S3)}
        if (word == "Usted" || word == "Ud"){return(.SUBJECT, .masculine, .S3)}
        if (word == "nosotras" ){return(.SUBJECT, .feminine, .P1)}
        if (word == "nosotros" ){return(.SUBJECT, .masculine, .P1)}
        if (word == "vosotras" ){return(.SUBJECT, .feminine, .P2)}
        if (word == "vosotros" ){return(.SUBJECT, .masculine, .P2)}
        if (word == "ellos"){return(.SUBJECT, .masculine, .P3)}
        if (word == "ellas"){return(.SUBJECT, .feminine, .P3)}
        return(.none, .masculine, .S1)
    }
    
}
