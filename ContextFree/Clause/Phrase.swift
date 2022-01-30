//
//  Phrase.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/14/21.
//

import Foundation


class dPhrase : dCluster {
    override init(word: Word, clusterType : ContextFreeSymbol, data: WordStateData){
        super.init(word: word, clusterType: clusterType, data: data)
    }
    
    override init(){
        super.init(word: Word(), clusterType: .UNK)
    }
    
    private var m_randomWord : RandomWordLists!
    
    init(randomWord:RandomWordLists, phraseName: String, phraseType: ContextFreeSymbol){
        m_randomWord = randomWord
        super.init(word: Word(), clusterType: phraseType, data: WordStateData())
        setClusterName(name: phraseName)
    }
    
    func setRandomWordList(randomWordList: RandomWordLists){
        m_randomWord = randomWordList
    }
    
    var m_cfr = ContextFreeRule(start: ContextFreeSymbolStruct())
    func getClusterAtFunction(fn: ContextFreeFunction)->dCluster{
        for cluster in getClusterList(){
            if cluster.getClusterFunction() == fn {return cluster}
        }
        return dCluster()
    }

    func dumpClusterInfo(str: String){
        print(str)
        //let npSentenceData = getSentenceData()
        for cluster in getClusterList(){
            let sd = cluster.getSentenceData()
            let sym = cluster.getClusterType()
            switch sym {
            case .Det:
                    let det = cluster as! dDeterminerSingle
                    let ds = det.getWordString()
                    print("determiner: \(ds) - sd.processedWord: \(sd.getProcessedWord())")
            case .Adj:
                    let det = cluster as! dAdjectiveSingle
                    let ds = det.getWordString()
                    print("adjective: \(ds) - sd.processedWord: \(sd.getProcessedWord())")
            case .N:
                    let n = cluster as! dNounSingle
                    let ds = n.getWordString()
                    print("noun: \(ds) - sd.processedWord: \(sd.getProcessedWord())")
            case  .P:
                    let p = cluster as! dPrepositionSingle
                    let ds = p.getWordString()
                    print("preposition: \(ds) - sd.processedWord: \(sd.getProcessedWord())")
            case  .V:
                    let v = cluster as! dVerbSingle
                    let ds = v.getWordString()
                    print("preposition: \(ds) - sd.processedWord: \(sd.getProcessedWord())")
            case .VP:
                let vp = cluster as! dVerbPhrase
                vp.dumpClusterInfo(str: str)
            case .NP:
                let np = cluster as! dNounPhrase
                np.dumpClusterInfo(str: str)
            case .PP:
                let pp = cluster as! dPrepositionPhrase
                pp.dumpClusterInfo(str: str)
            default: break
            }
        }
    }
    
    func createNewRandomPhrase(){
        var index = 0
        var newCluster = dCluster()
        var newClusterWord = Word()
        var replaceClusterWord = false
        for cluster in getClusterList(){
            replaceClusterWord = false
            if cluster.getAssociatedWordListCount()>0 {
                cluster.replaceClusterWordWithRandomAssociatedWord()
                newClusterWord = cluster.m_clusterWord
                replaceClusterWord = true
//                print("createNewPhrase: type \(cluster.getClusterType().rawValue): newWord \(newClusterWord.spanish)" )
            }
            //let single = cluster as! dSingle
            newCluster = m_randomWord.getAgnosticRandomWordAsSingle(wordType: cluster.getClusterType(), isSubject:false)
            if replaceClusterWord {
                newCluster.m_clusterWord = newClusterWord
                newCluster.putAssociatedWordList(wordList: cluster.getAssociatedWordList())
            }
            replaceCluster(index: index, cluster: newCluster)
                //print("createNewRandomPhrase: index\(index), wordString = \(cluster.getStringAtLanguage(language: .Spanish))")
            index += 1
        }
    }
    
