//
//  Ambiguous.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/9/21.
//

import Foundation

public class Ambiguous : Word {

    var type: AmbiguousType
    
    var wordList = Array<Word>()
    var pronounList = Array<PronounType>()
    
    public init(word: String,type : AmbiguousType){
        self.type =  type
        super.init(word: word, wordType: .ambiguous)
    }
    
    public func setAmbiguousType(type: AmbiguousType){
        self.type = type
    }
    
    public func append(word: Word){
        wordList.append(word)
    }
    
    public func setPronounList(list: Array<PronounType>){
        pronounList = list
    }
    
    //this ambiguity should be between subject and prepositional pronoun in Spanish
    // in French this can be more involved with "nous", for example
    
    public func isPossibleSubjectPronoun()->Bool{
        for pt in pronounList {
            if pt == .SUBJECT {return true}
        }
        return false
    }
    
    public func isPossiblePrepositionalPronoun()->Bool{
        for pt in pronounList {
            if pt == .PREPOSITIONAL {return true}
        }
        return false
    }
   
    
    public func isPossibleArticle()->Bool{
        for word in wordList {
            if word.wordType == .article {return true}
        }
        return false
    }
    
    public func getList()->Array<Word>{
        return wordList
    }
    
}
