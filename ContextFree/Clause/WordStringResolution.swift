//
//  WordStringResolution.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/28/21.
//

import Foundation

public struct WordStringResolution {
    
    // tests whether the input word is a progressive with pronouns attached.
    // for example, "comprándonoslos"
    // if so,
    // 1.  result.0 is true
    // 2.  result.1 is the progressive with the accented letter replaced ---> "comprando"
    // 3.  result.2 is the pronoun suffix ---> "noslos" (this has to be disambiguated in another func)
    
    public mutating func containsProgressiveAndAppendedObjectPronounSuffixes(word: String)->(Bool, String, String, String){
        var result : (Bool, String, String)
        var str = ""
        var pronounSuffix = ""
        
        result = removeBuriedProgressiveEndingAndReturnPronounSuffix(word: word, buriedString: "ándo", replacementString: "ando")
        if result.0 {
            str = result.1
            pronounSuffix = result.2
        }
        else {
            result = removeBuriedProgressiveEndingAndReturnPronounSuffix(word: word, buriedString: "éndo", replacementString: "endo")
            if result.0 {
                str = result.1
                pronounSuffix = result.2
            }
            else {
                result = removeBuriedProgressiveEndingAndReturnPronounSuffix(word: word, buriedString: "índo", replacementString: "indo")
                if result.0 {
                    str = result.1
                    pronounSuffix = result.2
                }
                else {
                    return (false, "", "", "")
                }
            }
        }
        let result2 = processPronounSuffix(word: pronounSuffix)
        return (true, str, result2.0, result2.1)
    }

    public mutating func processPronounSuffix(word: String)->(String, String){
        
        //comprándomelos  - buying them for me
        
        var indirect = word  //indirect object pronoun
        var direct = word  //direct object pronoun
        
        //if only one word, then it must be a direct object
        
        let suffixCount = word.count
        if ( suffixCount < 4){
            return ("", direct)
        }
        
        //if 4 letters, then it's two and two
        if ( suffixCount == 4){
            indirect.removeLast(2)
            direct.removeFirst(2)
            return (indirect, direct)
        }
        
        //if suffixCount = 5, then figure out 3-2 or 2-3
        
        // for example, "noslo"
        
        if ( suffixCount == 5 ){
            var workingStr = word
            workingStr.removeLast(2)
            if workingStr == "nos" || workingStr == "les" {
                indirect = workingStr    //"noslo" -> "nos"
                direct.removeFirst(3)     //"noslo" -> "lo"
            }
            else {
                indirect.removeLast(3)   //"melas" -> "me"
                direct.removeFirst(2)    //"melas" -> "las"
            }
            return (indirect, direct)
        }
        
        //if 6 letters (or more), than this must be three and three
        indirect.removeLast(3)
        direct.removeFirst(3)
        return (indirect, direct)
    }

    public mutating func removeBuriedProgressiveEndingAndReturnPronounSuffix(word: String, buriedString: String, replacementString: String)->(Bool, String, String){
        var str = word
        let result = VerbUtilities().doesWordContainSubstring(inputString: str, subString: buriedString)
        if result.0 {
            let suffixCount = str.count - result.2
            let pronounSuffix = String(str.suffix(suffixCount))
            //remove the suffix
            str.removeLast(suffixCount)
            //remove the accented progressiveEnding
            str.removeLast(buriedString.count)
            //attach the unaccented progressiveEnding
            str += replacementString
            return (true, str, pronounSuffix)
        }
        return (false, "", "")
    }
    
        
}