    func getReconstructedPhraseString(language: LanguageType)->String {
        var ss = ""
        var str = ""
    
        for cluster in getClusterList() {
            let type = cluster.getClusterType()
            switch type {
            case .NP:
                let c = cluster as! dNounPhrase
                c.reconcileForLanguage(language: language)  //informs all member clusters of number, gender, etc
                str = c.getStringAtLanguage(language: language)
            case .PP:
                let c = cluster as! dPrepositionPhrase
                str = c.getStringAtLanguage(language: language)
            case .VP:
                let c = cluster as! dVerbPhrase
                str = c.getStringAtLanguage(language: language)
            default:
                str = ""
                
            }
            ss += str + " "
            
        }
        
        return ss
    }
   

    func getFirstSingle()->dSingle{
        if getFirstCluster().getClusterType().isSingle() {
            //let single = getFirstCluster() as! dSingle
            return getFirstCluster() as! dSingle
        }
        return dSingle()
    }
    
    func getLastSingle()->dSingle{
        if getLastCluster().getClusterType().isSingle() {
            //let single = getFirstCluster() as! dSingle
            return getLastCluster() as! dSingle
        }
        return dSingle()
    }
    func setRule(rule: ContextFreeRule){m_cfr = rule}
    
    func getString( wordList : SentenceWordList)->String{
        var wordListCopy = wordList
        return wordListCopy.getString()
    }

    override func hasClusterFunction(fn: ContextFreeFunction) -> Bool {
        for cluster in getClusterList(){
            if cluster.getClusterFunction() == fn {return true}
        }
        return false
    }
    
    
    func getEquivalentPronounString(language: LanguageType, type: PronounType)->String{
        switch language{
        case .Spanish:
            let p = SpanishPronoun(word: "", type: type)
            return p.getForm(gender: getGender(), person: getPerson())
        case .French:
            let p = FrenchPronoun(word: "", type: type)
            return p.getForm(gender: getGender(), person: getPerson())
        case .English:
            let p = EnglishPronoun(word: "", type: type)
            return p.getForm(gender: getGender(), person: getPerson())
        default: return ""
        }
    }

