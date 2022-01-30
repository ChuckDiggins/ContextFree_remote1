//
//  WordCollection.swift
//  WordCollection
//
//  Created by Charles Diggins on 1/8/22.
//

import Foundation

struct dWordCollection : Equatable {
    let idNum : Int
    let collectionName : String
    var wordList = [Word]()
    static func == (lhs: dWordCollection, rhs: dWordCollection) -> Bool {
        return
            lhs.collectionName == rhs.collectionName
    }
    
    init(){
        self.idNum = 0
        self.collectionName = "no name"
    }
    
    init(idNum: Int, collectionName: String, wordList: [Word]){
        self.idNum = idNum
        self.collectionName = collectionName
        self.wordList = wordList
    }
    
    mutating func appendWord(word: Word){
        wordList.append(word)
    }
    
    mutating func addWords(words: [Word])->Int{
        for word in words{
            wordList.append(word)
        }
        return wordList.count
    }
    
    func getWord(index: Int)->Word{
        if index >= 0 && index < wordList.count {
            return wordList[index]
        }
        return Word()
    }
    
    func getWordCount()->Int{
        return wordList.count
    }
    
    func getWords()->[Word]{
        return wordList
    }
    
    func getWords(wordType: WordType)->[Word]{
        var newWordList = [Word]()
        for word in wordList{
            if word.wordType == wordType{
                newWordList.append(word)
            }
        }
        return newWordList
    }
}
