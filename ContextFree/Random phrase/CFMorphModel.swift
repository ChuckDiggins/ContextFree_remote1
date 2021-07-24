//
//  CFMorphModel.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/10/21.
//

import Foundation

enum MorphOperation : String {
    case remove
    case insertBefore
    case replace
    case move
    case grab
    case contract   //a + el = al, will + not = won't
    case convert   //from direct object phrase to direct object pronoun
    case append   //estoy comprando + lo = estoy comprándolo
}

struct MorphOperationStruct{
    var morphOperation = MorphOperation.grab
    var from = CFTypes.none
    var to = CFTypes.none
    var location = Location.none
}

struct MorphOperationJson : Codable{
    let morphOperationString : String
    let cfFromTypeString : String
    let cfToTypeString : String
    var locationString : String
    
    init(morphOperation: String, cfFromTypeString: String, cfToTypeString: String){
        self.morphOperationString = morphOperation
        self.cfFromTypeString = cfFromTypeString
        self.cfToTypeString = cfToTypeString
        self.locationString = ""
    }
    
    init(morphOperation: String, cfFromTypeString: String, locationString: String){
        self.morphOperationString = morphOperation
        self.cfFromTypeString = cfFromTypeString
        self.cfToTypeString = ""
        self.locationString = locationString
    }
}

enum CFTypes {
    case none
    case literal     //any string, exclamation
    case punctuation
    case directObjectPhrase
    case indirectObjectPhrase
    case subjectPhrase
    case directObjectPronoun
    case indirectObjectPronoun
    case subjectPronoun
    case demonstrativePronoun //this one, that one
    case disjunctivePronoun   //disjunctive: after preposition, after C'est (FR)
    case adverbialPronoun   //y, en
    case possessivePronoun   //my, mine
}

enum Location {
    case none
    case precedingVerb
    case insideVerb     //phrasal verbs in English
    case appendToVerb  //comprando + lo = comprándolo
    case precedingDOPronoun
    case afterDOPronoun
    case precedingClause
    case afterClause
    case afterSingle
    case beforeSingle
}


/*
 A CFMorphModel comprises a list of MorphPatterns
 Each pattern defines an operation
 Each operation involves an operation type plus one or two operands
 1.  single operand might be to insert a direct object pronoun before the clause verb
 2.  a double operand might be to convert a direct object to a direct object pronoun
 */

struct CFMorphModel : Identifiable {
    let id : Int
    let modelName : String
    var mpjList = [MorphOperationJson]()  //string version for reading and writing as JSON
    var mpsList = [MorphOperationStruct]() //enum version
    
    mutating func appendOperation(mp : MorphOperationJson){
        mpjList.append(mp)
    }
    
    mutating func parseMorphModel(){
   
        for mpj in mpjList {
            var mps = MorphOperationStruct()
            switch mpj.morphOperationString{
            case "remove" : mps.morphOperation = .remove
            case "insert" : mps.morphOperation  = .insertBefore
            case "replace" : mps.morphOperation  = .replace
            case "move" : mps.morphOperation  = .move
            case "grab" : mps.morphOperation  = .grab
            case "contract" : mps.morphOperation  = .contract
            case "convert" : mps.morphOperation = .convert
            case "append" : mps.morphOperation = .append
            default: break
            }
            
            
            switch mpj.cfFromTypeString{
            case "directObjectPhrase" : mps.from = .directObjectPhrase
            case "subjectPhrase" : mps.from = .subjectPhrase
            case "indirectObjectPhrase" : mps.from = .indirectObjectPhrase
            case "directObjectPronoun" : mps.from = .directObjectPronoun  //for removing
            case "subjectPronoun" : mps.from = .subjectPronoun
            case "indirectObjectPronoun" :  mps.from = .indirectObjectPronoun
            case "demonstrativePronoun" : mps.from = .demonstrativePronoun //this one, that one
            case "disjunctivePronoun" : mps.from = .disjunctivePronoun    //disjunctive: after preposition, after C'est (FR)
            case "adverbialPronoun" : mps.from = .adverbialPronoun   //y, en
            case "possessivePronoun" : mps.from = .possessivePronoun   //my, mine
            case "literal" : mps.from = .literal
            case "none" : mps.from = .none
            default: mps.from = .none
            }
            
            switch mpj.cfToTypeString{
            case "directObjectPhrase" : mps.to = .directObjectPhrase
            case "subjectPhrase" : mps.to = .subjectPhrase
            case "indirectObjectPhrase" : mps.to = .indirectObjectPhrase
            case "directObjectPronoun" : mps.to = .directObjectPronoun
            case "subjectPronoun" : mps.to = .subjectPronoun
            case "indirectObjectPronoun" :  mps.to = .directObjectPronoun
            case "demonstrativePronoun" : mps.to = .demonstrativePronoun //this one, that one
            case "disjunctivePronoun" : mps.to = .disjunctivePronoun   //disjunctive: after preposition, after C'est (FR)
            case "adverbialPronoun" : mps.to = .adverbialPronoun   //y, en
            case "possessivePronoun" : mps.to = .possessivePronoun   //my, mine
            default: mps.to = .none
            }
            
            switch mpj.locationString{
            case "precedingVerb" : mps.location = .precedingVerb
            case "insideVerb" : mps.location = .insideVerb
            case "appendToVerb" : mps.location = .appendToVerb
            case "precedingDOPronoun" : mps.location = .precedingDOPronoun
            case "afterDOPronoun" : mps.location = .afterDOPronoun
            case "precedingClause" : mps.location = .precedingClause
            case "afterClause" : mps.location = .afterClause
            default: mps.location = .none
            }
            mpsList.append(mps)
        }
    }
}


/*
 case inFrontOfVerb
 case insideVerb     //phrasal verbs in English
 case inFrontOfPronoun
 case inFrontOfClause
 case atBackOfClause
 */
