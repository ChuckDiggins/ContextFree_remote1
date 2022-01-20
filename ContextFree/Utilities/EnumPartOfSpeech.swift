//
//  EnumPartOfSpeech.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

enum  LanguageType : String {
    case English, Spanish, French, Italian, Portuguese, Agnostic
}

enum PhraseType{
    case NounPhrase
    case VerbPhrase
    case PrepositionPhrase
    case AdjectivePhrase
    case AdverbPhrase
}

enum  VerbEnding : String
{
    case AR, ER, IR, accentIR, umlautIR, OIR, RE, none
    
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
        case .umlautIR:
            return "ïr"
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

/*
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
*/


enum Mood : String {
     case   indicative,
        imperative,
        subjunctive
}

enum AmbiguousType {
    case general
    case pronoun  //in Spanish, "me" can be a reflexive pronoun, direct object pronoun, for example
}

enum AdjectiveType : String {
    case regular
    case demonstrative
    case possessive
    case interrogative
    case count
    case color
    case size
    case age
    case nationality
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

enum  AdjectivePositionType  : String
{
    case preceding
    case following
    case both  // algún - alguno
}


enum DeterminerType  : String {
    case definite
    case indefinite
    case possessive
    case demonstrative
    case interrogative
    case partative   //french - du, de la, de l', des
}

enum  AdverbType  : String
{
    case manner // M = manner - bien, así, mejor
    case place // P = place - aquí, arriba, dónde
    case time // T = time - hoy, ahora,
    case intensity // I = intensity - poco, más, cuanto
    case doubt // D = doubt - posiblemente, tal vez
    case affirmation // A = affirmation - ciertamente
    case exclusion // E = exclusion - apenas
}

enum ArticleType  : String
{
    case definite
    case indefinite
    case partative
    case unknown
}

enum  ConjunctionType  : String
{
    case and     //adds objects
    case or       //
    case but     //
    case coordinating   //y, o
    case contrasting    //pero, mas
    case explanatory    //esto es, es decir
    case reason  //porque, puesto que
    case condition //si, con tal de que
    case subordinating
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
    
    case nounPhrase
    case verbPhrase
    case prepositionPhrase
    case adverbPhrase
    
