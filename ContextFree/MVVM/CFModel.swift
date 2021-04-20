//
//  CFDriver.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

//this is where every little thing is constructed

struct CFModel{
        
    var spanishWords = SpanishWords()
    var englishWords = EnglishWords()
    var grammarLibrary = CFGrammarLibrary()
    
    private var m_verbStringList: [String] = []
    private var m_masterVerbList: [BVerb] = []
    
    init(){
        buildSomeStuff()
    }
    
    mutating func buildSomeStuff(){
    
        let wordList = Utilities().getListOfWords(characterArray: "ls sddd a principios  de dddddd  a principios    de fff    fffff ddd")
        let prepList = Utilities().getListOfWords(characterArray: "a principios de")
        var startIndex = 0
        var wordIndex = 1
        while  wordIndex > 0 {
            wordIndex = Utilities().doesStringContainSubstring(inputStringList: wordList, subStringList: prepList, startIndex : startIndex)
            
            if ( wordIndex > 0 ){
                print("substring found at index \(wordIndex)")
            }
            
            startIndex = wordIndex + prepList.count  //jump startIndex past this "find" and look for another
        }
        
        //var sentence = createSentence(sentenceString : "nosotros al libros, conmigo por delante del casa" )
        //sentence.setCFModel(cfModel: self)
        
        //print("reconstructed sentence = \(sentence.getReconstructedSentenceString())")

        /*
        var sentence1 = createSentence(sentenceString : "el grande perro juega" )
        print("reconstructed sentence1 = \(sentence1.getReconstructedSentenceString())")
        var sentence2 = createSentence(sentenceString : "el libro azul está en la casa" )
        print("reconstructed sentence2 = \(sentence2.getReconstructedSentenceString())")
        var sentence3 = createSentence(sentenceString : "la mujer negra jugamos en la casa" )
        print("reconstructed sentence3 = \(sentence3.getReconstructedSentenceString())")
        print("reconstructed sentence1 = \(sentence1.getReconstructedSentenceString())")//
        
        var sentence4 = createSentence(sentenceString : "los libros azules están en la casa negra" )
        print("reconstructed sentence4 = \(sentence4.getReconstructedSentenceString())")
*/
        var cfgc = ContextFreeGrammarConstruction()
        grammarLibrary.nounPhraseGrammar = cfgc.createSomeNounPhraseGrammar()
        grammarLibrary.verbPhraseGrammar = cfgc.createSomeVerbPhraseGrammar()
        grammarLibrary.prepositionalPhraseGrammar = cfgc.createSomePrepositionalPhraseGrammar()
        grammarLibrary.adjectivePhraseGrammar = cfgc.createSomeAdjectivePhraseGrammar()

    }
    
    func getGrammarLibrary()->CFGrammarLibrary{
        return grammarLibrary
    }
    
    
       
    mutating func createIndependentClause(clauseString: String)->dIndependentClause{
        //convert sentence string into array of word strings
        
        var wordList = Utilities().getListOfWordsIncludingPunctuation(characterArray: clauseString)
        //find and decompose contractions
        
        var wsp = WordStringParser()

        wordList = wsp.handleContractions(language: .Spanish, wordList: wordList)

        //search for and compress compound prepositions
        
        for word in wsp.spanishWords.spanishPrepositionList {
            let prepList = Utilities().getListOfWords(characterArray: word.word)
            if prepList.count > 1 {
                //print("createSentence - prep: \(word.word)")
                let result = wsp.handleCompoundExpression(language: .Spanish, wordList: wordList, inputWordList: prepList)
                if result.0 {
                    wordList = result.1
                }
            }
        }
        
        //search for and compress compound prepositions
        
        for word in wsp.spanishWords.spanishConjunctionList {
            let list = Utilities().getListOfWords(characterArray: word.word)
            if list.count > 1 {
                //print("createSentence - prep: \(word.word)")
                let result = wsp.handleCompoundExpression(language: .Spanish, wordList: wordList, inputWordList: list)
                if result.0 {
                    wordList = result.1
                }
            }
        }
        
        print("after handleCompoundExpressions - word string \(wordList)")
        
        //convert the word strings into array of Words
        let wo = getWordDataForSentence(language: .Spanish, wordList : wordList)
        
        return  dIndependentClause(sentenceString: clauseString, data: wo)
    }
    
    //mutating func parseWordListIntoWordObjects(wordList: Array<String>)->Array<Word>{
    //    return getWordObjects(language: .Spanish, wordList: wordList)
    //}
    
    mutating func getWordDataForSentence(language:LanguageType, wordList: Array<String>)->Array<SentenceData>{
        var sentenceData = Array<SentenceData>()
        var wsParser = WordStringParser()
        for wordString in wordList {
            var wordData = SentenceData()
            wordData = wsParser.getNoun(language: language, wordString: wordString)
            if wordData.data.wordType == .unknown { wordData = wsParser.getPronoun(language: language, wordString: wordString) }
            if wordData.data.wordType == .unknown { wordData = wsParser.getPunctuation(wordString: wordString) }
            if wordData.data.wordType == .unknown { wordData = wsParser.getArticle(language: language, wordString: wordString) }
            if wordData.data.wordType == .unknown { wordData = wsParser.getAdjective(language: language, wordString: wordString)}
            if wordData.data.wordType == .unknown { wordData = wsParser.getDeterminer(language: language, wordString: wordString)}
            if wordData.data.wordType == .unknown {  wordData = wsParser.getConjunction(language: language, wordString: wordString)  }
            if wordData.data.wordType == .unknown { wordData = wsParser.getPreposition(language: language, wordString: wordString)  }
            if wordData.data.wordType == .unknown {   wordData = wsParser.getVerb(language: language, wordString: wordString)}
            
            //print("getWordDataForSentence - wordString \(wordString) - Word \(wordData.word.word) - wordType: \(wordData.word.getWordTypeString())")
            
            //append word here, even if it is unknown
            sentenceData.append(wordData)
        }
        return sentenceData
    }
    
    
    
    
        


}
