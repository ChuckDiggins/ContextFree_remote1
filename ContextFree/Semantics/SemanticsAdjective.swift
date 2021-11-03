//
//  SemanticsAdjective.swift
//  SemanticsAdjective
//
//  Created by Charles Diggins on 11/1/21.
//

import Foundation

protocol Semantic {
    var description : String { get }
    var wordType : ContextFreeSymbol { get }
    var wordList : [Word] {get set}
    
    func addWord(word: Word)
    func getWordIndex(word: Word)->Int?
}

class SemanticsAdjective : Semantic {
    var description: String = ""
    var wordType: ContextFreeSymbol
    var wordList =  [Word]()
    init(desc: String, wordType : ContextFreeSymbol, wordList : [Word] ){
        description = desc
        self.wordType = wordType
        self.wordList = wordList
    }
    
    func addWord(word: Word) {
        if getWordIndex(word: word) != nil { wordList.append(word) }
    }
    
    func getWordIndex(word: Word) -> Int? {
        for (index, w) in wordList.enumerated() {
            if w == word {return index}
        }
        return nil
    }
}


