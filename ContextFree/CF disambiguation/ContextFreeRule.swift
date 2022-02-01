//
//  ContextFreeRule.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 4/1/21.
//

import Foundation



public struct ContextFreeSymbolStruct{
    let cfs : ContextFreeSymbol
    var word : Word
    var sd : SentenceData?
    var symbolString = ""
    var head = false
    var optional = false
    var multiple = false
    
    public init(cfs: ContextFreeSymbol, word : Word){
        self.cfs = cfs
        self.word = word
        self.symbolString = self.cfs.rawValue
    }
    
    public init(cfs: ContextFreeSymbol, word : Word, isHead : Bool){
        self.cfs = cfs
        self.word = word
        self.symbolString = self.cfs.rawValue
        self.head = isHead
    }
    
    
    public init(cfs: ContextFreeSymbol, word : Word, optional: Bool, multiple: Bool){
        self.cfs = cfs
        self.word = word
        self.symbolString = self.cfs.rawValue
        self.optional = optional
        self.multiple = multiple
    }
    
    public init(){
        self.cfs = ContextFreeSymbol.UNK
        self.word = Word()
    }
    
    public func getSymbol()->ContextFreeSymbol{
        return cfs
    }
    
    public func getSymbolString()->String{
        if ( optional ){ return "( \(symbolString) )"}
        if ( multiple ){ return "\(symbolString) +"}
        return symbolString
    }
    
    public func isOptional()->Bool{
        return optional
    }
    
    public func isMultiple()->Bool{
        return multiple
    }
    
    public func isHead()->Bool{
        return head
    }
    
    public mutating func setWord(word: Word){
        self.word = word
    }
    
    public func getWord()->Word{
        return word
    }
    
    public mutating func setSentenceData(sd: SentenceData){
        self.sd = sd
    }
    
    public mutating func getSentenceData()->SentenceData{
        return sd!
    }
    
    public func getWordType()->WordType{
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

public struct ContextFreeRule{
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
    
    
    public init(start: ContextFreeSymbolStruct){
        self.headSymbolStruct = start
    }
    
    public init(start: ContextFreeSymbolStruct, name: String){
        self.headSymbolStruct = start
        ruleName = name
    }
    
    
    public func getRuleName()->String {
        return ruleName
    }
    
    public mutating func appendRule(rule: ContextFreeRule){
        ruleList.append(rule)
        bHasRules = true
    }
    
    public func hasSymbols()->Bool{
        return bHasSymbols
    }
    
    public func hasRules()->Bool{
        return bHasRules
    }
    
    
    
    public func getHeadSymbol()->ContextFreeSymbol{
        return headSymbol
    }
    

    public mutating func appendSymbolStruct(sym: ContextFreeSymbolStruct){
         cfSymbolStructList.append(sym)
         if ( sym.isHead()){headSymbol = sym.getSymbol()}
         bHasSymbols = true
     }
    
    
   
    public mutating func setSentenceDataAt(index: Int, sd: SentenceData ){
         cfSymbolStructList[index].setSentenceData(sd: sd)
     }
    
    public mutating func getSentenceDataAt(index: Int)->SentenceData{
        return cfSymbolStructList[index].getSentenceData()
    }
    
    public func getHeadCFSymbolStruct()->ContextFreeSymbolStruct{
         return headSymbolStruct
     }

    public func getHeadWordString()->String{
        return headSymbolStruct.word.word
    }
    
    public func getHeadWord()->Word{
        return headSymbolStruct.word
    }
    
    public func getHeadWordType()->WordType{
        return headSymbolStruct.getWordType()
    }
    
    public  mutating func setHeadWord(word: Word){
        headSymbolStruct.word = word
    }

   
    public func getSymbolList()->[ContextFreeSymbol]{
        var symList = [ContextFreeSymbol]()
        for sym in cfSymbolStructList {
            symList.append(sym.getSymbol())
        }
        return symList
    }
    
    public func getSymbolStrList()->[ContextFreeSymbolStruct]{
        return cfSymbolStructList
    }
    
    public func getRuleWordTypes()->[WordType]{
        var wtList = [WordType]()
        for sym in cfSymbolStructList {
            wtList.append(sym.getWordType())
        }
        return wtList
    }
    
    public func getSymbolStructCount()->Int{
        return cfSymbolStructList.count
    }
    
    public func getSymbolAt(index: Int)->ContextFreeSymbolStruct{
        return cfSymbolStructList[index]
    }
    
    public mutating func getWordAt(index: Int)->Word{
        
        return cfSymbolStructList[index].getWord()
    }
    
    public mutating func getWordStringAt(index: Int)->String{
        return cfSymbolStructList[index].getWord().word
    }

    public mutating func setWordAt(index: Int, word: Word){
        cfSymbolStructList[index].setWord(word: word)
    }
    
    
    public func getSymbolString(index: Int)->String {
        return cfSymbolStructList[index].symbolString
    }
    
    public func getComponentWordStrings()->String {
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

    public  func getSymbolString()->String {
        
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

