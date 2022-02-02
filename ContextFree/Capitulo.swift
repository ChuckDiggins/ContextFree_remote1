//
//  Capitulo.swift
//  Capitulo
//
//  Created by Charles Diggins on 1/8/22.
//

import Foundation
import JumpLinguaHelpers

struct Capitulo{
    let language : LanguageType
    let title : String
    let subTitle : String
    let verbs : [Verb]
    let nouns : [Noun]
    let questions = [dIndependentAgnosticClause]()
    let responses = [dIndependentAgnosticClause]()
    let usefulVocabulary = [Word]()
    let tenses = [Tense]()
}
