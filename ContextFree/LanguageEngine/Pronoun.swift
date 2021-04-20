//
//  ViperPronoun.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

enum ThirdPersonForm{
    case el
    case ella
    case usted
    case si
}

class Pronoun : Word {
    var type: PronounType
    
    init(word: String, def: String, type : PronounType){
        self.type = type
        super.init(word: word, def: def, wordType: .pronoun)
    }
    
}

class EnglishPronoun : Pronoun {
    func isSubjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "I"){return(.SUBJECT, .masculine, .S1)}
        if (word == "you"){return(.SUBJECT, .masculine, .S2)}
        if (word == "he"){return(.SUBJECT, .masculine, .S3)}
        if (word == "she"){return(.SUBJECT, .masculine, .S3)}
        if (word == "we"){return(.SUBJECT, .masculine, .P1)}
        if (word == "they"){return(.SUBJECT, .masculine, .P3)}
        return (.none, .feminine, .S1)
    }
}

class SpanishPronoun : Pronoun {
    
    func getPronoun(type: PronounType, gender: Gender, person: Person)->String{
        switch type {
        case .SUBJECT:
            return getSubject(gender: gender, person: person, formal: false)
        case .OBJECT:
            return getDirectObject(gender: gender, person: person)
        case .REFLEXIVE:
            return getReflexive(person: person)
        case .INDIRECT_OBJECT:
            return getIndirectObject(person: person)
        case .PREPOSITIONAL:
            return getPrepositional(person: person, thirdPersonForm: .si)
        case .none:
            return "XXX"
            
        case .PERSONAL:
            return "XXX"
        case .POSSESSIVE:
            return "XXX"
        case .DEMONSTRATIVE:
            return "XXX"
        case .RELATIVE:
            return "XXX"
        case .INTERROGATIVE:
            return "XXX"
        case .NON_PRONOUN:
            return "XXX"
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
    
    func isReflexivePronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.REFLEXIVE, .masculine, .S1)}
        if (word == "te"){return(.REFLEXIVE, .masculine, .S2)}
        if (word == "se"){return(.REFLEXIVE, .masculine, .S3)}  //first one
        if (word == "nos"){return(.REFLEXIVE, .masculine, .P1)}
        if (word == "os"){return(.REFLEXIVE, .masculine, .P2)}
        return(.none, .masculine, .S1)
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
    
    func isIndirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.INDIRECT_OBJECT, .masculine, .S1)}
        if (word == "te"){return(.INDIRECT_OBJECT, .masculine, .S2)}
        if (word == "le"){return(.INDIRECT_OBJECT, .masculine, .S3)}  //first one
        if (word == "nos"){return(.INDIRECT_OBJECT, .masculine, .P1)}
        if (word == "os"){return(.INDIRECT_OBJECT, .masculine, .P2)}
        if (word == "les"){return(.INDIRECT_OBJECT, .masculine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    
    func getDirectObject(gender: Gender, person: Person)->String{
        switch person{
        case .S1: return "me"
        case .S2: return "te"
        case .S3:
            switch(gender){
            case .masculine: return "lo"
            case .feminine: return "la"
            }
        case .P1: return "nos"
        case .P2: return "os"
        case .P3:
            switch(gender){
            case .masculine: return "los"
            case .feminine: return "las"
            }
        }
    }
    func isDirectObjectPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "me"){return(.OBJECT, .masculine, .S1)}
        if (word == "te"){return(.OBJECT, .masculine, .S2)}
        if (word == "lo"){return(.OBJECT, .masculine, .S3)}
        if (word == "la"){return(.OBJECT, .feminine, .S3)}
        if (word == "nos"){return(.OBJECT, .masculine, .P1)}
        if (word == "os"){return(.OBJECT, .masculine, .P2)}
        if (word == "los"){return(.OBJECT, .masculine, .P3)}
        if (word == "las"){return(.OBJECT, .feminine, .P3)}
        return(.none, .masculine, .S1)
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
        case .P1: return "nos"
        case .P2: return "os"
        case .P3:
            switch (thirdPersonForm){
            case .el: return "ellos"
            case .ella: return "ellas"
            case .usted: return "Uds."
            case .si: return "sí"
            }
        }
    }
    
    func isPrepositionalPronoun(word: String)->(PronounType, Gender, Person){
        if (word == "mí"){return(.PREPOSITIONAL, .masculine, .S1)}
        if (word == "ti"){return(.PREPOSITIONAL, .masculine, .S2)}
        if (word == "él" || word == "sí"){return(.PREPOSITIONAL, .masculine, .S3)}
        if (word == "ella"){return(.PREPOSITIONAL, .feminine, .S3)}
        if (word == "Usted" || word == "Ud"){return(.PREPOSITIONAL, .feminine, .S3)}
        if (word == "nos"){return(.PREPOSITIONAL, .masculine, .P1)}
        if (word == "os"){return(.PREPOSITIONAL, .masculine, .P2)}
        if (word == "ellos"){return(.PREPOSITIONAL, .masculine, .P3)}
        if (word == "ellas"){return(.PREPOSITIONAL, .feminine, .P3)}
        return(.none, .masculine, .S1)
    }
    
    
    func getSubject(gender:Gender, person: Person, formal: Bool)->String{
        
        if formal {
            switch gender {
            case .masculine:
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
            case .masculine:
                switch person{
                case .S1: return "yo"
                case .S2: return "tú"
                case .S3: return "usted"
                case .P1: return "nosotros"
                case .P2: return "vosotros"
                case .P3: return "ustedes"
                }
            case .feminine:
                switch person{
                case .S1: return "yo"
                case .S2: return "tú"
                case .S3: return "usted"
                case .P1: return "nosotras"
                case .P2: return "vosotras"
                case .P3: return "ustedes"
                }
            }
        }
        
    }
    
    func isSubjectPronoun(word: String)->(PronounType, Gender, Person){
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
