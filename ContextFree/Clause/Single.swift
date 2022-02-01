//
//  Single.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation


public class dSingle  : dCluster, Identifiable
/*------------------------------------------------------------------
 Purpose: provide a general class for handling general single  word
 classes.
 ------------------------------------------------------------------*/
{

    public override init(word: Word, clusterType : ContextFreeSymbol, data: WordStateData){
        super.init(word: word, clusterType: clusterType, data: data)
    }
    
    public override init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    public init(clusterType: ContextFreeSymbol){
        super.init(word: Word(), clusterType: clusterType)
    }
    
    
    public func startsWithVowelSound()->Bool{
        return VerbUtilities().startsWithVowelSound(characterArray: getClusterWord().word)
    }
    
    
    var m_partOfPronounPhrase = PronounType.none
    
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    
    var m_originalString = ""
    var m_correction = dCorrection(m_inputInfo: WordStateData())
    var m_inputInfo = WordStateData()
    var m_outputInfo = WordStateData()
    
    public func copyGuts(newSingle: dSingle){
        putClusterWord(word: newSingle.getClusterWord())
        setSentenceData(data: newSingle.getSentenceData())
    }
    
    
    
    public func putOriginalString(str: String){m_originalString = str}
    public func getOriginalString()->String {return m_originalString }
    
    public func getString(clusterString : SentenceWordList)->String
    {
        var cs = clusterString
        return cs.getString()
    }
    
    public func getWordStringAtLanguage(language: LanguageType)->String{
        switch(language){
        case .English: return m_clusterWord.english
        case .Spanish: return m_clusterWord.spanish
        case .French: return m_clusterWord.french
        default:
            return "no word string available"
        }
    }
    
    public func getProcessedStringAtLanguage(language: LanguageType)->String{
        switch(language){
        case .English: return m_clusterWord.english
        case .Spanish: return m_clusterWord.spanish
        case .French: return m_clusterWord.french
        default:
            return "no word string available"
        }
    }
    
    public func    getWordString()->String{
        return getString()
    }
    
    public func getString()->String
    {
        return m_clusterWord.word
    }
    
    public func getWordTypeString()->String
    {
        return m_clusterWord.getWordTypeString()
    }
    
    
    public func setInputInfo(info : WordStateData){m_inputInfo = info}
    public func setOutputInfo(info : WordStateData){m_outputInfo = info}
    
    public func getCorrection()->dCorrection{
        return m_correction
    }
}

public enum AdjectiveSuperState : String {
    case none
    case better
    case best
}


public class dDummySingle : dSingle {
    public  override init(){
        super.init(word: Word(), clusterType: .AdvP, data: WordStateData() )
    }
    
