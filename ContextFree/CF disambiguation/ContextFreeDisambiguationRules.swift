//
//  ContextFreeDisambiguationRules.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 4/1/21.
//

import Foundation

struct ContextFreeDisambiguateA{
    let sentence : String
    let words = Array<Word>()
    
    init(sentence: String){
        self.sentence = sentence
    }
    
    func parseSentence (){
        let util = Utilities()
        let words = util.getListOfWords(characterArray: sentence)
        
        //loop through wordStrings in sentence, casting them into Words
        
        
    }
    

    

}
