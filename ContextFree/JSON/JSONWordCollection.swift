//
//  JSONWordCollection.swift
//  JSONWordCollection
//
//  Created by Charles Diggins on 1/11/22.
//

import Foundation


public struct JSONWord : Codable, CustomStringConvertible {
    var spanish: String
    var english: String
    var french: String
    var wordType: String
    public  var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    public func getWord()->Word{
        let word = Word(word: spanish, spanish: spanish, french: french, english: english, wordType: getWordTypeFromString(str: wordType))
        return word
    }
    
    
}

public struct JSONCollectionStruct : Codable, CustomStringConvertible {
    var idNum: Int
    var collectionName : String
    var wordList = [JSONWord]()
    public var description: String {
        return "\(self.collectionName) : wordCount =\(wordList.count)"
    }
    
    public init(idNum: Int, collectionName: String, wordList : [JSONWord]){
        self.idNum = idNum
        self.collectionName = collectionName
        self.wordList = wordList
    }
    
    public init(idNum: Int, collectionName: String){
        self.idNum = idNum
        self.collectionName = collectionName
    }
    
    public mutating func appendJsonWord(jw: JSONWord){
        wordList.append(jw)
    }
    
    public func printThyself(){
        print("\(idNum) - \(collectionName)")
        var i = 0
        for word in wordList {
            print("Word \(i)- \(word.spanish), \(word.english), \(word.french)")
            i += 1
        }
    }
    
    public func convertToJLingCollection()->dWordCollection{
        var newWordList = [Word]()
        for jsonWord in wordList {
            let wordType = getWordTypeFromString(str: jsonWord.wordType)
            let word = Word(word: jsonWord.spanish, spanish: jsonWord.spanish, french: jsonWord.french, english: jsonWord.english, wordType: wordType)
            newWordList.append(word)
        }
        return dWordCollection(idNum: idNum, collectionName: collectionName, wordList: newWordList)
    }
}

public class JSONWordCollection: Codable {
     
    var myWordList = [JSONWord]()
    
    public func printWords(){
        print(myWordList)
    }
    
    public func printOne(jv: JSONWord){
        print(jv)
    }
    
    public func encodeInternalWords(total: Int){
        clearWords()
        let wordList = CarpenterWordList
        
        for v in wordList{
            myWordList.append(v)
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    public func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode(myWordList){
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    public func decodeWords(){
        let decoder = JSONDecoder()
        
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JSONWord].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    public func appendWord(jw: JSONWord){
        var appendThis = true
        for i in 0..<myWordList.count {
            let v = myWordList[i]
            if v.spanish == jw.spanish && v.french == jw.french && v.english == jw.english{
                myWordList.remove(at: i)
                myWordList.insert(jw, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myWordList.append(jw)}
        encodeWords()
    }
    public func clearWords(){
        myWordList.removeAll()
    }
    
    public func getJsonWordAt(index: Int)->JSONWord{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    public func getWordAt(index: Int)->Word{
        if index > myWordList.count-1 {
            return Word()
        }
        else {
            let jsonWord = myWordList[index]
            let wordType = getWordTypeFromString(str: jsonWord.wordType)
            return Word(word: jsonWord.spanish, spanish: jsonWord.spanish, french: jsonWord.french, english: jsonWord.english, wordType: wordType)
        }
    }
    
    public func getWordCount()->Int{
        return myWordList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEWordCollection").appendingPathExtension("json")
    }
    
}

