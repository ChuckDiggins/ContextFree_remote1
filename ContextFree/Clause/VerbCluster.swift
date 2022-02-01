//
//  VerbCluster.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/15/21.
//

import Foundation

public class dVerbPhrase : dPhrase {
    var type = ContextFreeSymbol.VP
    public override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_toBe = false
    var m_isConjugated = false
    var m_isPerfect = false
    var m_computedTense = Tense.present
    var m_computedPerson = Person.S1
    var m_subjectCluster = dCluster(word: Word(), clusterType: .PersPro)
 
    var m_verbType = VerbType.normal
    public func setVerbType(type: VerbType ){m_verbType = type}
    public func getVerbType()->VerbType{return m_verbType}
    
    public func setSubjectCluster(cluster: dCluster){m_subjectCluster = cluster}
    public func getSubjectCluster()->dCluster{return m_subjectCluster}
    
    public override func setPerson(value: Person){
        for cluster in getClusterList(){
            if cluster.getClusterType() == .V {
                let v = cluster as! dVerbSingle
                v.setPerson(value: value)
            }
            if cluster.getClusterType() == .VP {
                let vp = cluster as! dVerbPhrase
                vp.setPerson(value: value)
            }
        }
    }
    
    public override func getPerson()->Person{
        for cluster in getClusterList(){
            if cluster.getClusterType() == .V {
                let v = cluster as! dVerbSingle
                return v.getPerson()
            }
            if cluster.getClusterType() == .VP {
                let vp = cluster as! dVerbPhrase
                return vp.getPerson()
            }
        }
        return .S1
    }
    
    
    public override func setTense(value: Tense){
        for cluster in getClusterList(){
            if cluster.getClusterType() == .V {
                let v = cluster as! dVerbSingle
                v.setTense(value: value)
            }
            if cluster.getClusterType() == .VP {
                let vp = cluster as! dVerbPhrase
                vp.setTense(value: value)
            }
            
        }
    }
    
    public override func getTense()->Tense{
        for cluster in getClusterList(){
            if cluster.getClusterType() == .V {
                let v = cluster as! dVerbSingle
                return v.getTense()
            }
            if cluster.getClusterType() == .VP {
                let vp = cluster as! dVerbPhrase
                return vp.getTense()
            }
        }
        return .infinitive
    }
    

    
    /*
    func setComputedTense(tense: Tense){m_computedTense = tense}
    func getComputedTense()->Tense{return m_computedTense}
    func setComputedPerson(person: Person){m_computedPerson = person}
    func getComputedPerson()->Person{return m_computedPerson}
    */
    
    public func isConjugated()->Bool{return m_isConjugated}
    public func isToBe()->Bool{return m_toBe}
    public func isPerfect()->Bool{return m_isPerfect}

}

public class dVerbSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling verb single word clusters.
 ------------------------------------------------------------------*/
{
    public override init(){
        super.init(word: Word(), clusterType: .V, data: WordStateData())
    }
    
    public init(word: Word, data: WordStateData){
        super.init(word: word, clusterType: .V, data: data)
    }
    
    var    m_toBe = false
    var    m_isPerfect = false
    var    m_bestPreposition = ""

    var    m_verbType = VerbType.normal
    var    m_isConjugated = false
    var    m_auxiliaryType = AuxiliaryType.IS
    var    m_modalAuxiliaryType = AuxiliaryType.can
    var    m_isPassive = false
    var    m_isAuxiliary = false
    
    public func   setIsAuxillary(flag : Bool){m_isAuxiliary = flag}
    public func   setIsConjugated(flag : Bool){m_isConjugated = flag}
    public func   isConjugated()->Bool{return m_isConjugated}
    public func   isToBe()->Bool{return m_toBe}
    public func   isPerfect()->Bool{return m_isPerfect}
    
    
    //func    processCompoundTense(){flag = true}
    public func    setAuxiliaryType(type:AuxiliaryType){m_auxiliaryType = type}
    public func    getAuxiliaryType()->AuxiliaryType{return m_auxiliaryType}
    public func    getModalAuxiliaryType()->AuxiliaryType{return m_modalAuxiliaryType}
    public func    isPassive()->Bool{return m_isPassive}
    public func    setPassive(flag: Bool){m_isPassive = flag}
    public func    constructPassiveTense(tense : Tense){}
    
    public func    extractActiveTense()->Tense{return .present}
    
    public func    setBestPrep(word: String){m_bestPreposition = word}
    public func    getBestPrep()->String{return m_bestPreposition}
    public func    setVerbType (type: VerbType){m_verbType = type}
    public func    getVerbType ()->VerbType{return m_verbType}
    
    public func    setBVerb(bVerb: BVerb)
    {
        let bv = getClusterWord() as! Verb
        bv.setBVerb(bVerb: bVerb)
    }
    
    public func    getBVerb(bVerb: BVerb)->BVerb
    {
        let bv = getClusterWord() as! Verb
        return bv.getBVerb()
    }
    
    public func getLanguageString(language: LanguageType)->String{
        
        let v = getClusterWord() as! Verb
        switch language{
        case .Spanish:
            return v.spanish
        case .French:
            return v.french
        case .English:
            return v.english
        default:
            return ""
        }
    }
    
    public func getPhraseVerb()->String{
        return ""
    }
    
    public override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        switch sd.language {
        case .Spanish, .French:
            let verb = word as! RomanceVerb
            return verb.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
        case .English:
            let verb = word as! EnglishVerb
            return verb.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
        default:
            return ""
        }
    }
    
    public override func getString()->String
    {
        return getWordString()
    }
    public func    getString( tense: Tense,  clusterString: SentenceWordList)->String{return ""}
    public func    getString( tense: Tense,  clusterString: SentenceWordList, subj : dNounSingle)->String{return ""}
    
    
} //dVerbSingle

public class dSpanishVerbSingle : dVerbSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling verb single word clusters.
 ------------------------------------------------------------------*/
{
    public override init(){
        super.init()
    }
    
    public override init(word: Word, data: WordStateData){
        super.init(word: word, data: data)
    }

    public override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        let verb = word as! SpanishVerb
        return verb.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
    }
    

}

public class dFrenchVerbSingle : dVerbSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling verb single word clusters.
 ------------------------------------------------------------------*/
{
    public override init(){
        super.init()
    }
    
    public override init(word: Word, data: WordStateData){
        super.init(word: word, data: data)
    }

    public override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        let verb = word as! FrenchVerb
        return verb.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
    }
    

}

