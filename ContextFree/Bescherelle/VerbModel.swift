//
//  VerbModel.swift
//  ContextFree
//
//  Created by Charles Diggins on 3/11/21.
//

import Foundation


//these verbs have special construction logic for several of their tenses
enum SpecialVerbModel {
    case ESTAR
    case HABER
    case REIR
    case SABER
    case SONREIR
    case IR
    case OIR
    case SER
    case VER
    case none
}
/*
struct ParsedExceptionStruct {
    var tense = Tense.present
    var pattern = ExceptionPattern.STEM
    var from = ""
    var to = ""
    var personList = [Person]()
    var standAlone = false
}
*/

struct VerbModel : Identifiable {
    
    struct Exception {
        let exceptionPattern : String
        let tense : String
        let person : String?
        let from : String?
        let to : String?
    }
    
    let id : Int
    let modelVerb : String
    var exceptionList = [Exception]()
    var includeWord = ""
    var includeSuffixList = [String]()
    var excludeSuffixList = [String]()
    var standAlone = false
    var special = false
    var specialVerb = ""
    var consistentVerbEnding = ExceptionVerbEnding.none  //assume that include suffixes are not consistent verb ending
 
    mutating func appendException(exceptionPattern: ExceptionPattern, tense : ExceptionTense, person : ExceptionPerson, from : String, to : String ) {
        let exception = exceptionPattern.rawValue
        let tense = tense.rawValue
        let person = person.rawValue
        let from = from
        let to = to
        let except = Exception(exceptionPattern:exception, tense: tense, person: person, from: from, to:to)
        if ( except.exceptionPattern == "STANDALONE"){
            standAlone = true
        }
        if ( except.exceptionPattern == "SPECIAL"){
            special = true
            specialVerb = from
        }
        exceptionList.append(except)
    }
    
    mutating func appendWord(word: String){
        includeWord = word
    }
        
    
    mutating func appendSuffix(suffix: String){
        includeSuffixList.append(suffix)
        
        var consistentEnding = true
        
        let testVerbEnding = includeSuffixList[0].suffix(2)
    
        //if any suffixes do not have the same verb ending as testVerbEnding,
        // then the test ending is not consistent
        
        for sf in includeSuffixList {
            if sf.suffix(2) != testVerbEnding {
                consistentEnding = false
                break
            }
        }
        consistentVerbEnding = .none
        if consistentEnding {
            if ( testVerbEnding == ExceptionVerbEnding.ar.rawValue){consistentVerbEnding = .ar}
            else if ( testVerbEnding == ExceptionVerbEnding.er.rawValue){consistentVerbEnding = .er}
            else if ( testVerbEnding == ExceptionVerbEnding.ir.rawValue){consistentVerbEnding = .ir}
        }
        
    }
    
    mutating func appendExcludeSuffix(suffix: String){
        excludeSuffixList.append(suffix)
    }
    
    func hasConsistentVerbEnding(suffix: String)->Bool {
        if suffix == consistentVerbEnding.rawValue {return true}
        return false
    }
    
    func getConsistentVerbEnding()->String {
        return consistentVerbEnding.rawValue
    }
    
    func isModelFor(verbWord: String)->Bool {
        
        if verbWord == includeWord {
            return true
        }
        
        //first, make sure it is not excluded
        for suffix in excludeSuffixList {
            if verbWord.hasSuffix(suffix){return false}
        }
        
        //only accept exact match with first suffix
        
        if standAlone {
            if verbWord == includeSuffixList[0] {return true}
        }
        else {
            //next, see if it is included
            for suffix in includeSuffixList {
                if verbWord.hasSuffix(suffix){return true}
            }
        }
        return false
    }
    
    
    mutating func parseVerbModel()->[ParsedExceptionStruct] {
        var parsedStructList = [ParsedExceptionStruct]()
        
        for exception in exceptionList {
            var parsedStruct = ParsedExceptionStruct()
            parsedStruct.tense = Tense.present
            parsedStruct.from = exception.from!
            parsedStruct.to = exception.to!
            
            //translate ExceptionPatternString into an enum that we can use
            
            switch exception.exceptionPattern {
            case "STEM" : parsedStruct.pattern = .STEM
            case "STEMSINGLE" : parsedStruct.pattern = .STEMSINGLE
            case "PRETSTEM" : parsedStruct.pattern = .PRETSTEM
            case "PRETSTEM2" : parsedStruct.pattern = .PRETSTEM2
            case "PRETSTEM3" : parsedStruct.pattern = .PRETSTEM3
            case "ORTHO" : parsedStruct.pattern = .ORTHO
            case "REPLACEINFINITIVE" : parsedStruct.pattern = .REPLACEINFINITIVE
            case "REPLACEENDING" : parsedStruct.pattern = .REPLACEENDING
            case "REPLACE" : parsedStruct.pattern = .REPLACE
            case "SPECIAL" : parsedStruct.pattern = .SPECIAL
            default: parsedStruct.pattern = .NONE
            }
            
            switch exception.person {
            case "S1": parsedStruct.personList.append(Person.S1)
            case "S2": parsedStruct.personList.append(Person.S2)
            case "S3":  parsedStruct.personList.append(Person.S3)
            case "P1":  parsedStruct.personList.append(Person.P1)
            case "P2":  parsedStruct.personList.append(Person.P2)
            case "P3":  parsedStruct.personList.append(Person.P3)
            case "S1toP3All" :
                parsedStruct.personList.append(Person.S1)
                parsedStruct.personList.append(Person.S2)
                parsedStruct.personList.append(Person.S3)
                parsedStruct.personList.append(Person.P1)
                parsedStruct.personList.append(Person.P2)
                parsedStruct.personList.append(Person.P3)
            case "S2toP3All" :
                parsedStruct.personList.append(Person.S2)
                parsedStruct.personList.append(Person.S3)
                parsedStruct.personList.append(Person.P1)
                parsedStruct.personList.append(Person.P2)
                parsedStruct.personList.append(Person.P3)
            case "S1S2S3P3" :
                parsedStruct.personList.append(Person.S1)
                parsedStruct.personList.append(Person.S2)
                parsedStruct.personList.append(Person.S3)
                parsedStruct.personList.append(Person.P3)
            case "S3P3" :
                parsedStruct.personList.append(Person.S3)
                parsedStruct.personList.append(Person.P3)
            case "P1P2" :
                parsedStruct.personList.append(Person.P1)
                parsedStruct.personList.append(Person.P2)
            default: parsedStruct.personList.append(Person.S1)
            }
            
            switch exception.tense {
            case "PRESENT": parsedStruct.tense = .present
            case "PRETERITE": parsedStruct.tense = .preterite
            case "PRESENTSUBJ": parsedStruct.tense = .presentSubjunctive
            case "IMPERFECTSUBJRA" : parsedStruct.tense = .imperfectSubjunctiveRA
            case "IMPERFECTSUBJSE" : parsedStruct.tense = .imperfectSubjunctiveSE
            case "FUTURE": parsedStruct.tense = .future
            case "CONDITIONAL": parsedStruct.tense = .conditional
            case "PASTPART": parsedStruct.tense = .pastParticiple
            case "GERUND": parsedStruct.tense = .presentParticiple
            default: parsedStruct.tense = .present
            
            }
            parsedStructList.append(parsedStruct)
        }
        
        return parsedStructList
    }

}

func createVerbModel(id: Int, verbWord : String, exceptionPattern: ExceptionPattern)->VerbModel
{
    let id = id
    let mv = verbWord
    var verbModel = VerbModel(id: id, modelVerb: mv)
    verbModel.appendSuffix(suffix: mv)
    return verbModel
}


