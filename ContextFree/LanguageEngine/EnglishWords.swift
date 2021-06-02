//
//  EnglishVerbs.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

struct EnglishWords {
    
    var adjectiveList = Array<Word>()
    var adverbList = Array<Word>()
    var articleList = Array<Word>()
    var conjunctionList = Array<Word>()
    var determinerList = Array<Word>()
    var nounList = Array<Noun>()
    var prepositionList = Array<Word>()
    var pronounList = Array<Word>()
    var verbList = Array<Word>()
    
    mutating func createSomeArticles(){
        createArticleAndAppend(word: "the", def: "the", type: .definite)
        createArticleAndAppend(word: "a", def: "a", type: .indefinite)
        createArticleAndAppend(word: "some", def: "some", type: .indefinite)
    }
    
    mutating func createSomePronouns(){
        createPronounAndAppend(word: "I", def: "I", type: .SUBJECT)
        createPronounAndAppend(word: "me", def: "me", type: .PREPOSITIONAL)
        createPronounAndAppend(word: "me", def: "me", type: .DIRECT_OBJECT)
    }
    
    mutating func createNounAndAppend (word : String, def: String, type : NounType){
        let pos = EnglishNoun(word: word, def: def, type: type )
        nounList.append(pos)
    }
    
    mutating func createArticleAndAppend (word : String, def: String, type : ArticleType){
        let pos = EnglishArticle(word: word, def: def, type: type)
        articleList.append(pos)
    }
    
    mutating func createAdjectiveAndAppend (word : String, def: String, type : AdjectiveType){
        let pos = EnglishAdjective(word: word, def: def, type: type)
        adjectiveList.append(pos)
    }
    
    mutating func createDeterminerAndAppend (word : String, def: String, type : DeterminerType, pluralForm: String){
        let pos = EnglishDeterminer(word: word, def: def, type: type, plural: pluralForm)
        determinerList.append(pos)
    }
    
    mutating func createVerbAndAppend (word : String, def: String, type : VerbType){
        let pos = EnglishVerb(word: word, def: def, type: type)
        verbList.append(pos)
    }
    
    mutating func createPrepositionAndAppend (word : String, def: String, type : PrepositionType){
        let pos = EnglishPreposition(word: word, def: def, type: type)
        prepositionList.append(pos)
    }

    mutating func createPronounAndAppend (word : String, def: String, type : PronounType){
        let pos = EnglishPronoun(word: word, def: def, type: type)
        prepositionList.append(pos)
    }



}
