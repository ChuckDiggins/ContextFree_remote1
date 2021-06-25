//
//  JsonDeterminers.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/20/21.
//

import Foundation

//
//  JsonAdjectives.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/19/21.
//

import Foundation

import UIKit

class JsonDeterminer: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var determinerType: String  //"D" - demonstrative (this), "P" possessive (my), "A" any
    var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    init(spanish: String, english: String, french: String, determinerType : String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.determinerType = determinerType
    }
}

var myMultiLingualDeterminerList: [JsonDeterminer] = [
    JsonDeterminer(spanish: "un", english: "a",    french: "un", determinerType : "I"),
    JsonDeterminer(spanish: "el", english: "the",    french: "le", determinerType : "D"),
    JsonDeterminer(spanish: "mi", english: "my",    french: "mon", determinerType : "P"),
    //JsonDeterminer(spanish: "este", english: "this",    french: "ce", determinerType : "M"),
    //JsonDeterminer(spanish: "ese", english: "that",    french: "ce", determinerType : "M"),
    //JsonDeterminer(spanish: "que", english: "what",    french: "que", determinerType : "N"),
    ]


//create json from
class JsonDeterminerManager {
    var myWordList = [JsonDeterminer]()
    
    func printWords(){
        print(myWordList)
    }
    
    func printOne(jv: JsonDeterminer){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        for v in myMultiLingualDeterminerList{
            myWordList.append(v)
            print("JsonDeterminerManager: appending determiner \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func getLastWord()->JsonDeterminer{
        return myWordList.last!
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedDets = try? encoder.encode(myWordList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedDets.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonDeterminer].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(det: JsonDeterminer){
        var appendThis = true
        for i in 0..<myWordList.count {
            let v = myWordList[i]
            if v.spanish == det.spanish && v.french == det.french {
                myWordList.remove(at: i)
                myWordList.insert(det, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myWordList.append(det)}
        encodeWords()
    }
    
    func clearWords(){
        myWordList.removeAll()
    }
    
    func getWordAt(index: Int)->JsonDeterminer{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualDeterminers").appendingPathExtension("json")
    }
    
}

