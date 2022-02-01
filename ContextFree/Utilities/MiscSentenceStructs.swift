//
//  MiscSentenceStructs.swift
//  MiscSentenceStructs
//
//  Created by Charles Diggins on 11/26/21.
//

import Foundation

public struct VerbSettings{
    var tense : Tense
    var person : Person
}

public struct NounSettings{
    var number : Number
}

public struct SentenceData {
    var word = Word()
    var data = WordStateData()
}