    func getEquivalentPronoun(language: LanguageType, type: PronounType)->Pronoun{
        switch language{
        case .Spanish:
            return SpanishPronoun(word: "", type: type)
        case .French:
            return FrenchPronoun(word: "", type: type)
        case .English:
            return EnglishPronoun(word: "", type: type)
        default: return Pronoun()
        }
    }

   
    func getSingleList(inputSingleList: [dSingle])->[dSingle]{
        var singleList = inputSingleList
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                let single = cluster as! dSingle
                if ( type == .N){
                    singleList.append(single)
                }
                else if ( type == .V){
                    singleList.append(single)
                }
                else if ( type == .PersPro){
                    singleList.append(single)
                }
                else if ( type == .Det){
                    singleList.append(single)
                }
                else if ( type == .Adj){
                    singleList.append(single)
                }
                else
                {
                    singleList.append(single)
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    singleList = c.getSingleList(inputSingleList: singleList)
                case .VP:
                    let c = cluster as! dVerbPhrase
                    singleList = c.getSingleList(inputSingleList: singleList)
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    singleList = c.getSingleList(inputSingleList: singleList)
                default: break
                }
            }
        }
        return singleList
    }
    
    func getWordStateList(inputWordList: [WordStateData])->[WordStateData]{
        var wordList = inputWordList
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    //let c = cluster as! dNounSingle
                    wordList.append(cluster.getSentenceData())
                }
                else if ( type == .V){
                    let sd = cluster.getSentenceData()
                    wordList.append(sd)
                }
                else if ( type == .PersPro){
                    //let c = cluster as! dPersonalPronounSingle
                    wordList.append(cluster.getSentenceData())
                }
                else if ( type == .Det){
                    //let c = cluster as! dArticleSingle
                    wordList.append(cluster.getSentenceData())
                }
                else {
                    wordList.append(cluster.getSentenceData())
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    wordList = c.getWordStateList(inputWordList: wordList)
                case .VP:
                    let c = cluster as! dVerbPhrase
                    wordList = c.getWordStateList(inputWordList: wordList)
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    wordList = c.getWordStateList(inputWordList: wordList)
                default: break
                }
            }
        }
        return wordList
    }
    
    func processInfo(){
        let parentClusterType = getClusterType()
        
        if getClusterType() == .NP {
            let np = self as! dNounPhrase
            let ns = np.getNounSingle()
            np.setNumber(value: ns.getNumber())
            np.setGender(value: ns.getGender())
        }
        let gender = getGender()
        let number = getNumber()
        
        for cluster in getClusterList() {
            cluster.setParentClusterType(clusterType: parentClusterType)
            let clusterType = cluster.getClusterType()
            switch clusterType {
            case .Det:
                let c = cluster as! dDeterminerSingle
                c.setGender(value: gender)
                c.setNumber(value: number)
            case .Adj:
                let c = cluster as! dAdjectiveSingle
                c.setGender(value: gender)
                c.setNumber(value: number)
            case .Num:
                let c = cluster as! dNumberSingle
                setNumber(value: c.getNumber())
            case .PersPro:
                let c = cluster as! dPersonalPronounSingle
                c.setGender(value: gender)
                c.setNumber(value: number)
            case .N:
                setPerson(value: cluster.getPerson())
                setGender(value: cluster.getGender())
                setNumber(value: cluster.getNumber())
            case .NP:
                setPerson(value: cluster.getPerson())
                setGender(value: cluster.getGender())
                setNumber(value: cluster.getNumber())
                let c = cluster as! dNounPhrase
                c.processInfo()
            case .PP:
                setPerson(value: cluster.getPerson())
                setGender(value: cluster.getGender())
                setNumber(value: cluster.getNumber())
                let c = cluster as! dPrepositionPhrase
                c.processInfo()
            case .VP:
                let c = cluster as! dVerbPhrase
                c.processInfo()
            default:
                setTense(value: .present)
            }
        }
    }
    
    func getStringAtLanguage(language: LanguageType )->String{
        var str = ""
        
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    let c = cluster as! dNounSingle
                    let ns = c.getWordStringAtLanguage(language: language)
                    str += ns + " "
                    c.setProcessWordInWordStateData(language: language, str: ns)
                }
                else if ( type == .V){
                    var conjStr = ""
                    let c = cluster as! dVerbSingle
                    let sd = c.getSentenceData()
                    switch language{
                    case .Spanish:
                        let v = c.getClusterWord()
                        let fv = SpanishVerb(word:  v.spanish, type: sd.verbType)
                        let bv = BSpanishVerb(verbPhrase: v.spanish)
                        let verbModel = m_spanishVerbModelConjugation.getVerbModel(verbWord: bv.m_verbWord)
                        bv.setPatterns(verbModel : verbModel)
                        fv.setBVerb(bVerb: bv)
                        conjStr = fv.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
                        str += conjStr + " "
                    case .French:
                        let v = c.getClusterWord()
                        let fv = FrenchVerb(word:  v.french, type: sd.verbType)
                        let bv = BFrenchVerb(verbPhrase: v.french)
                        let verbModel = m_frenchVerbModelConjugation.getVerbModel(verbWord: bv.m_verbWord)
                        bv.setPatterns(verbModel : verbModel)
                        fv.setBVerb(bVerb: bv)
                        conjStr = fv.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
                        str += conjStr + " "
                    case .English:
                        let v = c.getClusterWord()
                        let ev = EnglishVerb(word:  v.english, type: sd.verbType)
                        let bv = BEnglishVerb(verbPhrase: v.english, separable: .separable)
                        let verbModel = m_englishVerbModelConjugation.getVerbModel(verbWord: bv.m_verbWord)
                        bv.setModel(verbModel : verbModel)
                        ev.setBVerb(bVerb: bv)
                        conjStr = ev.getConjugateForm(tense: sd.tense, person: sd.person, showResidualPhrase: true)
                        str += conjStr + " "
                    default:
                        str += "unknown language in dPhrase"
                    }
                    c.setProcessWordInWordStateData(language: language, str: conjStr)

                }
                else if ( type == .Det){
                    let c = cluster as! dDeterminerSingle
                    let ds = c.getWordStringAtLanguage(language: language)
                    str +=  ds + " "
                    c.setProcessWordInWordStateData(language: language, str: ds)
                }
                else if ( type == .Adj){
                    let c = cluster as! dAdjectiveSingle
                    let adjStr = c.getWordStringAtLanguage(language: language)
                    str += adjStr + " "
                    c.setProcessWordInWordStateData(language: language, str: adjStr)
                }
                else if ( type == .Adv){
                    let c = cluster as! dAdverbSingle
                    let advStr = c.getWordStringAtLanguage(language: language)
                    str += advStr + " "
                    c.setProcessWordInWordStateData(language: language, str: advStr)
                }
                else if ( type == .C){
                    let c = cluster as! dConjunctionSingle
                    let conjStr = c.getWordStringAtLanguage(language: language)
                    str += conjStr + " "
                    c.setProcessWordInWordStateData(language: language, str: conjStr)
                }
                else if ( type == .P){
                    let c = cluster as! dPrepositionSingle
                    let prepStr = c.getWordStringAtLanguage(language: language)
                    str += prepStr + " "
                    c.setProcessWordInWordStateData(language: language, str: prepStr)
                }
                else if ( type == .PersPro){
                    let c = cluster as! dPersonalPronounSingle
                    let pronounStr = c.getWordStringAtLanguage(language: language)
                    str += pronounStr + " "
                    c.setProcessWordInWordStateData(language: language, str: pronounStr)
                }
                else {
                    let single = cluster as! dSingle
                    let singleStr = single.getString()
                    str += singleStr + " "
                    single.setProcessWordInWordStateData(language: language, str: singleStr)
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    str += c.getStringAtLanguage(language: language) + " "
                case .VP:
                    let c = cluster as! dVerbPhrase
                    str += c.getStringAtLanguage(language: language) + " "
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    str += c.getStringAtLanguage(language: language) + " "
                default:
                    str += ""
                }
            }
        }
        
        return str
    }

    func getString( )->String{
        var str = ""
        //var tempStr = ""
        
        for cluster in getClusterList(){
            let type = cluster.getClusterType()
            if cluster.getClusterType().isSingle()
            {
                if ( type == .N){
                    let c = cluster as! dNounSingle
                    str += c.getString() + " "
                    c.setProcessWordInWordStateData(str: c.getString())
                }
                else if ( type == .V){
                    var c = cluster as! dVerbSingle
                    switch getSentenceData().language{
                    case .Spanish:
                        c = cluster as! dSpanishVerbSingle
                        str += c.getString() + " "
                    case .French:
                        c = cluster as! dFrenchVerbSingle
                        str += c.getString() + " "
                    default:
                        str += "unknown language in dPhrase"
                    }
                    c.setProcessWordInWordStateData(str: c.getString())

                }
                else if ( type == .Det){
                    let c = cluster as! dDeterminerSingle
                    str += c.getWordString() + " "
                    c.setProcessWordInWordStateData(str: c.getWordString())
                }
                else if ( type == .PersPro){
                    let c = cluster as! dPersonalPronounSingle
                    str += c.getString() + " "
                    c.setProcessWordInWordStateData(str: c.getString())
                }
                else {
                    let single = cluster as! dSingle
                    let singleStr = single.getString()
                    str += singleStr + " "
                    single.setProcessWordInWordStateData(str: singleStr)
                }
                
            }
            else if cluster.getClusterType().isPhrase()
            {
                switch cluster.getClusterType(){
                case .NP:
                    let c = cluster as! dNounPhrase
                    str += c.getString() + " "
                case .VP:
                    let c = cluster as! dVerbPhrase
                    str += c.getString() + " "
                case .PP:
                    let c = cluster as! dPrepositionPhrase
                    str += c.getString() + " "
                default:
                    str += ""
                }
            }
        }
        
        return str
    }

}

