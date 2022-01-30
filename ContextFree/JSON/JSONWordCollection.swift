//
//  JSONWordCollection.swift
//  JSONWordCollection
//
//  Created by Charles Diggins on 1/11/22.
//

import Foundation

struct JSONWord : Codable, CustomStringConvertible {
    var spanish: String
    var english: String
    var french: String
    var wordType: String
    var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    func getWord()->Word{
        let word = Word(word: spanish, spanish: spanish, french: french, english: english, wordType: getWordTypeFromString(str: wordType))
        return word
    }
}

struct JSONCollectionStruct : Codable, CustomStringConvertible {
    var idNum: Int
    var collectionName : String
    var wordList = [JSONWord]()
    var description: String {
        return "\(self.collectionName) : wordCount =\(wordList.count)"
    }
    
    init(idNum: Int, collectionName: String, wordList : [JSONWord]){
        self.idNum = idNum
        self.collectionName = collectionName
        self.wordList = wordList
    }
    
    func printThyself(){
        print("\(idNum) - \(collectionName)")
        var i = 0
        for word in wordList {
            print("Word \(i)- \(word.spanish), \(word.english), \(word.french)")
            i += 1
        }
    }
    
    func convertToJLingCollection()->dWordCollection{
        var newWordList = [Word]()
        for jsonWord in wordList {
            let wordType = getWordTypeFromString(str: jsonWord.wordType)
            let word = Word(word: jsonWord.spanish, spanish: jsonWord.spanish, french: jsonWord.french, english: jsonWord.english, wordType: wordType)
            newWordList.append(word)
        }
        return dWordCollection(idNum: idNum, collectionName: collectionName, wordList: newWordList)
    }
}

class JSONWordCollection: Codable {
     
    var myWordList = [JSONWord]()
    
    func printWords(){
        print(myWordList)
    }
    
    func printOne(jv: JSONWord){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        let wordList = CarpenterWordList
        
        for v in wordList{
            myWordList.append(v)
            //print("JSONWordCollection: appending word \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
//        if let encodedPreps = try? encoder.encode(collectionName){
//            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
//        }
        if let encodedPreps = try? encoder.encode(myWordList){
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JSONWord].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(jw: JSONWord){
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
    func clearWords(){
        myWordList.removeAll()
    }
    
    func getJsonWordAt(index: Int)->JSONWord{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordAt(index: Int)->Word{
        var word = Word()
        if index > myWordList.count-1 {
            return Word()
        }
        else {
            let jsonWord = myWordList[index]
            let wordType = getWordTypeFromString(str: jsonWord.wordType)
            return Word(word: jsonWord.spanish, spanish: jsonWord.spanish, french: jsonWord.french, english: jsonWord.english, wordType: wordType)
        }
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEWordCollection").appendingPathExtension("json")
    }
    
}

