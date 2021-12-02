//
//  ContextFreeRule.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 4/1/21.
//

import Foundation



struct ContextFreeSymbolStruct{
    let cfs : ContextFreeSymbol
    var word : Word
    var sd : SentenceData?
    var symbolString = ""
    var head = false
    var optional = false
    var multiple = false
    
    init(cfs: ContextFreeSymbol, word : Word){
        self.cfs = cfs
        self.word = word
        self.symbolString = self.cfs.rawValue
    }
    
    init(cfs: ContextFreeSymbol, word : Word, isHead : Bool){
        self.cfs = cfs
        self.word = word
        self.symbolString = self.cfs.rawValue
        self.head = isHead
    }
    
    
    init(cfs: ContextFreeSymbol, word : Word, optional: Bool, multiple: Bool){
        self.cfs = cfs
        self.word = word
        self.symbolString = self.cfs.rawValue
        self.optional = optional
        self.multiple = multiple
    }
    
    init(){
        self.cfs = ContextFreeSymbol.UNK
        self.word = Word()
    }
    
    func getSymbol()->ContextFreeSymbol{
        return cfs
    }
    
    func getSymbolString()->String{
        if ( optional ){ return "( \(symbolString) )"}
        if ( multiple ){ return "\(symbolString) +"}
        return symbolString
    }
    
    func isOptional()->Bool{
        return optional
    }
    
    func isMultiple()->Bool{
        return multiple
    }
    
    func isHead()->Bool{
        return head
    }
    
    mutating func setWord(word: Word){
        self.word = word
    }
    
    func getWord()->Word{
        return word
    }
    
    mutating func setSentenceData(sd: SentenceData){
        self.sd = sd
    }
    
    mutating func getSentenceData()->SentenceData{
        return sd!
    }
    
    func getWordType()->WordType{
        switch cfs {
        case .N: return .noun
        case .V: return .verb
        case .Art: return .article
        case .Adj: return .adjective
        case .Adv: return .adverb
        case .P: return .preposition
        case .NP: return .noun
        case .VP: return .verb
        case .AdvP: return .adverb
        case .PP: return .preposition
        default: return .unknown
        }
    }
    
}

//headSymbolStruct is the struct associated with this rule
//headSymbol is the ContextFreeSymbol associated with the head struct in cfSymbolStructList
//for example, a ContextFreeRule of type NP should contain a component struct of type either NP or N

struct ContextFreeRule{
    var headSymbolStruct : ContextFreeSymbolStruct
    var cfSymbolStructList = Array<ContextFreeSymbolStruct>()
    //var sdList = Array<SentenceData>()
    var ruleList = Array<ContextFreeRule>()
    var bHasSymbols = false
    var bHasRules = false
    var ruleName = ""
    
    //this is the CFSymbol associate with the append struct that declares itself as head
    //set during appendSymbol
    var headSymbol = ContextFreeSymbol.UNK
    
    
    init(start: ContextFreeSymbolStruct){
        self.headSymbolStruct = start
    }
    
    init(start: ContextFreeSymbolStruct, name: String){
        self.headSymbolStruct = start
        ruleName = name
    }
    
    
    func getRuleName()->String {
        return ruleName
    }
    
    mutating func appendRule(rule: ContextFreeRule){
        ruleList.append(rule)
        bHasRules = true
    }
    
    func hasSymbols()->Bool{
        return bHasSymbols
    }
    
    func hasRules()->Bool{
        return bHasRules
    }
    
    
    
    func getHeadSymbol()->ContextFreeSymbol{
        return headSymbol
    }
    

     mutating func appendSymbolStruct(sym: ContextFreeSymbolStruct){
         cfSymbolStructList.append(sym)
         if ( sym.isHead()){headSymbol = sym.getSymbol()}
         bHasSymbols = true
     }
    
    
   
     mutating func setSentenceDataAt(index: Int, sd: SentenceData ){
         cfSymbolStructList[index].setSentenceData(sd: sd)
     }
    
    mutating func getSentenceDataAt(index: Int)->SentenceData{
        return cfSymbolStructList[index].getSentenceData()
    }
    
     func getHeadCFSymbolStruct()->ContextFreeSymbolStruct{
         return headSymbolStruct
     }

    func getHeadWordString()->String{
        return headSymbolStruct.word.word
    }
    
    func getHeadWord()->Word{
        return headSymbolStruct.word
    }
    
    func getHeadWordType()->WordType{
        return headSymbolStruct.getWordType()
    }
    
    mutating func setHeadWord(word: Word){
        headSymbolStruct.word = word
    }

   
    func getSymbolList()->[ContextFreeSymbol]{
        var symList = [ContextFreeSymbol]()
        for sym in cfSymbolStructList {
            symList.append(sym.getSymbol())
        }
        return symList
    }
    
    func getSymbolStrList()->[ContextFreeSymbolStruct]{
        return cfSymbolStructList
    }
    
    func getRuleWordTypes()->[WordType]{
        var wtList = [WordType]()
        for sym in cfSymbolStructList {
            wtList.append(sym.getWordType())
        }
        return wtList
    }
    
    func getSymbolStructCount()->Int{
        return cfSymbolStructList.count
    }
    
    func getSymbolAt(index: Int)->ContextFreeSymbolStruct{
        return cfSymbolStructList[index]
    }
    
    mutating func getWordAt(index: Int)->Word{
        
        return cfSymbolStructList[index].getWord()
    }
    
    mutating func getWordStringAt(index: Int)->String{
        return cfSymbolStructList[index].getWord().word
    }

    mutating func setWordAt(index: Int, word: Word){
        cfSymbolStructList[index].setWord(word: word)
    }
    
    
    func getSymbolString(index: Int)->String {
        return cfSymbolStructList[index].symbolString
    }
    
    func getComponentWordStrings()->String {
        var cfString = "Phrase words "
        let count = cfSymbolStructList.count
        if ( count > 0 ){
            cfString += ContextFreeSymbol.arrow.rawValue + " "
        }
        for symbolStr in cfSymbolStructList {
            let word = symbolStr.word
            cfString += word.word + " "
        }
        return cfString
    }

    func getSymbolString()->String {
        
        var cfString = headSymbolStruct.getSymbolString()
        let count = cfSymbolStructList.count
        if ( count > 0 ){
            cfString += ContextFreeSymbol.arrow.rawValue + " "
        }
        for symbolStr in cfSymbolStructList {
            cfString += symbolStr.symbolString + " "
        }
        return cfString
    }

    
}

