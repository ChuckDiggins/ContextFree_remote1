//
//  CFModelView.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

class CFModelView: ObservableObject {
    private var cfModel : CFModel = CFModel()
    
    init(){
    }
    
    func getGrammarLibrary()->CFGrammarLibrary{
        return cfModel.getGrammarLibrary()
    }
    
    func createIndependentClause(clauseString: String)->dIndependentClause{
        return cfModel.createIndependentClause(clauseString: clauseString)
    }
}
