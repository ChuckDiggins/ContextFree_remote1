//
//  WordSurgery.swift
//  WordSurgery
//
//  Created by Charles Diggins on 11/19/21.
//

import SwiftUI

struct WordSurgery: View {
    var body: some View {
        Text("Word surgery goes here")
    }
    
}

func wordSurgery(single: dSingle){
//        let wsd = single.getSentenceData()
//        surgicalMessage = "Click on another word to examine"
//        surgicalWord =         "\(wsd.wordType.rawValue): \(wsd.word.word)"
//        switch wsd.wordType {
//        case .N:
//            surgicalTitle = "Noun"
//            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
//            surgicalEnglish = "English: \("")"
//            surgicalLine1 = "Noun type: \(wsd.nounType.rawValue)"
//            surgicalLine2 = "Gender:    \(wsd.gender.rawValue)"
//            surgicalLine3 = "Number:    \(wsd.number.rawValue)"
//            surgicalLine4 = ""
//            surgicalLine5 = ""
//            surgicalLine6 = ""
//        case .Adj:
//            surgicalTitle = "Adjective"
//            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
//            surgicalEnglish = "English: \("")"
//            surgicalLine1 = "Adjective type: \(wsd.adjectiveType.rawValue)"
//            surgicalLine2 = "Gender:         \(wsd.gender.rawValue)"
//            surgicalLine3 = "Number:         \(wsd.number.rawValue)"
//            surgicalLine4 = ""
//            surgicalLine5 = ""
//            surgicalLine6 = ""
//        case .Det:
//            surgicalTitle = "Determiner"
//            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
//            surgicalEnglish = "English: \("")"
//            surgicalLine1 = "Determiner type: \(wsd.determinerType.rawValue)"
//            surgicalLine2 = "Gender:       \(wsd.gender.rawValue)"
//            surgicalLine3 = "Number:       \(wsd.number.rawValue)"
//            surgicalLine4 = ""
//            surgicalLine5 = ""
//            surgicalLine6 = ""
//        case .V:
//            surgicalTitle = "Verb"
//            surgicalProcessedWord = "Conjugated: \(wsd.getProcessedWord())"
//
//            let verb = wsd.word as! Verb
//            surgicalSpanish = "Spanish: \(verb.spanish)"
//            surgicalFrench = "French: \(verb.french)"
//            surgicalEnglish = "English: \(verb.english)"
//            surgicalLine2 = "Tense:      \(currentTense.rawValue)"
//            surgicalLine3 = "Person:     \(currentPerson.getEnumString())"
//
//            surgicalLine5 = ""
//            surgicalLine6 = ""
//        case .P:
//            surgicalTitle = "Preposition"
//            surgicalEnglish = "English: \("")"
//            surgicalLine1 = "Preposition type: \(wsd.prepositionType.rawValue)"
//            surgicalLine2 = ""
//            surgicalLine3 = ""
//            surgicalLine4 = ""
//            surgicalLine5 = ""
//            surgicalLine6 = ""
//        default: break
//        }
//
}

func clearWordSurgery(){
//        surgicalMessage = "Click on word in sentence to perform surgery"
//        surgicalWord = ""
//        surgicalProcessedWord = ""
//        surgicalLine1 = ""
//        surgicalLine2 = ""
//        surgicalLine3 = ""
//        surgicalLine4 = ""
//        surgicalLine5 = ""
//        surgicalLine6 = ""
}


struct WordSurgery_Previews: PreviewProvider {
    static var previews: some View {
        WordSurgery()
    }
}
