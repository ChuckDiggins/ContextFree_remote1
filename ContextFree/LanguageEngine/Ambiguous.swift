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
    
    init(word: String, def: String, type : AmbiguousType){
        self.type =  type
        super.init(word: word, def: def, wordType: .ambiguous)
    }
    
    func append(word: Word){
        wordList.append(word)
    }
    
    func getList()->Array<Word>{
        return wordList
    }
    
}