    public init(word: Word){
        super.init(word: word, clusterType: .AdvP, data: WordStateData())
    }
}
public class dAdjectiveSingle :dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling adjective words
 ------------------------------------------------------------------*/
{
    public override init(){
        super.init(word: Word(), clusterType: .Adj, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: .Adj, data: data)
    }
    
    var m_isComparative = false
    var m_isSuperlative = false
    var m_bArticleExists = false
    var m_compareAdverb = ""
    var m_adjPosType = AdjectivePositionType.following
    var m_adjType         = AdjectiveType.any
    var m_superState = AdjectiveSuperState.none
    
    public func setSuperState(superState: AdjectiveSuperState){
        m_superState = superState
    }
    public func  setAdjectiveType (adjType : AdjectiveType){
        m_adjType = adjType
    }
    
    public func setAdjectivePositionType (posType : AdjectivePositionType){m_adjPosType = posType}
    
    public func getAdjectiveType()->AdjectiveType{return m_adjType}
    
    public func getAdjectivePositionType()->AdjectivePositionType{return m_adjPosType}
    
    public func setIsComparative (isComparative : Bool){
        m_isComparative = isComparative
    }
    
    public func setIsSuperlative (isSuperlative : Bool){m_isSuperlative = isSuperlative}
    
    public func isComparative ()->Bool { return m_isComparative}
    public func isSuperlative ()->Bool { return m_isSuperlative}
        
    public func getWordStateData()->WordStateData{
        return getSentenceData()
    }
    
    public func setState(gender: Gender, number: Number){
        let sd = getSentenceData()
        sd.gender = gender
        sd.number = number
        setSentenceData(data: sd)
    }
    
    public override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch sd.language {
        case .Spanish, .French:
            let adj = word as! RomanceAdjective
            if adj.plural.isEmpty {
                if sd.language == .Spanish {
                    let spa = word as! SpanishAdjective
                    spa.createOtherForms()
                } else if sd.language == .French {
                    let spa = word as! FrenchAdjective
                    spa.createOtherForms()
                }
            }
            return adj.getForm(gender: sd.gender, number: sd.number)
        case .English:
            let adj = word as! EnglishAdjective
            return adj.getForm()
        default:
            return ""
        }
        
    }
    public override func getWordStringAtLanguage(language: LanguageType)->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        let an = word as! Adjective
        switch language{
        case .Spanish:
            let adj = SpanishAdjective(word: an.spanish, type: sd.adjectiveType)
            return adj.getForm(gender: sd.gender, number: sd.number)
        case .French:
            let adj = FrenchAdjective(word: an.french, type: sd.adjectiveType)
            return adj.getForm(gender: sd.gender, number: sd.number)
        case .English:
            let adj = EnglishAdjective(word: an.english, type: sd.adjectiveType)
            return adj.getForm(gender: .masculine, number: sd.number)
        default: return ""
        }
    }
    
    public override func getString()->String
    {
        return getWordString()
    }
    
    
}

public class dAdverbSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling adverb single word cluster.
 ------------------------------------------------------------------*/
{
    public override init(){
        super.init(word: Word(), clusterType: .Adv, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: .Adv, data: data)
    }
    
    var   m_adverbType = AdverbType.manner
    public func aetAdverbType (advType: AdverbType){m_adverbType = advType}
    
    public override func getWordStringAtLanguage(language: LanguageType)->String{
        let word = getClusterWord()
        switch language{
        case .Spanish:
            return word.spanish
        case .French:
            return word.french
        case .English:
            return word.english
        default: return ""
        }
    }
    
    // void    GetAssociateString(dSentenceWordList*  clusterString);
    
} //dAdjectiveSingle

public class dAmbiguousSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling ambiguous single word clusters.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.AMB
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    
    var m_singleList = Array<dSingle>()
    var m_bestIndex = 0
    
    public func append(single: dSingle){m_singleList.append(single)}
    public func at(index:Int)->dSingle{return m_singleList[index]}
    
    public func delete(index : Int){m_singleList.remove(at:index)}
    public func  exists (single: dSingle)->Bool{return true}
    public func  getSingleCount()->Int{return m_singleList.count}
    public func hasMatch( ecfst : ContextFreeSymbol)->(Int, dSingle){
        let word = Word()
        let single = dSingle(word: word, clusterType: ecfst, data: WordStateData())
        return (m_bestIndex, single)
    }
    public func  setBestIndex(index: Int){m_bestIndex = index}
    public func  getBestIndex()->Int{return m_bestIndex}
} //dAmbiguousSingle

public class dArticleSingle :  dSingle{
    public var type = ContextFreeSymbol.Art
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    public override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch sd.language {
        case .Spanish, .French:
            let art = word as! RomanceArticle
            return art.getDefiniteForm(gender: sd.gender, number: sd.number)
        case .English:
            //let det = word as! EnglishDeterminer
            return "the"
        default:
            return ""
        }
        
    }
    
    public override func getString()->String
    {
        return getWordString()
    }
    
} //dAmbiguousSingle

public class dConjunctionSingle :  dSingle{
    var type = ContextFreeSymbol.C
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    public func getConjunctionType ()->ConjunctionType{return getSentenceData().conjunctionType }
    
