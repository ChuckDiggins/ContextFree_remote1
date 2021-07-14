//
//  JSONConjunctions.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/28/21.
//

import Foundation

class JsonConjunction: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var conjunctionType: String  //"D" - demonstrative (this), "P" possessive (my), "A" any
    var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    init(spanish: String, english: String, french: String, conjunctionType : String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.conjunctionType = conjunctionType
    }
}

var myMultiLingualConjunctionList: [JsonConjunction] = [
    // C - coordinating
    JsonConjunction(spanish: "y", english: "and",    french: "et", conjunctionType: "C"),
    JsonConjunction(spanish: "pero", english: "but",    french: "mais", conjunctionType: "C"),
    JsonConjunction(spanish: "o", english: "or",    french: "ou", conjunctionType: "C"),
    JsonConjunction(spanish: "entonces", english: "so",    french: "alors", conjunctionType: "C"),
    
    // S - subordinating - connect a dependent clause to a main clause
    JsonConjunction(spanish: "como", english: "since",    french: "come", conjunctionType: "S"),
    JsonConjunction(spanish: "porque", english: "because",    french: "car", conjunctionType: "S"),
    JsonConjunction(spanish: "si", english: "if",    french: "si", conjunctionType: "S"),
    JsonConjunction(spanish: "que", english: "that",    french: "que", conjunctionType: "S"),
    
    ]

//create json from
class JsonConjunctionManager {
    var myWordList = [JsonConjunction]()
    
    func printWords(){
        print(myWordList)
    }
    
    func printOne(jv: JsonAdverb){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        for v in myMultiLingualConjunctionList{
            myWordList.append(v)
            print("JsonPrepositionManager: appending conjunction \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func getLastWord()->JsonConjunction{
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
            if let decodedWords = try? decoder.decode([JsonConjunction].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(c: JsonConjunction){
        var appendThis = true
        for i in 0..<myWordList.count {
            let v = myWordList[i]
            if v.spanish == c.spanish && v.french == c.french && v.english == c.english{
                myWordList.remove(at: i)
                myWordList.insert(c, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myWordList.append(c)}
        encodeWords()
    }
    
    func clearWords(){
        myWordList.removeAll()
    }
    
    func getWordAt(index: Int)->JsonConjunction{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualConjunctions").appendingPathExtension("json")
    }
    
}



