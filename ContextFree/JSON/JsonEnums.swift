//
//  JsonEnums.swift
//  JsonEnums
//
//  Created by Charles Diggins on 1/8/22.
//

import Foundation

enum JsonCollectionTypes : String {
    case All
    //case CarpenterChapter3
    case Simple
}

enum JsonWordType : String, Decodable {
    case adjective
    case adverb
    case noun
    case verb
    case determiner
    case preposition
    case conjunction
}

enum JsonClusterType : String, Decodable {
    case N
    case V
    case Adj
    case Adv
    case P
    case Pronoun
    case NP
    case PP
    case VP
    case AP
    case AdvP
}