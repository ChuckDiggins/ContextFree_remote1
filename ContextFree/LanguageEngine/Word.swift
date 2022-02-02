//
//  Word.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/5/21.
//

import Foundation
import JumpLinguaHelpers

public class Word : Hashable, Equatable {
    let word : String
    //let def : String
    let wordType : WordType
    
    var english = ""
    var spanish = ""
    var french = ""
    
    public init(word: String, spanish: String, french: String, english: String, wordType: WordType){
        self.word = word
        self.wordType = wordType
        self.english = english
        self.spanish = spanish
        self.french = french
    }
    
    public init(word: String, wordType: WordType){
        self.word = word
        self.wordType = wordType
        self.english = ""
        self.spanish = ""
        self.french = ""
    }
    
    public init(){
        self.word = ""
        self.wordType = .unknown
    }
    
    public func hash(into hasher: inout Hasher){
        hasher.combine(word)
    }
    
    public static func ==(lhs: Word, rhs: Word)->Bool{
        return lhs.spanish == rhs.spanish && lhs.french == rhs.french && lhs.english == rhs.english && lhs.wordType == rhs.wordType
    }
    
    public func getWordType()->WordType{
        return wordType
    }
    
    public func getWordTypeString()->String{
        return wordType.rawValue
    }
    
    public func isUnknown()->Bool{
        if wordType == .unknown{return true}
        return false
    }
    
    public func getWordStringAtLanguage(language: LanguageType)->String{
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
    
    public func getFirstWordStringAtLanguage(language: LanguageType)->String{
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
