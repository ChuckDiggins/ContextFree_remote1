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
    case AR, ER, IR, accentIR, OIR, RE, none
    
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
        case .RE:
            return "re"
        case .none:
            return "no ending"
        }
    }
    
    func getSpanishEndings()->Array<VerbEnding>{
        var verbEndingList = Array<VerbEnding>()
        verbEndingList.append(.AR)
        verbEndingList.append(.ER)
        verbEndingList.append(.IR)
        return verbEndingList
    }
    
    var description:  String {return rawValue}
}


enum  ReflexivePronoun: String
{
    case me
    case te
    case se
    case nos
    case os
    
    func getReflexivePronoun( person : Person)->String
    {
        switch person{
        case .S1:
            return "me"
        case .S2:
            return "te"
        case .S3:
            return "se"
        case .P1:
            return "nos"
        case .P2:
            return "os"
        case .P3:
            return "se"
        }
    }
}

enum  Person:  Int, CaseIterable
{
    case S1 = 0
    case S2 = 1
    case S3 = 2
    case P1 = 3
    case P2 = 4
    case P3 = 5
    
    static var all = [S1, S2, S3, P1, P2, P3]
      
    func getPassivePerson(count: Number)->Person {
        if ( count == .singular){
            return .S3
        }
        return .P3
    }
    
    func getEnumString()->String{
        switch self {
        case .S1: return "S1"
        case .S2: return "S2"
        case .S3: return "S3"
        case .P1: return "P1"
        case .P2: return "P2"
        case .P3: return "P3"
        }
    }
    func getIndex()->Int{
        switch self {
        case .S1: return 0
        case .S2: return 1
        case .S3: return 2
        case .P1: return 3
        case .P2: return 4
        case .P3: return 5
        }
    }
    
    func getPretStem2Ending()->String{
        switch self {
        case .S1: return "no pretStem3 ending for S1"
        case .S2: return "no pretStem3 ending for S2"
        case .S3: return "ió"
        case .P1: return "no pretStem3 ending for P1"
        case .P2: return "no pretStem3 ending for P2"
        case .P3: return "ieron"
        }
    }
    
    //used after ñ or ll
    func getSoftPretStem2Ending()->String{
        switch self {
        case .S1: return "no pretStem3 ending for S1"
        case .S2: return "no pretStem3 ending for S2"
        case .S3: return "ó"
        case .P1: return "no pretStem3 ending for P1"
        case .P2: return "no pretStem3 ending for P2"
        case .P3: return "eron"
        }
    }
    
    func getPretStem3Ending()->String{
        switch self {
        case .S1: return "no pretStem3 ending for S1"
        case .S2: return "íste"
        case .S3: return "yó"
        case .P1: return "ímos"
        case .P2: return "ísteis"
        case .P3: return "yeron"
        }
    }
    
        func getReirPretStem3Ending()->String{
        switch self {
        case .S1: return "rei"
        case .S2: return "reíste"
        case .S3: return "rió"
        case .P1: return "reímos"
        case .P2: return "reísteis"
        case .P3: return "rieron"
        }
    }
    

    func getEnglishMaleString()->String {
        switch self {
        case .S1: return "I"
        case .S2: return "you"
        case .S3: return "he"
        case .P1: return "we"
        case .P2: return "you"
        case .P3: return "they"
        }
    }
    
    func getEnglishFemaleString()->String {
        switch self {
        case .S1: return "I"
        case .S2: return "you"
        case .S3: return "she"
        case .P1: return "we"
        case .P2: return "you"
        case .P3: return "they"
        }
    }
    
    func getFemaleString()->String {
        switch self {
        case .S1: return "yo"
        case .S2: return "tú"
        case .S3: return "ella"
        case .P1: return "nosotras"
        case .P2: return "vosotras"
        case .P3: return "ellas"
        }
    }
    
    func getMaleString()->String {
        switch self {
        case .S1: return "yo"
        case .S2: return "tú"
        case .S3: return "él"
        case .P1: return "nosotros"
        case .P2: return "vosotros"
        case .P3: return "ellos"
            
        }
    }
    
    func getUstedString()->String {
        switch self {
        case .S1: return "yo"
        case .S2: return "tú"
        case .S3: return "usted"
        case .P1: return "nosotros"
        case .P2: return "vosotros"
        case .P3: return "ustedes"
            
        }
    }
    