class dAdjectivePhrase : dPhrase {
    var type = ContextFreeSymbol.AP
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_adjectiveType = AdjectiveType.any
    func setAdjectiveType(type: AdjectiveType){m_adjectiveType = type}
    func getAdjectiveType()->AdjectiveType{return m_adjectiveType}
}


class dAdverbPhrase : dPhrase {
    var type = ContextFreeSymbol.AdvP
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_adverbType = AdverbType.manner
    func setAdverbType(type: AdverbType){m_adverbType = type}
    func getAdverbType()->AdverbType{return m_adverbType}
}

class dPrepositionPhrase : dPhrase {
    var type = ContextFreeSymbol.PP
    override init(){
        super.init(word: Word(), clusterType: type, data: WordStateData())
    }
    
    init(word: Word, data: WordStateData ){
        super.init(word: word, clusterType: type, data: data)
    }
    
    var m_isInfinitive  = false
    var m_isPersonal   = false
    var isPossessive = false
    var isSuppressPrep  = false
    var m_prepositionType = PrepositionType.general;
    
    func setPrepositionType (type : PrepositionType){m_prepositionType = type}
    func getPrepositionType()->PrepositionType{return m_prepositionType}
    
    func setIsPersonal (flag : Bool){m_isPersonal = flag}
    func getIsPersonal()->Bool{return m_isPersonal}
    func setIsInfinitive (flag : Bool){m_isInfinitive = flag}
    func getIsInfinitive()->Bool{return m_isInfinitive}
    func setIsPossessive (flag : Bool){isPossessive = flag}
    func getIsPossessive()->Bool{return isPossessive}
    func setIsSuppressPrep (flag : Bool){isSuppressPrep = flag}
    func getIsSuppressPrep()->Bool{return isSuppressPrep}
    