    case unknown
}

func getClusterTypeFromString(str: String)->ContextFreeSymbol{
    switch str{
    case "N": return .N
    case "V": return .V
    case "Adj": return .Adj
    case "Adv": return .Adv
    case "P": return .P
    case "C": return .C
    case "NP": return .NP
    case "VP": return .VP
    case "PP": return .PP
    case "AP": return .AP
    case "AdvP": return .AdvP
    default: return .AMB
    }
}
        
        
func getWordTypeFromString(str: String)->WordType{
    switch str{
    case "noun": return .noun
    case "verb": return .verb
    case "adjective": return .adjective
    case "adverb": return .adverb
    case "preposition": return .preposition
    case "conjunction": return .conjunction
    default: return .ambiguous
    }
}


func getWordType(clusterType: ContextFreeSymbol)->WordType{
    switch clusterType{
    case .Adj: return .adjective
    case .Adv: return .adverb
    case .Det: return .determiner
    case .N: return .noun
    case .P: return .preposition
    case .C: return .conjunction
    case .V: return .verb
    default: return .ambiguous
    }
}

enum PunctuationType  : String {
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

enum VerbTransitivity : Int, Codable {
    case transitive     //can take direct object "I see the house"
    case ditransitive     //can take two objects "I gave her the ball"
    case intransitive   //cannot take a direct object "I sleep"
    case ambitransitive   //can be both transitive and intransitive
    case ergative        //takes nothing after verb - "the ship sank"
}

enum VerbModality  : String {
    case modalAuxiliary    //can, could, may, might, must, shall, should, will, would,
                         // also: dare, need, ought
    case modal          //querer ... yo quiero una pelota / yo quiero ir a la casa
    case copulative        //connecting verb - is, seems, etc.  he seems tired.
    case notModal
}

enum VerbPassivity : Int, Codable {
    case active
    case passive    //gustar
    case both
    
    
}

func getTransitivity(index:Int)->VerbTransitivity{
    switch (index){
    case 0: return .transitive
    case 1: return .ditransitive
    case 2: return .intransitive
    case 3: return .ambitransitive
    default: return .ergative
    }
}


func getPassivity(index:Int)->VerbPassivity{
    switch (index){
    case 0: return .active
    case 1: return .passive
    default: return .both
    }
}

enum VerbPronomality {
    case pronominal     //casarse - get married, "ellos se casaron" - they got married
    case reflexive
    case notPronominal
}

enum VerbType : Int, Codable{
    case normal
    case auxiliary  //haber, esta
    case copulative //ser, estar, to be,
    case helping   //poder, querer saber
    case modal   //poder, querer saber
    case phrasal
    case phrasalSeparable
    case impersonal //weather stuff:  orvallar(drizzle), llover(rain)
    case passive
    case defective //
}

enum Separable : Int, Codable{
    case notSeparable   //laugh about it
    case separable      //call me up
    case both          //put this up, put up this
}

func getVerbType(index:Int)->VerbType{
    switch (index){
    case 0: return .normal
    case 1: return .auxiliary
    case 2: return .copulative
    case 3: return .helping
    case 4: return .modal
    case 5: return .phrasal
    case 6: return .phrasalSeparable
    case 7: return .defective
    case 8: return .impersonal //weather stuff:  orvallar(drizzle), llover(rain)
    case 9: return .passive
    default: return .normal
    }
}

func getVerbTypesAsStringList()->[String]{
    var strList = [String]()
    strList.append("N")
    strList.append("A")
    strList.append("C")
    strList.append("H")
    strList.append("M")
    strList.append("P")
    strList.append("S")
    strList.append("D")
    strList.append("I")
    strList.append("B")
    return strList
}

func getVerbTypeAsLetter(index:Int)->String{
    switch (index){
    case 0: return "N"
    case 1: return "A"
    case 2: return "C"
    case 3: return "H"
    case 4: return "M"
    case 5: return "P"
    case 6: return "S"
    case 7: return "D"
    case 8: return "I"
    case 9: return "B"
    default: return "N"
    }
}

func getVerbTypeFromLetter(letter: String)->VerbType{
    switch (letter){
    case "N": return .normal
    case "A": return .auxiliary
    case "C": return .copulative
    case "H": return .helping
    case "M": return .modal
    case "P": return .phrasal
    case "S": return .phrasalSeparable
    case "D": return .defective
    case "B": return .passive
    case "I": return .impersonal
    default:  return .normal
    }
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


enum NounSubjectivity  //LOL
{
    case goodSubject
    case goodObject
    case either
}
enum NounType : Int {
    case person  //= "Pr"   //person type
    case animal   //= "An"   //dog, cat, horse, insect type
    case place     //= "Pl"   //place type
    case furniture  //= "Fn"      //plane, train, car, etc
    case concept   //= "Cp" //idea, thought, emotion, etc
    case plant     // = "Pt"    //tree, bush, grass, etc
    case thing      //    = "Th" //neutral type
    case legalEntity  // = "Le"    //city, corporation, country
    case activity //= "Ac"
    case any //non-specific
    static var animate =
        [NounType.person, .animal]
}

func getNounTypeFromString(str: String)->NounType{
    switch(str){
    case "Pr": return .person
    case "An": return .animal
    case "Pl": return .place
    case "Fn": return .furniture
    case "Cp": return .concept
    case "Pt": return .plant
    case "Th": return .thing
    case "Le": return .legalEntity
    case "Ac": return .activity
    default: return .person
    }
}

func getNounTypeStringAtIndex(index: Int)->String{
    switch(index){
    case 0: return "Pr"
    case 1: return "An"
    case 2: return "Pl"
    case 3: return "Fn"
    case 4: return "Cp"
    case 5: return "Pt"
    case 6: return "Th"
    case 7: return "Le"
    case 8: return "Ac"
    default: return "Pr"
    }
}

func getNounTypesAsStringList()->[String]{
    var strList = [String]()
    strList.append("Pr")
    strList.append("An")
    strList.append("Pl")
    strList.append("Fn")
    strList.append("Cp")
    strList.append("Pt")
    strList.append("Th")
    strList.append("Le")
    strList.append("Ac")
    return strList
}


enum PrepositionType  : String
{
    case spatial        //behind, around, between, inside, etc.
    case temporal      //after, before, until, during
    case possessive    //of
    case assignment   //to, for, with, from
    case general     //about, without
}


enum   PronounType  : String
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

enum  AuxiliaryType   : String //English
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



