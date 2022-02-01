//
//  Punctuation.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/9/21.
//

import Foundation

public class Punctuation : Word {

    var type: PunctuationType
    
    public init(word: String, def: String, type : PunctuationType){
        self.type = type
        super.init(word: word, wordType: .punctuation)
    }
    
    public func isPunctuation(word: String)->PunctuationType {
        if word == "." { return .period}
        if word == "," { return .comma}
        if word == "?" { return .questionMark}
        if word == "¿" { return .upsideDownQuestionMark}
        if word == "!" { return .exclamation}
        if word == "¡" { return .upsideDownExclamation}
        if word == ":" { return .colon}
        if word == ";" { return .semicolon}
        if word == "\'" { return .singleQuote}
        if word == "\"" { return .doubleQuote}
        return .none
    }
    
    
    public func get(type: PunctuationType)-> String{
        switch type{
        case .period:
            return "."
        case .questionMark:
            return "?"
        case .upsideDownQuestionMark:
            return "¿"
        case .exclamation:
            return "!"
        case .upsideDownExclamation:
            return "¡"
        case .comma:
            return ","
        case .colon:
            return ":"
        case .semicolon:
            return ";"
        case .singleQuote:
            return "\'"
        case .doubleQuote:
            return "\""
        case .none:
            return ""
        }
    }
}

