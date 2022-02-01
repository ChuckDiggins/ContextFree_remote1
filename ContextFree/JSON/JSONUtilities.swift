//
//  JSONUtilities.swift
//  JSONUtilities
//
//  Created by Charles Diggins on 1/31/22.
//

import Foundation

func getJsonWord(word: Word)->JSONWord{
    return JSONWord(spanish: word.spanish, english: word.english, french: word.french, wordType: getStringFromWordType(wordType: word.wordType))
}

func getJsonWordCollectionStructFromWordCollection(wordCollection: dWordCollection)->JSONCollectionStruct{
    var jwc = JSONCollectionStruct(idNum: wordCollection.idNum, collectionName: wordCollection.collectionName)
    for word in wordCollection.wordList{
        jwc.appendJsonWord(jw: getJsonWord(word: word))
    }
    return jwc
}

