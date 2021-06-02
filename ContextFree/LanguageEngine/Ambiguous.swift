//
//  Ambiguous.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/9/21.
//

import Foundation

class Ambiguous : Word {

    var type: AmbiguousType
    
    var wordList = Array<Word>()
    var pronounList = Array<PronounType>()
    
    init(word: String, def: String, type : AmbiguousType){
        self.type =  type
        super.init(word: word, def: def, wordType: .ambiguous)
    }
    
    func setAmbiguousType(type: AmbiguousType){
        self.type = type
    }
    
    func append(word: Word){
        wordList.append(word)
    }
    
    func setPronounList(list: Array<PronounType>){
        pronounList = list
    }
    
    //this ambiguity should be between subject and prepositional pronoun in Spanish
    // in French this can be more involved with "nous", for example
    
    func isPossibleSubjectPronoun()->Bool{
        for pt in pronounList {
            if pt == .SUBJECT {return true}
        }
        return false
    }
    
    func isPossiblePrepositionalPronoun()->Bool{
        for pt in pronounList {
            if pt == .PREPOSITIONAL {return true}
        }
        return false
    }
   
    
    func isPossibleArticle()->Bool{
        for word in wordList {
            if word.wordType == .article {return true}
        }
        return false
    }
    
    func getList()->Array<Word>{
        return wordList
    }
    
}
