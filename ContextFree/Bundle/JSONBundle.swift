//
//  JSONBundle.swift
//  JSONBundle
//
//  Created by Charles Diggins on 1/28/22.
//

import Foundation

public struct JSONBundle : Codable, CustomStringConvertible {
    var idNum: Int
//    var language : String
    var teacher : String
    var bundleName : String
    var tenseList = [String]()
    var collectionList = [JSONCollectionStruct]()
    var phraseList = [JSONNamedLoadedPhrase]()
    
    public var description: String {
        return "\(self.bundleName) : tenseList =\(tenseList.count), phraseList = \(phraseList.count)"
    }
    
    public init(idNum: Int, teacher: String, bundleName: String,  tenseList : [String], collectionList : [JSONCollectionStruct], phraseList : [JSONNamedLoadedPhrase] ){
        self.idNum = idNum
//        self.language = language
        self.teacher = teacher
        self.bundleName = bundleName
        self.collectionList = collectionList  //word collection
        self.tenseList = tenseList
        self.phraseList = phraseList
    }
    
    public func printThyself(){
        print("\(idNum) - \(bundleName)")
        var i = 0
        for collection in collectionList {
            print("Collection \(i)- \(collection.idNum), \(collection.collectionName)")
            i += 1
        }
    }
    
    public func convertFromJSONToJLingCollection(jsonCollection: JSONCollectionStruct)->dWordCollection{
        var wordList = [Word]()
        for jsonWord in jsonCollection.wordList {
            let wordType = getWordTypeFromString(str: jsonWord.wordType)
            let word = Word(word: jsonWord.spanish, spanish: jsonWord.spanish, french: jsonWord.french, english: jsonWord.english, wordType: wordType)
            wordList.append(word)
        }
        return dWordCollection(idNum: jsonCollection.idNum, collectionName: jsonCollection.collectionName, wordList: wordList)
    }
}

