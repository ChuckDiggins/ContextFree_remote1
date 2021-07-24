//
//  Single.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation


class dSingle  : dCluster
/*------------------------------------------------------------------
 Purpose: provide a general class for handling general single  word
 classes.
 ------------------------------------------------------------------*/
{
    //var m_clusterWord : Word
    
    override init(word: Word, clusterType : ContextFreeSymbol, data: WordStateData){
        super.init(word: word, clusterType: clusterType, data: data)
    }
    
    override init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    static func ==(lhs: dSingle, rhs: dSingle) -> Bool {
        return lhs.getClusterWord() == rhs.getClusterWord() && lhs.getSentenceData() == rhs.getSentenceData()
    }
    
    func startsWithVowelSound()->Bool{
        return VerbUtilities().startsWithVowelSound(characterArray: getClusterWord().word)
    }
    
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    
    var m_originalString = ""
    var m_correction = dCorrection(m_inputInfo: WordStateData())
    var m_inputInfo = WordStateData()
    var m_outputInfo = WordStateData()
    var m_clusterList = Array<dCluster>()
    
    func copyGuts(newSingle: dSingle){
        putClusterWord(word: newSingle.getClusterWord())
        setSentenceData(data: newSingle.getSentenceData())
    }
    
    func getClusterCount()->Int{return m_clusterList.count}
    func getClusterList()->[dCluster]{ return m_clusterList}
    func appendCluster(cluster: dCluster){m_clusterList.append(cluster)}
    func deleteCluster(index: Int){if index < getClusterCount(){m_clusterList.remove(at : index)}}
    func insertCluster(index: Int, cluster : dCluster){m_clusterList.insert(cluster, at: index)}
    
    func replaceClusterRange(firstIndex: Int, lastIndex: Int, cluster: dCluster){
        for _ in firstIndex...lastIndex {
            deleteCluster(index: firstIndex)
        }
        insertCluster(index: firstIndex, cluster: cluster)
    }
    func putOriginalString(str: String){m_originalString = str}
    func getOriginalString()->String {return m_originalString }
    
    func getString(clusterString : SentenceWordList)->String
    {
        var cs = clusterString
        return cs.getString()
    }
    
    func    getWordString()->String{
        return getString()
    }
    
    func getString()->String
    {
        return m_clusterWord.word
    }
    
    func getWordTypeString()->String
    {
        return m_clusterWord.getWordTypeString()
    }
    

    func setInputInfo(info : WordStateData){m_inputInfo = info}
    func setOutputInfo(info : WordStateData){m_outputInfo = info}
    
    func getCorrection()->dCorrection{
        return m_correction
    }
}

enum AdjectiveSuperState : String {
    case none
    case better
    case best
}


class dDummySingle : dSingle {
    override init(){
        super.init(word: Word(), clusterType: .AdvP, data: WordStateData() )
    }
    
