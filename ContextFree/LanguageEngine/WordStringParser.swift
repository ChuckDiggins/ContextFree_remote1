//
//  WordStringParser.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/8/21.
//

import Foundation

struct WordStringParser {
    var spanishWords = SpanishWords()
    var englishWords = EnglishWords()
    
    init(){
        spanishWords.createSomeSpanishArticles()
        spanishWords.createSomeSpanishAdjectives()
        spanishWords.createSomeSpanishNouns()
        spanishWords.createSomeSpanishVerbs()
        spanishWords.createSomeSpanishPrepositions()
        spanishWords.createSomeSpanishConjunctions()
        spanishWords.createSomeSpanishAdverbs()
        spanishWords.createSomeSpanishPronouns()
    }
    
    mutating func handleContractions(language : LanguageType, wordList: [String])->[String]{
        let sw = SpanishWords()
        var wordListCopy = wordList

        var contractionFound  = true
        while contractionFound {
            for (i, word) in wordListCopy.enumerated() {
                let result = sw.isContraction(word: word)
                //if is contraction, then remove it and replace it
                if result.0 {
                    wordListCopy.remove(at: i)
                    wordListCopy.insert(result.2, at:i)
                    wordListCopy.insert(result.1, at:i)
                    contractionFound = true
                    break
                }
                contractionFound = false
            }
        }
        return wordListCopy
    }
    
    //find one or more instances of the multi-word prepString in the wordList.  Replace them with a single multi-word string
    
    mutating func handleCompoundExpression(language : LanguageType, wordList: [String], inputWordList: [String])->(Bool, [String]){
        var startIndex = 0
        var wordIndex = 1
        var i = 0
        var wordListCopy = wordList
        var inputString = ""
        var compoundStringFound = false
        
        while  wordIndex > 0 {
            wordIndex = Utilities().doesStringContainSubstring(inputStringList: wordListCopy, subStringList: inputWordList, startIndex : startIndex)
            //if prepList found, remove it from the input wordListCopy and replace it with a single prepString string
            if ( wordIndex > 0 ){
                
                while i < inputWordList.count {
                    inputString += inputWordList[i] + " "
                    wordListCopy.remove(at:wordIndex)
                    i += 1
                }
                inputString = Utilities().removeLeadingOrFollowingBlanks(characterArray: inputString)
                wordListCopy.insert(inputString, at: wordIndex)
                i=0
                inputString = ""
                compoundStringFound = true
            }
            startIndex = wordIndex + inputString.count  //jump startIndex past this "find" and look for another
        }
        if compoundStringFound { return (true, wordListCopy)}
        return (false, wordListCopy)
    }
    
    func getPunctuation(wordString: String)->SentenceData{
        var sd = SentenceData()
        let word = Punctuation(word: wordString, def: "", type : .period)
        let punct = word.isPunctuation(word: wordString)
        if punct != .none {
            sd.word = word
            sd.data.wordType = .punctuation
            sd.data.punctuationType = punct
        }
        return sd
    }
    
    //need to check for ambiguity
    
    func getPronoun(wordString: String)->SentenceData{
        var sd = SentenceData()
        let word = SpanishPronoun(word: wordString, def: "", type : .SUBJECT)
        var result = word.isSubjectPronoun(word: wordString)
        if result.0 == .SUBJECT {
            sd.word = word
            sd.data.wordType = .pronoun
            sd.data.pronounType = .SUBJECT
            return sd
        }
        result = word.isReflexivePronoun(word: wordString)
        if result.0 == .REFLEXIVE {
            sd.word = word
            sd.data.wordType = .pronoun
            sd.data.pronounType = .REFLEXIVE
            return sd
        }
        result = word.isIndirectObjectPronoun(word: wordString)
        if result.0 == .INDIRECT_OBJECT {
            sd.word = word
            sd.data.wordType = .pronoun
            sd.data.pronounType = .INDIRECT_OBJECT
            return sd
        }
        result = word.isDirectObjectPronoun(word: wordString)
        if result.0 == .OBJECT {
            sd.word = word
            sd.data.wordType = .pronoun
            sd.data.pronounType = .OBJECT
            return sd
        }
        result = word.isPrepositionalPronoun(word: wordString)
        if result.0 == .PREPOSITIONAL {
            sd.word = word
            sd.data.wordType = .pronoun
            sd.data.pronounType = .PREPOSITIONAL
            return sd
        }
        return sd
    }
    
