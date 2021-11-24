//
//  SpanishWords.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation


struct SpanishWords {
    
    var adjectiveList = Array<Word>()
    var adverbList = Array<Word>()
    //var articleList = Array<Word>()
    var conjunctionList = Array<Word>()
    var determinerList = Array<Word>()
    var nounList = Array<Noun>()
    var prepositionList = Array<Word>()
    var verbList = Array<Word>()
    var pronounList = Array<Word>()
    var ambiguousList = Array<Word>()
    
    
    
    func isContraction(word: String)->(Bool, String, String){
        if word == "al" {return (true, "a", "el")}
        if word == "del" {return (true, "de", "el")}
        if word == "conmigo" {return (true, "con", "mí")}
        if word == "contigo" {return (true, "con", "tú")}
        if word == "consigo" {return (true, "con", "él")}
        return (false, "", "")
    }
    
    func createContraction(word1: String, word2: String)->String{
        if word1 == "a" && word2 == "el" {return "al"}
        if word1 == "de" && word2 == "el" {return "del"}
        if word1 == "con" && word2 == "mí" {return "conmigo"}
        if word1 == "con" && word2 == "tú" {return "contigo"}
        if word1 == "con" && word2 == "él" {return "consigo"}
        if word1 == "con" && word2 == "ella" {return "consigo"}
        if word1 == "con" && word2 == "ellos" {return "consigo"}
        if word1 == "con" && word2 == "ellas" {return "consigo"}
        return ""
    }
    
   
}
