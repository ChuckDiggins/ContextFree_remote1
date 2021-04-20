//
//  EnumPartOfSpeech.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

enum  LanguageType{
    case English, Spanish, French, Italian, Portuguese
}

enum  VerbEnding : String
{
    case AR, ER, IR, accentIR, OIR, none
    
    func getEnding()->String {
        switch self{
        
        case .AR:
            return "ar"
        case .ER:
            return "er"
        case .IR:
            return "ir"
        case .accentIR:
            return "ír"
        case .OIR:
            return "oir"
        case .none:
            return "no ending"
        }
    }
    
    var description:  String {return rawValue}
}

enum  Person:  Int, CaseIterable
{
    case S1
    case S2
    case S3
    case P1
    case P2
    case P3
}


enum Number
{
    case singular
    case plural
}

enum Gender {
    case masculine
    case feminine
}

enum Mood {
     case   indicative,
        imperative,
        subjunctive
}

enum AmbiguousType {
    case type1
    case type2
}
enum AdjectiveType {
    case color
    case size
    case age
    case condition
    case any
}

enum DeterminerType {
    case definite
    case indefinite
}

enum  AdjectivePositionType
{
    case preceding
    case following
    case precedingMasc  // algún - alguno
}

enum  AdverbType
{
    case comparing      //mas or menos
    case modifying      //mucho, muy
    case negating       //no, jam·s, nunca
    case when
    case WHERE
    case verbAssociated      //lentamente - associated with verbs
}

enum ArticleType
{
    case definite
    case indefinite
    case unknown
}

enum  ConjunctionType
{
    case and     //adds objects
    case or       //
    case but     //
    case coordinating   //y, o
    case contrasting    //pero, mas
    case explanatory    //esto es, es decir
    case reason  //porque, puesto que
    case condition //si, con tal de que
}

enum WordType : String {
    case article
    case determiner
    case adjective
    case number
    case pronoun
    case noun
    case verb
    case auxVerb
    case adverb
    case preposition
    case conjunction
    case contraction
    case punctuation
    case ambiguous
    case unknown
}

enum NounType {
    case person     //person type
    case animal      //dog, cat, horse type
    case vehicle        //plane, train, car, etc
    case plant       //tree, bush, grass, etc
    case electonic  //computer, telephone, television, etc
    case concept    //idea, thought, emotion, etc
    case place       //place type
    case thing     //neutral type
    case bodyPart  //body part
    case any
    
    static var animate =
        [NounType.person, .animal, .vehicle]
    
}

enum PunctuationType {
    case period
    case questionMark
    case upsideDownQuestionMark
    case exclamation
    case upsideDownExclamation
    case comma
    case colon
    case semicolon
    case doubleQuote
    case singleQuote
    case none
}

enum VerbType {
    case transitive     //can take direct object "I see the house"
    case intransitive   //cannot take a direct object "I sleep"
    case ditransitive   //can be both transitive and intransitive
    case copulative        //connecting verb - is, seems, etc.  he seems tired.
    case ergative        //takes nothing after verb - "the ship sank"
    case auxiliary
    case modalAuxiliary    //can, could, may, might, must, shall, should, will, would,
                         // also: dare, need, ought
    case passive         //in Spanish, gustar, preferir can only be used this way
    case idiom
    case pronominal     //casarse - get married, "ellos se casaron" - they got married
    case reflexive
    case defective
}

enum  VerbPreference   //for subject and/or  object
{
    case animate       //person, animal
    case inanimate    //object
    case movable      //person, animal, vehicle
    case place       //place
    case person      //person only
    case concept     //idea, abstract
    case structure   //building
    case any
}

enum PrepositionType
{
    case spatial        //behind, around, between, inside, etc.
    case temporal      //after, before, until, during
    case possessive    //of
    case assignment   //to, for, with, from
    case general     //about, without
}


enum   PronounType
{
    case PERSONAL         //could be subject or object - the boy and you (subj, obj?)
    case SUBJECT          //NOMINATIVE_CASE  I, you, he  ...
    case OBJECT           //OBJECTIVE_CASE    me, you, him  ... (Direct object pronoun in Romance)
    case POSSESSIVE       //POSSESSIVE_CASE    mine, yours, his  ...
    case REFLEXIVE       //REFLEXIVE        myself, yourself, himself
    case PREPOSITIONAL   // de ti, de sí
    case INDIRECT_OBJECT  // me, le, lo, la, etc.
    case DEMONSTRATIVE    // this, those, that, those
    case RELATIVE        // who, which, that
    case INTERROGATIVE   //who, why, where, etc. - start a question - where were you?
    case none
    case NON_PRONOUN                //for noun phrases
}

enum  AuxiliaryType  //English
{
    case future         //will
    case conditional    //would
    case perfect       //have
    case progressive   //is
    case could
    case can
    case might
    case must
    case may
    case DO
    case should
    case ought
    case did
    case IS
    case was
    case none
}

