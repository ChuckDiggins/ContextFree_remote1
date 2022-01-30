//
//  ContextFreeClause.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

struct CFClauseA {
    var clauseType : ContextFreeSymbol
    var phraseList = Array<ContextFreeSymbol>()
    
    init(clauseType: ContextFreeSymbol, cfps: ContextFreeSymbol){
        self.clauseType = clauseType
        phraseList.append(cfps)
    }
    
    mutating func initial(cfps: ContextFreeSymbol){
        phraseList.removeAll()
        phraseList.append(cfps)
        //phraseList.append(ContextFreeSymbolType.connector)
    }
    
    mutating func append(cfps: ContextFreeSymbol){
        phraseList.append(cfps)
    }
    
    mutating func getClauseString(){
        var clauseString = ""
        for phrase in phraseList {
            clauseString += "->"
            //clauseString = clauseString + phrase.getRuleString()
        }
    }

}
