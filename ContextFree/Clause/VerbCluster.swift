//
//  VerbCluster.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/15/21.
//

import Foundation

class dVerbPhrase : dPhrase {
    var type = ContextFreeSymbol.VP
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_toBe = false
    var m_isConjugated = false
    var m_isPerfect = false
    var m_computedTense = Tense.present
    var m_computedPerson = Person.S1
    var m_subjectCluster = dCluster(word: Word(), clusterType: .PersPro)
 
    var m_verbType = VerbType.normal
    func setVerbType(type: VerbType ){m_verbType = type}
    func getVerbType()->VerbType{return m_verbType}
    
    func setSubjectCluster(cluster: dCluster){m_subjectCluster = cluster}
    func getSubjectCluster()->dCluster{return m_subjectCluster}
    
    override func setPerson(value: Person){
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
    
    override func getPerson()->Person{
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
    
    
    override func setTense(value: Tense){
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
    
    override func getTense()->Tense{
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
    
    func isConjugated()->Bool{return m_isConjugated}
    func isToBe()->Bool{return m_toBe}
    func isPerfect()->Bool{return m_isPerfect}

}

class dVerbSingle : dSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling verb single word clusters.
 ------------------------------------------------------------------*/
{
    override init(){
        super.init(word: Word(), clusterType: .V, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData){
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
    
    func   setIsAuxillary(flag : Bool){m_isAuxiliary = flag}
    func   setIsConjugated(flag : Bool){m_isConjugated = flag}
    func   isConjugated()->Bool{return m_isConjugated}
    func   isToBe()->Bool{return m_toBe}
    func   isPerfect()->Bool{return m_isPerfect}
    
    
    //func    processCompoundTense(){flag = true}
    func    setAuxiliaryType(type:AuxiliaryType){m_auxiliaryType = type}
    func    getAuxiliaryType()->AuxiliaryType{return m_auxiliaryType}
    func    getModalAuxiliaryType()->AuxiliaryType{return m_modalAuxiliaryType}
    func    isPassive()->Bool{return m_isPassive}
    func    setPassive(flag: Bool){m_isPassive = flag}
    func    constructPassiveTense(tense : Tense){}
    
    func    extractActiveTense()->Tense{return .present}
    
    func    setBestPrep(word: String){m_bestPreposition = word}
    func    getBestPrep()->String{return m_bestPreposition}
    func    setVerbType (type: VerbType){m_verbType = type}
    func    getVerbType ()->VerbType{return m_verbType}
    
    func    setBVerb(bVerb: BVerb)
    {
        let bv = getClusterWord() as! Verb
        bv.setBVerb(bVerb: bVerb)
    }
    
    func    getBVerb(bVerb: BVerb)->BVerb
    {
        let bv = getClusterWord() as! Verb
        return bv.getBVerb()
    }
    
    func getLanguageString(language: LanguageType)->String{
        
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
    
    func getPhraseVerb()->String{
        return ""
    }
    
    override func    getWordString()->String{
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
    
    override func getString()->String
    {
        return getWordString()
    }
    func    getString( tense: Tense,  clusterString: SentenceWordList)->String{return ""}
    func    getString( tense: Tense,  clusterString: SentenceWordList, subj : dNounSingle)->String{return ""}
    
    
} //dVerbSingle

class dSpanishVerbSingle : dVerbSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling verb single word clusters.
 ------------------------------------------------------------------*/
{
    override init(){
        super.init()
    }
    
    override init(word: Word, data: WordStateData){
        super.init(word: word, data: data)
    }

    override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        let verb = word as! SpanishVerb
        return verb.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
    }
    

}

class dFrenchVerbSingle : dVerbSingle
/*------------------------------------------------------------------
 Purpose: provide a phrase for handling verb single word clusters.
 ------------------------------------------------------------------*/
{
    override init(){
        super.init()
    }
    
    override init(word: Word, data: WordStateData){
        super.init(word: word, data: data)
    }

    override func    getWordString()->String{
        let sd = getSentenceData()
        let word = getClusterWord()
        let verb = word as! FrenchVerb
        return verb.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
    }
    

}

