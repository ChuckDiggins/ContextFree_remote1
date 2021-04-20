//
//  ViperAdjective.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

class Adjective : Word {
    var type : AdjectiveType
    var preferredPosition = AdjectivePositionType.preceding
    
    init(word: String, def: String, type : AdjectiveType){
        self.type = type
        super.init(word: word, def: def, wordType: .adjective)
    }

    func setPreferredPosition(position: AdjectivePositionType){
        preferredPosition = position
    }
    
    func getPreferredPosition()->AdjectivePositionType{
        return preferredPosition
    }
    
}

class RomanceAdjective : Adjective {
    
    var gender = Gender.feminine
    var number = Number.plural
    var femWord : String = ""
    var mascPlural : String = ""
    var femPlural : String = ""
    
    override init(word: String, def: String, type: AdjectiveType)
    {
        super.init(word: word, def: def, type: type)
        super.setPreferredPosition(position: .following)
    }
    
    func getForm(gender: Gender, number: Number)->String{
        switch gender{
        case .masculine:
            switch (number){
            case .singular: return word
            case .plural: return mascPlural
            }
        case .feminine:
            switch (number){
            case .singular: return femWord
            case .plural: return femPlural
            }
        }
    }
    
    func createForms(){
        femWord = word
    }
}

enum AdjectiveEndingType : String{
    case O = "o"
    case L = "l"
    case Z = "z"
    case AN = "án"
    case ON = "on"
    case IN = "ín"
    case OR = "or"
    case ES = "és"
    case ETE = "ete"
    case OTE = "ote"
    case Vowel = ""
    case Unknown = "UNK"
}


class SpanishAdjective : RomanceAdjective {
    override init(word: String, def: String, type: AdjectiveType)
    {
        super.init(word: word, def: def, type: type)
        self.createOtherForms()
    }
    
    func determineAdjectiveEnding()->AdjectiveEndingType{
        let util = Utilities()
        var endingType = AdjectiveEndingType.Unknown
        
        var ending : String
        
        //look for 1-letter suffix
        
        ending = util.getLastNCharactersInString(inputString: word, copyCount: 1)
        if ending == AdjectiveEndingType.O.rawValue { endingType = AdjectiveEndingType.O }
        //else if ending == IsVowel(ending) { endingType = AdjectiveEndingType.Vowel}
        else if ending == AdjectiveEndingType.Z.rawValue { endingType = AdjectiveEndingType.Z }
        else if ending == AdjectiveEndingType.L.rawValue { endingType = AdjectiveEndingType.L }

        //look for 2-letter suffix
        
        if ( endingType == .Unknown ){
            ending = util.getLastNCharactersInString(inputString: word, copyCount: 2)
            if ending == AdjectiveEndingType.AN.rawValue { endingType = AdjectiveEndingType.AN }
            else if ending == AdjectiveEndingType.IN.rawValue { endingType = AdjectiveEndingType.IN }
            else if ending == AdjectiveEndingType.ON.rawValue { endingType = AdjectiveEndingType.ON }
            else if ending == AdjectiveEndingType.OR.rawValue { endingType = AdjectiveEndingType.OR }
            else if ending == AdjectiveEndingType.ES.rawValue { endingType = AdjectiveEndingType.ES }
        }
        
        //look for 3-letter suffix

        if ( endingType == .Unknown ){
            ending = util.getLastNCharactersInString(inputString: word, copyCount: 3)
            if ending == AdjectiveEndingType.ETE.rawValue { endingType = AdjectiveEndingType.ETE }
            else if ending == AdjectiveEndingType.OTE.rawValue { endingType = AdjectiveEndingType.OTE }
        }
        return endingType
    }
    

   func createOtherForms()->Bool{
        let endingType = determineAdjectiveEnding()

        var stem : String = ""
    
        switch endingType {
        case .O:
            mascPlural = word + "s"
            stem = word
            stem.removeLast()
            femWord = stem + "a"
            femPlural = stem + "as"
        case .L:   //azul
            mascPlural = word + "es"
            femWord = word
            femPlural = stem + "es"
        case .Vowel:
            mascPlural = word + "s"
            stem = word
            stem.removeLast()
            femWord = stem + "a"
            femPlural = stem + "as"
        case .Z:
            mascPlural = word
            stem = word
            stem.removeLast()
            femWord = word + "a"
            femPlural = word + "as"
        case .OTE, .ETE:
            femWord = word
            mascPlural = word + "s"
            femPlural = femWord + "s"
        case .AN:
            stem = word
            stem.removeLast()
            stem.removeLast()
            femWord += "ana"
            mascPlural = femWord
            mascPlural.removeLast()
            mascPlural += "es"
            femPlural = femWord + "s"
        case .ES:
            stem = word
            stem.removeLast()
            stem.removeLast()
            femWord += "esa"
            mascPlural = femWord
            mascPlural.removeLast()
            mascPlural += "es"
            femPlural = femWord + "s"
        case .IN:
            stem = word
            stem.removeLast()
            stem.removeLast()
            femWord += "ina"
            mascPlural = femWord
            mascPlural.removeLast()
            mascPlural += "es"
            femPlural = femWord + "s"
        case .ON:
            stem = word
            stem.removeLast()
            stem.removeLast()
            femWord += "ona"
            mascPlural = femWord
            mascPlural.removeLast()
            mascPlural += "es"
            femPlural = femWord + "s"
        case .OR:
            stem = word
            stem.removeLast()
            stem.removeLast()
            femWord += "ora"
            mascPlural = femWord
            mascPlural.removeLast()
            mascPlural += "es"
            femPlural = femWord + "s"
        
        case .Unknown:
            femWord = word
            femPlural = femWord + "s"
            mascPlural = word + "s"
        }
    return true
    }
    
    func isAdjective(word: String) -> (Bool, Gender, Number)
    {
        if ( word == self.word ){return (true, .masculine, .singular) }
        if ( word == self.femWord ){return (true, .feminine, .singular)}
        if ( word == self.mascPlural ){return (true, .masculine, .plural)}
        if ( word == self.femPlural ){return (true, .feminine, .plural)}
        return (false, .masculine, .singular)
    }
}

class EnglishAdjective : Adjective {
    
    override init(word: String, def: String, type: AdjectiveType){
        super.init(word: word, def: def, type: type)
    }
    
    func getForm(gender: Gender, number: Number)->String{
        return word
    }
    func getForm()->String{
        return word
    }
    
    func isAdjective(word: String) -> (Bool, Number)
    {
        if ( word == self.word ) {return (true, .singular)}
        return (false, .singular)
    }
}

    
    
