//
//  JSONTest.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/27/21.
//

import UIKit

/*
struct JsonPerson: Codable {
    var name: String
    var age: Int
    var gender: String
    var partner: String?
    var isEmployed: Bool
}

var people = [
    JsonPerson(name: "James", age: 45, gender: "Male", partner: "Emily", isEmployed: true),
    JsonPerson(name: "Elizabeth", age: 45, gender: "Other", isEmployed: false)
]

func createJsonPerson(){
    let encoder = JSONEncoder()
    let peopleJSONData = try! encoder.encode(people)
    print(String(data: peopleJSONData, encoding: .utf8)!)
}

*/

struct JsonVerb: Codable {
    enum Transitivity: String, Codable {
        case transitive, intransitive, ambitransitive
    }
    
    enum PronominalType: String, Codable {
        case reflexive, reciprocal, idiomatic, pseudoReflexive, occasional
    }
    
    struct Verb: Codable{
        var word: String
        var english: String
        var transitivity: Transitivity
        var pronominal : PronominalType?
        var isPassive: Bool
        
    }
    var verbGroupName: String
    var verbs: [Verb]
}


let verbList = JsonVerb(verbGroupName: "Simple verbs",
                      verbs: [
                        JsonVerb.Verb(word: "vivir", english: "live", transitivity: .intransitive, isPassive: false),
                        JsonVerb.Verb(word: "casar", english: "marry", transitivity: .transitive, pronominal : .reflexive, isPassive: false),
])

//create json from

func createJsonVerb(){
    let encoder3 = JSONEncoder()
    let verbJSONData = try! encoder3.encode(verbList)
    print("")
    print(String(data: verbJSONData, encoding: .utf8)!)
}
