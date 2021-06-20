//
//  JSONPrepositions.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/19/21.
//

import Foundation

import Foundation

import UIKit

class JsonPreposition: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var prepositionType: String  //"D" - demonstrative (this), "P" possessive (my), "A" any
    var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    init(spanish: String, english: String, french: String, prepositionType : String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.prepositionType = prepositionType
    }
}

var jsonPrepositionList: [JsonPreposition] = [
    JsonPreposition(spanish: "a", english: "to",    french: "à", prepositionType : "S"),
    JsonPreposition(spanish: "en", english: "in", french: "dans", prepositionType : "S"),
    JsonPreposition(spanish: "de", english: "of", french: "de", prepositionType : "G"),
    JsonPreposition(spanish: "desde", english: "from", french: "depuis", prepositionType : "S"),
    JsonPreposition(spanish: "con", english: "with", french: "avec", prepositionType : "G"),
    JsonPreposition(spanish: "para", english: "for", french: "pour", prepositionType : "G"),
    JsonPreposition(spanish: "por", english: "through", french: "par", prepositionType : "G"),
    JsonPreposition(spanish: "sin", english: "without", french: "sans", prepositionType : "G"),
    JsonPreposition(spanish: "contra", english: "against", french: "contre", prepositionType : "G"),
    JsonPreposition(spanish: "sobre", english: "over", french: "sur", prepositionType : "S"),
    JsonPreposition(spanish: "a través de", english: "across", french: "à travers", prepositionType : "S"),
    JsonPreposition(spanish: "al lado de", english: "next to", french: "à côté de", prepositionType : "S"),
    JsonPreposition(spanish: "más allá de", english: "beyond", french: "au delà de", prepositionType : "S"),
    JsonPreposition(spanish: "acerca de", english: "concerning", french: "a sujet de", prepositionType : "S"),
    JsonPreposition(spanish: "encima de", english: "above", french: "au-dessus de", prepositionType : "S"),
    JsonPreposition(spanish: "abajo de", english: "below", french: "au bas de", prepositionType : "S"),
]


//create json from
class JsonPrepositionManager {
    var myWordList = [JsonPreposition]()
    
    func printWords(){
        print(myWordList)
    }
    
    func printOne(jv: JsonPreposition){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        for v in jsonPrepositionList{
            myWordList.append(v)
            print("JsonPrepositionManager: appending preposition \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func getLastWord()->JsonPreposition{
        return myWordList.last!
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode(myWordList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonPreposition].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(prep: JsonPreposition){
        var appendThis = true
        for i in 0..<myWordList.count {
            let v = myWordList[i]
            if v.spanish == prep.spanish && v.french == prep.french {
                myWordList.remove(at: i)
                myWordList.insert(prep, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myWordList.append(prep)}
        encodeWords()
    }
    
    func clearWords(){
        myWordList.removeAll()
    }
    
    func getWordAt(index: Int)->JsonPreposition{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualPrepositions").appendingPathExtension("json")
    }
    
}