    func getAdjective(language : LanguageType, wordString: String)->SentenceData{
        var sd = SentenceData()
        switch language {
        case .Spanish:
            for word in spanishWords.spanishAdjectiveList {
                let adjective = word as! SpanishAdjective
                let result = adjective.isAdjective(word: wordString)
                if ( result.0 ) {
                    sd.word = word
                    sd.data.wordType = .adjective
                    sd.data.gender = result.1
                    sd.data.number = result.2
                    return sd
                }
            }
        case .English:
            for word in englishWords.englishAdjectiveList {
                let adjective = word as! EnglishAdjective
                let result = adjective.isAdjective(word: wordString)
                if ( result.0 ) {
                    sd.word = word
                    sd.data.wordType = .adjective
                    sd.data.number = result.1
                    return sd
                }
                
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
    }
    
    mutating func getNoun(language:LanguageType, wordString:String)->SentenceData{
        
        var sd = SentenceData()
        switch language {
        case .Spanish:
            for word in spanishWords.spanishNounList {
                let noun = word as! RomanceNoun
                let result = noun.isNoun(word: wordString)
                if result.0 {
                    sd.word = word
                    sd.data.wordType = .noun
                    sd.data.nounType = result.1
                    sd.data.number = result.2
                    sd.data.gender = result.3
                    return sd
                }
                
            }
        case .English:
            for word in englishWords.englishNounList {
                let noun = word as! EnglishNoun
                let result = noun.isNoun(word: wordString)
                if result.0 {
                    sd.word = word
                    sd.data.wordType = .noun
                    sd.data.nounType = result.1
                    sd.data.number = result.2
                    return sd
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
    }
    
    mutating func getConjunction(language:LanguageType, wordString:String)->SentenceData{
        
        var sd = SentenceData()
        switch language {
        case .Spanish:
            for word in spanishWords.spanishConjunctionList {
                if wordString == word.word {
                    let conj = word as! SpanishConjunction
                    let result = conj.isConjunction(word: wordString)
                    if result {
                        sd.word = word
                        sd.data.wordType = .conjunction
                        return sd
                    }
                }
            }
        case .English:
            for word in englishWords.englishConjunctionList {
                if wordString == word.word {
                    let prep = word as! EnglishConjunction
                    let result = prep.isConjunction(word: wordString)
                    if result {
                        sd.word = word
                        sd.data.wordType = .conjunction
                        return sd
                    }
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
    }

    
    mutating func getPreposition(language:LanguageType, wordString:String)->SentenceData{
        
        var sd = SentenceData()
        switch language {
        case .Spanish:
            for word in spanishWords.spanishPrepositionList {
                if wordString == word.word {
                    let prep = word as! RomancePreposition
                    let result = prep.isPreposition(word: wordString)
                    if result {
                        sd.word = word
                        sd.data.wordType = .preposition
                        return sd
                    }
                }
            }
        case .English:
            for word in englishWords.englishPrepositionList {
                if wordString == word.word {
                    let prep = word as! EnglishPreposition
                    let result = prep.isPreposition(word: wordString)
                    if result {
                        sd.word = word
                        sd.data.wordType = .preposition
                        return sd
                    }
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
    }

    
    func getVerb(language : LanguageType, wordString: String)->SentenceData{
    var sd = SentenceData()
    
    switch language {
        case .Spanish:
            for word in spanishWords.spanishVerbList {
                if wordString == word.word {
                    sd.word = word
                    sd.data.wordType = .verb
                    sd.data.tense = .infinitive
                    return sd
                }
                else {
                    let verb = word as! RomanceVerb
                    
                    let result = verb.isConjugateForm(word: wordString)
                    
                    if ( result.0 ){
                        sd.word = word
                        sd.data.wordType = .verb
                        sd.data.tense = result.1
                        sd.data.person = result.2
                        return sd
                    }
                }
            }
        case .English:
            for word in englishWords.englishVerbList {
                let verb = word as! EnglishVerb
                let result = verb.isConjugateForm(word: wordString)
                if ( result.0 ){
                    sd.word = word
                    sd.data.wordType = .verb
                    sd.data.tense = result.1
                    sd.data.person = result.2
                    return sd
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
    }
    
    func getArticle(language : LanguageType, wordString: String)->SentenceData{
        var sd = SentenceData()
        
        switch language {
        case .Spanish:
            for word in spanishWords.spanishArticleList {
                let article = word as! RomanceArticle
                let result = article.isArticle(word: wordString)
                if result.0 {
                    sd.word = word
                    sd.data.wordType = .article
                    sd.data.articleType = result.1
                    sd.data.gender = result.2
                    sd.data.number = result.3
                    return sd
                }
            }
        case .English:
            for word in englishWords.englishArticleList {
                let article = word as! EnglishArticle
                let result = article.isArticle(word: wordString)
                if result.0 {
                    sd.word = word
                    sd.data.wordType = .article
                    sd.data.articleType = result.1
                    sd.data.number = result.2
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
        
    }


    func getPronoun(language : LanguageType, wordString: String)->SentenceData{
        var sd = SentenceData()
        
        switch language {
        case .Spanish:
            for word in spanishWords.spanishPronounList {
                let pronoun = word as! SpanishPronoun
                var result = pronoun.isSubjectPronoun(word: wordString)
                if result.0 != .none {
                    sd.word = word
                    sd.data.wordType = .pronoun
                    sd.data.pronounType = result.0
                    sd.data.gender = result.1
                    sd.data.person = result.2
                    return sd
                }
                result = pronoun.isReflexivePronoun(word: wordString)
                if result.0 != .none {
                    sd.word = word
                    sd.data.wordType = .pronoun
                    sd.data.pronounType = result.0
                    sd.data.gender = result.1
                    sd.data.person = result.2
                    return sd
                }
                result = pronoun.isIndirectObjectPronoun(word: wordString)
                if result.0 != .none {
                    sd.word = word
                    sd.data.wordType = .pronoun
                    sd.data.pronounType = result.0
                    sd.data.gender = result.1
                    sd.data.person = result.2
                    return sd
                }
                result = pronoun.isDirectObjectPronoun(word: wordString)
                if result.0 != .none {
                    sd.word = word
                    sd.data.wordType = .pronoun
                    sd.data.pronounType = result.0
                    sd.data.gender = result.1
                    sd.data.person = result.2
                    return sd
                }
                result = pronoun.isPrepositionalPronoun(word: wordString)
                if result.0 != .none {
                    sd.word = word
                    sd.data.wordType = .pronoun
                    sd.data.pronounType = result.0
                    sd.data.gender = result.1
                    sd.data.person = result.2
                    return sd
                }
            }
        case .English:
            for word in englishWords.englishPronounList {
                let pronoun = word as! EnglishPronoun
                let result = pronoun.isSubjectPronoun(word: wordString)
                if result.0 != .none {
                    sd.word = word
                    sd.data.wordType = .pronoun
                    sd.data.pronounType = result.0
                    sd.data.gender = result.1
                    sd.data.person = result.2
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
        
    }

    func getDeterminer(language : LanguageType, wordString: String)->SentenceData{
        var sd = SentenceData()
        switch language {
        case .Spanish:
            for word in spanishWords.spanishDeterminerList {
                let determiner = word as! RomanceDeterminer
                let result = determiner.isDeterminer(word: wordString)
                if result.0 {
                    sd.word = word
                    sd.data.wordType = .determiner
                    sd.data.determinerType = result.1
                    sd.data.gender = result.2
                    sd.data.number = result.3
                    return sd
                }
            }
        case .English:
            for word in englishWords.englishDeterminerList {
                let determiner = word as! EnglishDeterminer
                let result = determiner.isDeterminer(word: wordString)
                if result.0 {
                    sd.word = word
                    sd.data.wordType = .determiner
                    sd.data.determinerType = result.1
                    sd.data.number = result.2
                    return sd
                }
            }
        case .French,.Italian,.Portuguese:
            return sd
        }
        return sd
    }
    
 

}
