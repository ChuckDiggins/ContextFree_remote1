//
//  AnalyzeAgnosticWords.swift
//  AnalyzeAgnosticWords
//
//  Created by Charles Diggins on 9/6/21.
//

import Foundation

struct AnalyzeAgnosticWords {
    var cfModelView : CFModelView
    
/*
    func appendAgnositicWordToDictionary(wordType: WordType, spanishWord : String, frenchWord : String, englishWord: String){
        cfModelView.appendAgnosticWord(wordType: wordType, spanishWord : spanishWord, frenchWord : frenchWord, englishWord: englishWord)
    }
    
    func analyzeWords(wordType: WordType, spanishWord : String, frenchWord : String, englishWord: String)->Bool {
        
        let wordOk = cfModelView.analyzeAgnosticWord(wordType: wordType, spanishWord: spanishWord, frenchWord: frenchWord, englishWord: englishWord)

        if wordOk { appendAgnositicWordToDictionary(wordType: wordType, spanishWord: spanishWord, frenchWord: frenchWord, englishWord: englishWord) }
        
        return wordOk
    }
  */
    
    func analyzeVerbs(wordType: WordType, spVerbString: String, frVerbString: String, engVerbString: String)->(Bool, Bool, Bool) {
        
        var spanishVerbString = spVerbString
        var frenchVerbString =  frVerbString
        var englishVerbString =  engVerbString
        
        let spanishOk = analyzeSpanishVerb()
        let frenchOk = analyzeFrenchVerb()
        let englishOk = analyzeEnglishVerb()
        
        //appendAgnositicWordToDictionary(wordType: wordType, spanishWord: spanishVerbString, frenchWord: frenchVerbString, englishWord: englishVerbString)
        
        return (spanishOk, frenchOk, englishOk)
        
        //if all 3 are legit, then save them in the verb dictionary
        
        func analyzeSpanishVerb()->Bool{
            
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .Spanish, verbPhrase: spanishVerbString)
            if result.0 {
                let verb = result.1  //BVerb
                let bSpanishVerb = verb as! BSpanishVerb
                var spanishVerb = SpanishVerb(word: bSpanishVerb.m_verbWord, def: "", type: VerbType.normal)
                spanishVerb.setBVerb(bVerb: bSpanishVerb)
                return true
            }
            return false
        }
        
        func analyzeFrenchVerb()->Bool{
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .French, verbPhrase: frenchVerbString)
            if result.0 {
                let verb = result.1  //BVerb
                let bFrenchVerb = verb as! BFrenchVerb
                var frenchVerb = FrenchVerb(word: bFrenchVerb.m_verbWord, def: "", type: VerbType.normal)
                frenchVerb.setBVerb(bVerb: bFrenchVerb)
                return true
            }
            return false
        }
        
        func analyzeEnglishVerb()->Bool{
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .English, verbPhrase: englishVerbString)
            if result.0 {
                let verb = result.1  //BVerb
                let bEnglishVerb = verb as! BEnglishVerb
                var englishVerb = EnglishVerb(word: bEnglishVerb.m_verbWord, def: "", type: VerbType.normal)
                englishVerb.setBVerb(bVerb: bEnglishVerb)
                return true
            }
            return false
        }
        
        
    }

    
}



