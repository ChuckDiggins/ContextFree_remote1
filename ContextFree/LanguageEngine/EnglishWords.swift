//
//  EnglishVerbs.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

struct EnglishWords {
    
    var englishAdjectiveList = Array<Word>()
    var englishAdverbList = Array<Word>()
    var englishArticleList = Array<Word>()
    var englishConjunctionList = Array<Word>()
    var englishDeterminerList = Array<Word>()
    var englishNounList = Array<Noun>()
    var englishPrepositionList = Array<Word>()
    var englishPronounList = Array<Word>()
    
    var englishVerbList = Array<Word>()
    
    mutating func createEnglishNounAndAppend (word : String, def: String, type : NounType){
        let pos = EnglishNoun(word: word, def: def, type: type )
        englishNounList.append(pos)
    }
    
    mutating func createEnglishArticleAndAppend (word : String, def: String, type : ArticleType){
        let pos = EnglishArticle(word: word, def: def, type: type)
        englishArticleList.append(pos)
    }
    
    mutating func createEnglishAdjectiveAndAppend (word : String, def: String, type : AdjectiveType){
        let pos = EnglishAdjective(word: word, def: def, type: type)
        englishAdjectiveList.append(pos)
    }
    
    mutating func createEnglishDeterminerAndAppend (word : String, def: String, type : DeterminerType, pluralForm: String){
        let pos = EnglishDeterminer(word: word, def: def, type: type, plural: pluralForm)
        englishDeterminerList.append(pos)
    }
    
    mutating func createEnglishVerbAndAppend (word : String, def: String, type : VerbType){
        let pos = EnglishVerb(word: word, def: def, type: type)
        englishVerbList.append(pos)
    }
    
    mutating func createEnglishPrepositionAndAppend (word : String, def: String, type : PrepositionType){
        let pos = EnglishPreposition(word: word, def: def, type: type)
        englishPrepositionList.append(pos)
    }

    mutating func createEnglishPronounAndAppend (word : String, def: String, type : PronounType){
        let pos = EnglishPronoun(word: word, def: def, type: type)
        englishPrepositionList.append(pos)
    }



}
