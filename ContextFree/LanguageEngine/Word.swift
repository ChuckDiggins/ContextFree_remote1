//
//  Word.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/5/21.
//

import Foundation

class Word : Hashable, Equatable {
    let word : String
    let def : String
    let wordType : WordType
    
    var english = ""
    var spanish = ""
    var french = ""
    
    init(word: String, def: String, wordType: WordType){
        self.word = word
        self.def = def
        self.wordType = wordType
        self.english = ""
        self.spanish = ""
        self.french = ""
    }
    
    init(){
        self.word = ""
        self.def = ""
        self.wordType = .unknown
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(word)
    }
    
    static func ==(lhs: Word, rhs: Word)->Bool{
        return lhs.word == rhs.word
    }
    
    func getWordType()->WordType{
        return wordType
    }
    
    func getWordTypeString()->String{
        return wordType.rawValue
    }
    
    func isUnknown()->Bool{
        if wordType == .unknown{return true}
        return false
    }
    
    func getWordStringAtLanguage(language: LanguageType)->String{
        switch language{
        case .Spanish:
            return spanish
        case .French:
            return french
        case .English:
            return english
        default: return ""
        }
    }
    
}
