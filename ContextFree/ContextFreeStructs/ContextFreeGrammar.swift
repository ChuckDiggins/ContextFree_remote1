//
//  ContextFreeGrammar.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 4/1/21.
//

import Foundation

enum GrammarType{
    case adjective
    case noun
    case verb
    case preposition
    case special
    case unknown
}


struct ContextFreeGrammarManager{
    var cfGrammarList = Array<ContextFreeGrammar>()
    
    mutating func addGrammar(cfg: ContextFreeGrammar){
        cfGrammarList.append(cfg)
    }
    
    func getGrammar(type: GrammarType)->ContextFreeGrammar{
        for grammar in cfGrammarList {
            if grammar.grammarType == type {
                return grammar
            }
        }
        return ContextFreeGrammar(name: "", description: "", grammarType: .unknown)
    }
    
    func getGrammarList()->Array<ContextFreeGrammar>{
        return cfGrammarList
    }
}

struct ContextFreeGrammar {
    var name: String
    var description : String
    var grammarType : GrammarType
    var cfRuleList = Array<ContextFreeRule>()
    
    init (name: String, description: String, grammarType: GrammarType){
        self.name = name
        self.description  = description
        self.grammarType = grammarType
    }
    
    init (){
        self.name = ""
        self.description  = ""
        self.grammarType = .unknown
    }
    
    func getName()->String{
        return name
    }
    
    func getDescription()->String{
        return description
    }
    
    mutating func addRule(cfr: ContextFreeRule){
        cfRuleList.append(cfr)
    }
    
    func getRuleCount()->Int{
        return cfRuleList.count
    }
    
    func printRules(){
        for rule in cfRuleList {
            print ("Rule: \(rule.getSymbolString())")
        }
    }
    

}