    func getImperativeString()->String {
        switch self {
        case .S1: return ""
        case .S2: return "tú"
        case .S3: return "usted"
        case .P1: return "nosotros"
        case .P2: return "vosotros"
        case .P3: return "ustedes"
            
        }
    }
    
    func getPassiveString()->String {
        switch self {
        case .S1: return "me"
        case .S2: return "te"
        case .S3: return "le"
        case .P1: return "nos"
        case .P2: return "os"
        case .P3: return "les"
            
        }
    }
}


enum Number
{
    case singular
    case plural
}

enum Gender {
    case masculine
    case feminine
    case either
}

enum Mood {
     case   indicative,
        imperative,
        subjunctive
}

enum AmbiguousType {
    case general
    case pronoun  //in Spanish, "me" can be a reflexive pronoun, direct object pronoun, for example
}

enum AdjectiveType {
    case regular
    case demonstrative
    case possessive
    case interrogative
    case count
    case color
    case size
    case age
    case condition
    case any
    
    static var primaryTypes =
        [AdjectiveType.regular, .possessive, .interrogative, .demonstrative ]
    
    func getPrimaryType(index: Int)->AdjectiveType
    {
        let typeList = [AdjectiveType.regular, .possessive, .interrogative, .demonstrative ]
        if ( index < typeList.count ){
            return typeList[index]}
        return .any
    }
}

enum  AdjectivePositionType
{
    case preceding
    case following
    case both  // algún - alguno
}


enum DeterminerType {
    case definite
    case indefinite
    case partative   //french - du, de la, de l', des
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
    case partative
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
    case demonstrativeAdjective
    case possessiveAdjective
    case interrogativeAdjective
    case number
    case noun
    case verb
    case auxVerb
    case adverb
    case preposition
    case conjunction
    case contraction
    case punctuation
    case ambiguous
    case pronoun
    case subjectPronoun
    case directObjectPronoun
    case indirectObjectPronoun
    case prepositionalPronoun
    case unknown
}

enum NounType {
    case agent
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
        [NounType.person, .animal, .vehicle, .agent]
}

enum NounSubjectivity  //LOL
{
    case goodSubject
    case goodObject
    case either
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

enum VerbTransitivity {
    case transitive     //can take direct object "I see the house"
    case intransitive   //cannot take a direct object "I sleep"
    case ditransitive   //can be both transitive and intransitive
    case ergative        //takes nothing after verb - "the ship sank"
}

enum VerbModality {
    case modalAuxiliary    //can, could, may, might, must, shall, should, will, would,
                         // also: dare, need, ought
    case modal          //querer ... yo quiero una pelota / yo quiero ir a la casa
    case copulative        //connecting verb - is, seems, etc.  he seems tired.
    case notModal
}

enum VerbPassivity {
    case passive    //gustar
    case active
}

enum VerbPronomality {
    case pronominal     //casarse - get married, "ellos se casaron" - they got married
    case reflexive
    case notPronominal
}

enum VerbType {
    case normal
    case auxiliary
    case idiom
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
    case DIRECT_OBJECT           //OBJECTIVE_CASE    me, you, him  ... (Direct object pronoun in Romance)
    case INDIRECT_OBJECT  // me, le, lo, la, etc.
    case POSSESSIVE       //POSSESSIVE_CASE    mine, yours, his  ...
    case REFLEXIVE       //REFLEXIVE        myself, yourself, himself
    case PREPOSITIONAL   // de ti, de sí
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
    case gerund = "gerund"
    
    static var specialFormsAll =
        [Tense.presentParticiple, .pastParticiple, .infinitive]
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
    
    func getPerfectTense()->Tense{
        switch self {
        case .present: return .presentPerfect
        case .preterite: return .preteritePerfect
        case .imperfect: return .pastPerfect
        case .future: return .futurePerfect
        case .conditional: return .conditionalPerfect
        case .presentSubjunctive: return .presentPerfectSubjunctive
        case .imperfectSubjunctiveRA: return .pastPerfectSubjunctiveRA
        case .imperfectSubjunctiveSE: return .pastPerfectSubjunctiveSE
        default: return .present
        }
    }
    
    func getProgressiveTense()->Tense{
        switch self {
        case .present: return .presentProgressive
        case .imperfect: return .imperfectProgressive
        case .future: return .futureProgressive
        case .conditional: return .conditionalProgressive
        default: return .present
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
        case .gerund:  return 25
        }
    }
}

