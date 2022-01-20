//
//  Word.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/5/21.
//

import Foundation

class Word : Hashable, Equatable {
    let word : String
    //let def : String
    let wordType : WordType
    
    var english = ""
    var spanish = ""
    var french = ""
    
    init(word: String, spanish: String, french: String, english: String, wordType: WordType){
        self.word = word
        self.wordType = wordType
        self.english = english
        self.spanish = spanish
        self.french = french
    }
    
    init(word: String, wordType: WordType){
        self.word = word
        self.wordType = wordType
        self.english = ""
        self.spanish = ""
        self.french = ""
    }
    
    init(){
        self.word = ""
        self.wordType = .unknown
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(word)
    }
    
    static func ==(lhs: Word, rhs: Word)->Bool{
        return lhs.spanish == rhs.spanish && lhs.french == rhs.french && lhs.english == rhs.english && lhs.wordType == rhs.wordType
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
    
    func getFirstWordStringAtLanguage(language: LanguageType)->String{
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
