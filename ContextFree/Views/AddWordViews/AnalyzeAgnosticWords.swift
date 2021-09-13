//
//  AnalyzeAgnosticWords.swift
//  AnalyzeAgnosticWords
//
//  Created by Charles Diggins on 9/6/21.
//

import Foundation

struct AnalyzeAgnosticWords {
    var cfModelView : CFModelView
    var spanishPhrase: String
    var frenchPhrase: String
    var englishPhrase: String
    
    
    func appendAgnositicWordToDictionary(){
        cfModelView.appendAgnosticWord(wordType: WordType, spanishWord : spanishPhrase, frenchWord : frenchPhrase, englishWord: englishPhrase)
    }
    
    func analyzeWords(wordType: WordType)->Bool {
        
        let wordOk = cfModelView.analyzeAgnosticWord(wordType: wordType, spanishWord: spanishPhrase, frenchWord: frenchPhrase, englishWord: englishPhrase)

        if wordOk { appendAgnositicWordToDictionary(wordType: wordType, spanishWord: spanishPhrase, frenchWord: frenchPhrase, englishWord: englishPhrase) }
        
        return wordOk
    }
    
    func analyzeVerbs()->(Bool, Bool, Bool) {
        
        var spanishVerb = SpanishVerb()
        var frenchVerb =  FrenchVerb()
        var englishVerb =  EnglishVerb()
        
        let spanishOk = analyzeSpanishVerb()
        let frenchOk = analyzeFrenchVerb()
        let englishOk = analyzeEnglishVerb()
        
        appendAgnositicWordToDictionary()
        
        return (spanishOk, frenchOk, englishOk)
        
        //if all 3 are legit, then save them in the verb dictionary
        
        func analyzeSpanishVerb()->Bool{
            
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .Spanish, verbPhrase: spanishPhrase)
            if result.0 {
                let verb = result.1  //BVerb
                let bSpanishVerb = verb as! BSpanishVerb
                spanishVerb = SpanishVerb(word: bSpanishVerb.m_verbWord, def: "", type: VerbType.normal)
                spanishVerb.setBVerb(bVerb: bSpanishVerb)
                return true
            }
            return false
        }
        
        func analyzeFrenchVerb()->Bool{
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .French, verbPhrase: frenchPhrase)
            if result.0 {
                let verb = result.1  //BVerb
                let bFrenchVerb = verb as! BFrenchVerb
                frenchVerb = FrenchVerb(word: bFrenchVerb.m_verbWord, def: "", type: VerbType.normal)
                frenchVerb.setBVerb(bVerb: bFrenchVerb)
                return true
            }
            return false
        }
        
        func analyzeEnglishVerb()->Bool{
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .English, verbPhrase: englishPhrase)
            if result.0 {
                let verb = result.1  //BVerb
                let bEnglishVerb = verb as! BEnglishVerb
                englishVerb = EnglishVerb(word: bEnglishVerb.m_verbWord, def: "", type: VerbType.normal)
                englishVerb.setBVerb(bVerb: bEnglishVerb)
                return true
            }
            return false
        }
        
        
    }
    
    
    
    
    
    
    
}