    func reconcileForLanguage(language: LanguageType){
        for cluster in getClusterList(){
            let sym = cluster.getClusterType()
            if ( sym == .Art || sym == .Adj ){
                let data = getSentenceData()
                cluster.setGender(value: data.gender)
                cluster.setNumber(value: data.number)
                let sd = cluster.getSentenceData()
                sd.gender = data.gender
                sd.number = data.number
                cluster.setSentenceData(data: sd)
            }
            else if sym == .NP {
                let np = cluster as! dNounPhrase
                np.reconcileForLanguage(language: language)
            }
            else if sym == .PP {
                let pp = cluster as! dPrepositionPhrase
                pp.reconcileForLanguage(language: language)
            }
        }
    }
    
    func reconcile(){
        for cluster in getClusterList(){
            let sym = cluster.getClusterType()
            if ( sym == .Art || sym == .Adj ){
                let data = getSentenceData()
                cluster.setGender(value: data.gender)
                cluster.setNumber(value: data.number)
                let sd = cluster.getSentenceData()
                sd.gender = data.gender
                sd.number = data.number
                cluster.setSentenceData(data: sd)
            }
            else if sym == .NP {
                let np = cluster as! dNounPhrase
                np.reconcile()
            }
            else if sym == .PP {
                let pp = cluster as! dPrepositionPhrase
                pp.reconcile()
            }
        }
    }
    

    func appendThisCluster(cluster : dCluster){
        switch(cluster.getClusterType()){
        case .P:
            let prep = cluster as! dPrepositionSingle

            setPrepositionType(type: prep.getPrepositionType())
        case .N:
            let noun = cluster as! dNounSingle
            if ( noun.getNounType() == .person ){ setIsPersonal(flag: true)}
        case .NP:
            let noun = cluster as! dNounPhrase
            if ( noun.getNounType() == NounType.any ){ setIsPersonal(flag: true)}
            noun.reconcile()
        case .PersPro:
             setIsPersonal(flag: true)
        default:
            appendCluster(cluster: cluster)
        }
        appendCluster(cluster: cluster)
    }
}



