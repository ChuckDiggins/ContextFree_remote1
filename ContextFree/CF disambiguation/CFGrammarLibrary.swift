//
//  CFGrammarLibrary.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/10/21.
//

import Foundation

struct CFGrammarLibrary {
    var nounPhraseGrammar = ContextFreeGrammar()
    var verbPhraseGrammar = ContextFreeGrammar()
    var prepositionalPhraseGrammar = ContextFreeGrammar()
    var adjectivePhraseGrammar = ContextFreeGrammar()
}

struct GnosticGrammarLibrary {
    let language : LanguageType
    init(language: LanguageType )
    {
        self.language = language
    }
    
    var nounPhraseGrammar = ContextFreeGrammar()
    var verbPhraseGrammar = ContextFreeGrammar()
    var prepositionalPhraseGrammar = ContextFreeGrammar()
    var adjectivePhraseGrammar = ContextFreeGrammar()
}

