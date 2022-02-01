//
//  JSONPronouns.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/29/21.
//

import Foundation

//Chuck 11/25
import UIKit

public class JsonPronoun: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var pronounType: String  //"S" - subject, "DO" -direct object, "A" any
    public var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    public init(spanish: String, english: String, french: String, pronounType : String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.pronounType = pronounType
    }
}

var myMultiLingualPronounList: [JsonPronoun] = [
    JsonPronoun(spanish: "yo", english: "I",    french: "je", pronounType : "S"),   //subject pronoun
    JsonPronoun(spanish: "me", english: "me",    french: "me", pronounType : "DO"),  //direct object pronoun
    JsonPronoun(spanish: "me", english: "me",    french: "me", pronounType : "IO"),  //indirect object pronoun
    JsonPronoun(spanish: "mí", english: "me",    french: "moi", pronounType : "P"),  //prepositional pronoun
    JsonPronoun(spanish: "me", english: "myself",    french: "me", pronounType : "R"),  //indirect object pronoun   
    ]


//create json from
public class JsonPronounManager {
    var myWordList = [JsonPronoun]()
    
    public func printWords(){
        print(myWordList)
    }
    
    public func printOne(jv: JsonPronoun){
        print(jv)
    }
    
    public func encodeInternalWords(total: Int){
        clearWords()
        for v in myMultiLingualPronounList{
            myWordList.append(v)
//            print("JsonPronounManager: appending determiner \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    public func getLastWord()->JsonPronoun{
        return myWordList.last!
    }
    
    public func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedDets = try? encoder.encode(myWordList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedDets.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    public func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonPronoun].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    public func appendWord(det: JsonPronoun){
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
    
    public func clearWords(){
        myWordList.removeAll()
    }
    
    public func getWordAt(index: Int)->JsonPronoun{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    public func getWordCount()->Int{
        return myWordList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualPronouns").appendingPathExtension("json")
    }
    
}


