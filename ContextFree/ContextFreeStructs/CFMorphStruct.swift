//
//  CFMorphStruct.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/5/21.
//

import Foundation


struct CFMorphStep {
    var index : Int = -1
    var phraseForm : String = ""
    var comment1 : String = ""
    var comment2 : String = ""
    var comment3 : String = ""
    var part1 : String = ""
    var part2 : String = ""
    var part3: String = ""
    
    func getStrings()->(String, String, String){
        return (part1, part2, part3)
    }
    
    func getComments()->(String, String, String){
        return (comment1, comment2, comment3)
    }
}

//all the morphsteps should relate to a single person
class CFMorphStruct {
    init(){
        var ms = CFMorphStep()
        append(morphStep: ms)
    }
    var currentIndex = 0
    var morphArray = [CFMorphStep]()
    func clear(){ morphArray.removeAll() }
    func count()->Int { return morphArray.count}
    func append( morphStep : CFMorphStep ){
        morphArray.append(morphStep)
    }
    
    func getMorphStep(index : Int)-> CFMorphStep {
            if index == 0 || index < morphArray.count { return morphArray[index]}
            return CFMorphStep()
    }
}
