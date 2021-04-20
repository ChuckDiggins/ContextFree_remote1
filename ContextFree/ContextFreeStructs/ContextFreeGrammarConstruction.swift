//
//  ContextFreeGrammarConstruction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/10/21.
//

import Foundation

struct ContextFreeGrammarConstruction{
    mutating func createSomeNounPhraseGrammar()->ContextFreeGrammar{
        var grammar = ContextFreeGrammar(name: "Noun Phrases", description: "Handles all the phrases starting with NP", grammarType : .noun)
        
        var cfr : ContextFreeRule
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .SubjP, word: Word(), isHead: true))
        grammar.addRule(cfr: cfr)
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Art, word: Word(), optional: true, multiple: false))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .N, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Adj, word: Word(), optional: true, multiple: false))
        grammar.addRule(cfr: cfr)
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .SubjP, word: Word(), isHead: true))
        grammar.addRule(cfr: cfr)
        
        
        /*
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Art, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .N, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Adj, word: Word()))
        grammar.addRule(cfr: cfr)

        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Art, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .N, word: Word(), isHead: true))
        grammar.addRule(cfr: cfr)

        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Art, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .N, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Adj, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .PP, word: Word()))
        grammar.addRule(cfr: cfr)
        */
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .NP, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .PP, word: Word(), optional: false, multiple: false))
        grammar.addRule(cfr: cfr)
        
        /*
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .N, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Adj, word: Word()))
        
        grammar.addRule(cfr: cfr)
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .NP, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Adj, word: Word()))
        
        grammar.addRule(cfr: cfr)
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .NP, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .PP, word: Word()))
        
        */
        
        print(grammar.name)
        grammar.printRules()
        return grammar
    }
    
    mutating func createSomePrepositionalPhraseGrammar()->ContextFreeGrammar{
        
        var grammar = ContextFreeGrammar(name: "Prepositional Phrases", description: "Handles all the phrases starting with PP", grammarType : .preposition)
        var cfr : ContextFreeRule
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .PP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .P, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        grammar.addRule(cfr: cfr)
        
        print(grammar.name)
        grammar.printRules()
        return grammar
        
    }
    
    mutating func createSomeVerbPhraseGrammar()->ContextFreeGrammar{
        
        var cfr : ContextFreeRule
        
        var grammar = ContextFreeGrammar(name: "Verb Phrases", description: "Handles all the phrases starting with VP", grammarType : .noun)
       
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .VP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .V, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .NP, word: Word()))
        grammar.addRule(cfr: cfr)
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .VP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .V, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .PP, word: Word()))
        grammar.addRule(cfr: cfr)
        
        
        
        cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .VP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .VP, word: Word(), isHead: true))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .PP, word: Word()))
        grammar.addRule(cfr: cfr)
        
        print(grammar.name)
        grammar.printRules()
        
        return grammar
    }
    
    mutating func createSomeAdjectivePhraseGrammar()->ContextFreeGrammar{
        
        var grammar = ContextFreeGrammar(name: "Adjective Phrases", description: "Handles all the phrases starting with AP", grammarType : .noun)
        var cfr = ContextFreeRule(start: ContextFreeSymbolStruct(cfs: .AP, word: Word()))
        cfr.appendSymbolStruct(sym: ContextFreeSymbolStruct(cfs: .Adj, word: Word(), isHead: true))
        grammar.addRule(cfr: cfr)
        
        print(grammar.name)
        grammar.printRules()
        
        return grammar
    }
    
}