    public override func getWordStringAtLanguage(language: LanguageType)->String{
        let word = getClusterWord()
        switch language{
        case .Spanish:
            return word.spanish
        case .French:
            return word.french
        case .English:
            return word.english
        default:
            return ""
        }
    }
    
} //dConjunctionSingle


public class dDeterminerSingle :  dSingle{
    var type = ContextFreeSymbol.Det
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    public func setState(gender: Gender, number: Number){
        let sd = getSentenceData()
        sd.gender = gender
        sd.number = number
        setSentenceData(data: sd)
    }
    
    public override func getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch sd.language{
        case .Spanish, .French:
            let det = word as! RomanceDeterminer
            return det.getForm(number: sd.number, person: sd.person, gender: sd.gender)
        case .English:
            let det = word as! EnglishDeterminer
            return det.getForm(number: sd.number, person: sd.person, gender: sd.gender, wordStartsWithVowelSound: false)
        default: return ""
        }
    }
    
    public override func getWordStringAtLanguage(language: LanguageType)->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch language{
        case .Spanish:
            let det = SpanishDeterminer(word: word.spanish, type: sd.determinerType)
            return det.getForm(number: sd.number, person: sd.person, gender: sd.gender)
        case .French:
            let det = FrenchDeterminer(word: word.french, type: sd.determinerType)
            return det.getForm(number: sd.number, person: sd.person, gender: sd.gender)
        case .English:
            let det = EnglishDeterminer(word: word.english, type: sd.determinerType)
            return det.getForm(number: sd.number, person: sd.person, gender: sd.gender, wordStartsWithVowelSound: false)
        default: return ""
        }
    }
    
    
} //dDeterminerSingle


public class dNumberSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling number
 single word clusters.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.Num
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
}

public class dParticipleSingle :  dSingle{
    var type = ContextFreeSymbol.Part
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
} //dParticipleSingle

public class dPrepositionSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling noun
 single word clusters.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.P
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    public override func getWordStringAtLanguage(language: LanguageType)->String{
        let word = getClusterWord()
        switch language{
        case .Spanish:
            return word.spanish
        case .French:
            return word.french
        case .English:
            return word.english
        default: return ""
        }
    }
    
    var m_prepositionType = PrepositionType.general
    
    public func setPrepositionType (type: PrepositionType){m_prepositionType = type}
    public func getPrepositionType ()->PrepositionType{ return m_prepositionType}
    
} //dPrepositionSingle

public class dPersonalPronounSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling pronoun single.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.PersPro
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    public func isSubject()->Bool{
        if getPronounType() == .SUBJECT {return true}
        return false
    }
    
    public func setPronounType(pronounType: PronounType){
        getSentenceData().pronounType = pronounType
    }
    
    public override func getPronounType()->PronounType{return getSentenceData().pronounType}
        
    public override func getWordStringAtLanguage(language: LanguageType)->String{
        let word = getClusterWord()
        let sd = getSentenceData()
        switch language{
        case .Spanish:
            let p = SpanishPronoun(word: word.word, type: sd.pronounType)
            return p.getForm(gender:sd.gender, person: sd.person)
        case .French:
            let p = FrenchPronoun(word: word.word, type: sd.pronounType)
            return p.getForm(gender:sd.gender, person: sd.person)
        case .English:
            let p = EnglishPronoun(word: word.word,type: sd.pronounType)
            return p.getForm(gender:sd.gender, person: sd.person)
        default: return ""
        }
    }
    
} //dPersonalPronounSingle


public class dPunctuationSingle :  dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling various punctation
 types - commas, periods, question marks, exclamation marks,
 etc.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.period
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    
    var m_punctuationType = PunctuationType.none
    public func setPunctuationType (type: PunctuationType){m_punctuationType = type}
    public func getPunctuationType ()->PunctuationType{return m_punctuationType}
    
} //dPunctuationSingle

public class dUnknownSingle : dSingle{
    var type = ContextFreeSymbol.UNK
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    /*------------------------------------------------------------------
     Purpose: provide a phrase for handling unknown single word clusters.
     ------------------------------------------------------------------*/
    
} //dUnknownSingle