    init(word: Word){
        super.init(word: word, clusterType: .AdvP, data: WordStateData())
    }
}
class dAdjectiveSingle :dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling adjective words
 ------------------------------------------------------------------*/
{
    override init(){
        super.init(word: Word(), clusterType: .Adj, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: .Adj, data: data)
    }
    
    var m_isComparative = false
    var m_isSuperlative = false
    var m_bArticleExists = false
    var m_compareAdverb = ""
    var m_adjPosType = AdjectivePositionType.following
    var m_adjType         = AdjectiveType.any
    var m_superState = AdjectiveSuperState.none
    
    func setSuperState(superState: AdjectiveSuperState){
        m_superState = superState
    }
    func  setAdjectiveType (adjType : AdjectiveType){
        m_adjType = adjType
    }
    
    func setAdjectivePositionType (posType : AdjectivePositionType){m_adjPosType = posType}
    
    func getAdjectiveType()->AdjectiveType{return m_adjType}
    
    func getAdjectivePositionType()->AdjectivePositionType{return m_adjPosType}
    
    func setIsComparative (isComparative : Bool){
        m_isComparative = isComparative
    }
    
    func setIsSuperlative (isSuperlative : Bool){m_isSuperlative = isSuperlative}
    
    func isComparative ()->Bool { return m_isComparative}
    func isSuperlative ()->Bool { return m_isSuperlative}
        
    func getWordStateData()->WordStateData{
        return getSentenceData()
    }
    
    func setState(gender: Gender, number: Number){
        let sd = getSentenceData()
        sd.gender = gender
        sd.number = number
        setSentenceData(data: sd)
    }
    
    override func    getWordString()->String{
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
    func getWordStringAtLanguage(language: LanguageType)->String{
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
    
    override func getString()->String
    {
        return getWordString()
    }
    
    
}

class dAdverbSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling adverb single word cluster.
 ------------------------------------------------------------------*/
{
    override init(){
        super.init(word: Word(), clusterType: .Adv, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: .Adv, data: data)
    }
    
    var   m_adverbType = AdverbType.manner
    func aetAdverbType (advType: AdverbType){m_adverbType = advType}
    
    func getWordStringAtLanguage(language: LanguageType)->String{
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

class dAmbiguousSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling ambiguous single word clusters.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.AMB
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    
    var m_singleList = Array<dSingle>()
    var m_bestIndex = 0
    
    func append(single: dSingle){m_singleList.append(single)}
    func at(index:Int)->dSingle{return m_singleList[index]}
    
    func delete(index : Int){m_singleList.remove(at:index)}
    func  exists (single: dSingle)->Bool{return true}
    func  getSingleCount()->Int{return m_singleList.count}
    func hasMatch( ecfst : ContextFreeSymbol)->(Int, dSingle){
        let word = Word()
        let single = dSingle(word: word, clusterType: ecfst, data: WordStateData())
        return (m_bestIndex, single)
    }
    func  setBestIndex(index: Int){m_bestIndex = index}
    func  getBestIndex()->Int{return m_bestIndex}
} //dAmbiguousSingle

class dArticleSingle :  dSingle{
    var type = ContextFreeSymbol.Art
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    override func    getWordString()->String{
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
    
    override func getString()->String
    {
        return getWordString()
    }
    
} //dArticleSingle

class dConjunctionSingle :  dSingle{
    var type = ContextFreeSymbol.C
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    func getConjunctionType ()->ConjunctionType{return getSentenceData().conjunctionType }
    
    func getWordStringAtLanguage(language: LanguageType)->String{
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


class dDeterminerSingle :  dSingle{
    var type = ContextFreeSymbol.Det
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    func setState(gender: Gender, number: Number){
        let sd = getSentenceData()
        sd.gender = gender
        sd.number = number
        setSentenceData(data: sd)
    }
    
    override func getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch sd.language{
        case .Spanish, .French:
            let det = word as! RomanceDeterminer
            return det.getForm(gender: sd.gender, number: sd.number)
        case .English:
            let det = word as! EnglishDeterminer
            return det.getForm(number: sd.number)
        default: return ""
        }
    }
    
    func getWordStringAtLanguage(language: LanguageType)->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch language{
        case .Spanish:
            let det = SpanishDeterminer(word: word.spanish, type: sd.determinerType)
            return det.getForm(gender: sd.gender, number: sd.number)
        case .French:
            let det = FrenchDeterminer(word: word.french, type: sd.determinerType)
            return det.getForm(gender: sd.gender, number: sd.number)
        case .English:
            let det = EnglishDeterminer(word: word.english, type: sd.determinerType)
            return det.getForm(number: sd.number)
        default: return ""
        }
    }
    
    
} //dDeterminerSingle


class dNumberSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling number
 single word clusters.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.Num
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
}

class dParticipleSingle :  dSingle{
    var type = ContextFreeSymbol.Part
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
} //dParticipleSingle

class dPrepositionSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling noun
 single word clusters.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.P
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    func getWordStringAtLanguage(language: LanguageType)->String{
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
    
    func setPrepositionType (type: PrepositionType){m_prepositionType = type}
    func getPrepositionType ()->PrepositionType{ return m_prepositionType}
    
} //dPrepositionSingle

class dPersonalPronounSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling pronoun single.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.PersPro
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    func isSubject()->Bool{
        if getPronounType() == .SUBJECT {return true}
        return false
    }
    
    func setPronounType(pronounType: PronounType){getSentenceData().pronounType = pronounType}
    override func getPronounType()->PronounType{return getSentenceData().pronounType}
        
    func getWordStringAtLanguage(language: LanguageType)->String{
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


class dPunctuationSingle :  dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling various punctation
 types - commas, periods, question marks, exclamation marks,
 etc.
 ------------------------------------------------------------------*/
{
    var type = ContextFreeSymbol.period
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    
    var m_punctuationType = PunctuationType.none
    func setPunctuationType (type: PunctuationType){m_punctuationType = type}
    func getPunctuationType ()->PunctuationType{return m_punctuationType}
    
} //dPunctuationSingle

class dUnknownSingle : dSingle{
    var type = ContextFreeSymbol.UNK
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    /*------------------------------------------------------------------
     Purpose: provide a phrase for handling unknown single word clusters.
     ------------------------------------------------------------------*/
    
} //dUnknownSingle

