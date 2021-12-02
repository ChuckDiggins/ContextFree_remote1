//
//  MiscSentenceStructs.swift
//  MiscSentenceStructs
//
//  Created by Charles Diggins on 11/26/21.
//

import Foundation

struct VerbSettings{
    var tense : Tense
    var person : Person
}

struct NounSettings{
    var number : Number
}

struct SentenceData {
    var word = Word()
    var data = WordStateData()
}