enum  Tense : String, CustomStringConvertible, CaseIterable
{
    case present = "Present"
    case preterite = "Preterite"
    case imperfect = "Imperfect"
    case conditional = "Conditional"
    case future = "Future"
    case presentPerfect = "PresentPerf"
    case pastPerfect = "past perfect"
    case preteritePerfect = "preterite perfect"
    case futurePerfect = "future perfect"
    case conditionalPerfect = "conditional perfect"
    case presentSubjunctive = "Pres Subj"
    case imperfectSubjunctiveRA = "ImpSubj-ra"
    case imperfectSubjunctiveSE = "ImpSubj-se"
    case presentPerfectSubjunctive = "present perfect subjunctive"
    case pastPerfectSubjunctiveRA = "past perfect subjunctive - ra"
    case pastPerfectSubjunctiveSE = "past perfect subjunctive - se"
    case imperative = "imperative"
    case nosotrosCommand = "nosotros command"  //Let's do this!
    case presentProgressive = "present progressive"
    case imperfectProgressive = "imperfect progressive"
    case futureProgressive = "future progressive"
    case conditionalProgressive = "conditional progressive"
    case presentParticiple = "present participle"
    case pastParticiple = "past participle"
    case infinitive = "infinitive"
    
    static var indicativeAll =
        [Tense.present, .preterite, .imperfect, .conditional, .future]
    static var perfectIndicateAll =
        [Tense.presentPerfect, Tense.pastPerfect, .preteritePerfect, .futurePerfect, .conditionalPerfect]
    static var subjunctiveAll = [Tense.presentSubjunctive, .imperfectSubjunctiveRA,.imperfectSubjunctiveSE ]
    static var perfectSubjunctiveAll =
        [Tense.presentPerfectSubjunctive, .pastPerfectSubjunctiveRA, .pastPerfectSubjunctiveSE]
    static var progressiveAll =
        [Tense.presentProgressive, .imperfectProgressive]
    
    var description:  String {return rawValue}
    
    func getSpanishString()->String {
        switch self {
        case .present: return "presente de indicativo"
        case .preterite: return "pretérito"
        case .imperfect: return "imperfecto de indicativo"
        case .future: return "futuro"
        case .conditional: return "condicional simple"
        case .presentSubjunctive: return "presente de subjuntivo"
        case .imperfectSubjunctiveRA: return "imperfecto de subjuntivo - RA"
        case .imperfectSubjunctiveSE: return "imperfecto de subjuntivo - SE"
        case .presentPerfectSubjunctive : return "preterito perfecto subj"
        case .pastPerfectSubjunctiveRA : return "pret pluscuamperfecto subj - ra"
        case .pastPerfectSubjunctiveSE : return "pret pluscuamperfecto subj - se"
        case .imperative: return "imperativo"
        case .presentPerfect: return "presente perfecto"
        case .futurePerfect: return "futuro perfecto"
        case .preteritePerfect: return "pretérito perfecto"
        default:
            return "to be determined later"
        }
    }
    
    func getPerfectIndex()->Int{
        switch self {
        case .presentPerfect: return 0
        case .pastPerfect: return 1
        case .preteritePerfect: return 2
        case .futurePerfect: return 3
        case .conditionalPerfect: return 4
        case .presentPerfectSubjunctive: return 5
        case .pastPerfectSubjunctiveRA: return 6
        case .pastPerfectSubjunctiveSE: return 7
        default:
            return -1
        }
    }
         
    func getProgressiveIndex()->Int{
        switch self {
        case .presentProgressive:return 0
        case .imperfectProgressive:return 1
        case .futureProgressive:return 2
        case .conditionalProgressive:return 3
        default:
            return -1
        }
    }
    
    func isProgressive()->Bool{
        if self == .presentProgressive || self == .imperfectProgressive || self == .futureProgressive || self == .conditionalProgressive {
            return true
        }
        return false
    }
      
    func getIndex()->Int{
        switch self {
        case .present: return 0
        case .imperfect: return 1
        case .preterite: return 2
        case .conditional: return 3
        case .future: return 4
    
        case .presentPerfect: return 5
        case .pastPerfect: return 6
        case .preteritePerfect: return 7
        case .futurePerfect: return 8
        case .conditionalPerfect: return 9
            
        case .presentSubjunctive : return 10
        case .imperfectSubjunctiveRA : return 11
        case .imperfectSubjunctiveSE: return 12
            
        case .presentPerfectSubjunctive: return 13
        case .pastPerfectSubjunctiveRA: return 14
        case .pastPerfectSubjunctiveSE: return 15

        case .imperative : return 16
        case .nosotrosCommand: return 17
            
        case .presentProgressive : return 18
        case .imperfectProgressive : return 19
        case .futureProgressive : return 20
        case .conditionalProgressive : return 21
            
        
        
            
        case .presentParticiple: return 22
        case .pastParticiple: return 23
        case .infinitive:  return 24
        }
    }
}

