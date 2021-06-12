//
//  WordStateData.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/5/21.
//

import Foundation

class WordStateData : Hashable, Equatable {
    var title: String = ""
    func hash(into hasher: inout Hasher){
        hasher.combine(title)
    }
    
    var word = Word()
    var processedWord = ""  //this will show the current state of this word
    
    //states
    var language = LanguageType.Spanish
    var tense = Tense.infinitive
    var person = Person.S1
    var number = Number.singular
    var gender = Gender.masculine
    
    //identity
    var wordType = WordType.unknown
    var ambiguousType = AmbiguousType.general
    var adverbType = AdverbType.when
    var articleType = ArticleType.definite
    var conjunctionType = ConjunctionType.coordinating
    var determinerType = DeterminerType.definite
    var adjectiveType = AdjectiveType.any
    var adjectivePosition = AdjectivePositionType.following
    var prepositionType = PrepositionType.general
    var pronounType = PronounType.none
    var punctuationType = PunctuationType.none
    
    var nounType = NounType.any
    var nounSubjectivity = NounSubjectivity.either
    
    var verbModality = VerbModality.notModal
    var verbPassivity = VerbPassivity.active
    var verbPronominality = VerbPronomality.notPronominal
    var verbPreference = VerbPreference.any
    var verbTransitivity = VerbTransitivity.transitive
    var verbType = VerbType.normal
    var bescherelleInfo = ""
    
    static func == (lhs: WordStateData, rhs: WordStateData) -> Bool {
        return lhs.word.word == rhs.word.word
    }
    
    func getWordType()->WordType{
        return wordType
    }
    
    func getWordTypeString()->String{
        return wordType.rawValue
    }
    
   func setProcessedWord(str: String){
        processedWord = str
    }
    
    func getProcessedWord()->String{
        return processedWord
    }

}
