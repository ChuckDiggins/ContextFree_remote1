//
//  JSONCollection.swift
//  JSONCollection
//
//  Created by Charles Diggins on 1/27/22.
//

import Foundation


class JSONCollectionManager: Codable {
     
    var myCollectionList = [JSONCollectionStruct]()
    
    func printWords(){
        print(myCollectionList)
    }
    
    func printOne(jv: JSONCollectionStruct){
        print(jv)
    }
    
    func convertWordCollectionsToJSONCollectionStructsAndEncode(wordCollectionList : [dWordCollection]){
        myCollectionList.removeAll()
        for collection in wordCollectionList{
            let jwcs = getJsonWordCollectionStructFromWordCollection(wordCollection: collection)
            myCollectionList.append(jwcs)
        }
        encodeWords()
    }
    
    func encodeWordCollections(total: Int){
        clearWords()
        let storedCollectionList = [threeSimpleVerbsCollection, carpenterWordCollection]
        
        for collection in storedCollectionList{
            myCollectionList.append(collection)
            if myCollectionList.count >= total {break}
            
            print("encodeWordCollection \(collection.collectionName)")
        }
        encodeWords()
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
//        if let encodedPreps = try? encoder.encode(collectionName){
//            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
//        }
        if let encodedPreps = try? encoder.encode(myCollectionList){
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }

    func getWordCollections()->[JSONCollectionStruct]{
        guard let data = try? Data(contentsOf: getURL()) else {
            fatalError("Could not convert data")
        }
        let decoder = JSONDecoder()
        guard let wordCollectionData = try? decoder.decode([JSONCollectionStruct].self, from: data) else {
            fatalError("There was a problem decoding the data ... ")
        }
        myCollectionList = wordCollectionData
        return wordCollectionData
    }
    
//    func decodeWords(){
//        let decoder = JSONDecoder()
//
//        if let data = try? Data.init(contentsOf: getURL()){
//            if let decodedWords = try? decoder.decode([myCollectionList].self, from: data){
//                myCollectionList = decodedWords
//            }
//        }
//    }

    func appendCollection(collection: JSONCollectionStruct){
        var appendThis = true
        for i in 0..<myCollectionList.count {
            let c = myCollectionList[i]
            if c.collectionName == collection.collectionName {
                myCollectionList.remove(at: i)
                myCollectionList.insert(collection, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myCollectionList.append(collection)}
        encodeWords()
    }
    func clearWords(){
        myCollectionList.removeAll()
    }
    
    func getJSONCollectionAt(index: Int)->JSONCollectionStruct{
        if index > myCollectionList.count-1 { return myCollectionList[0] }
        return myCollectionList[index]
    }
    
    func getCollectionNameAt(index: Int)->String{
        if index > myCollectionList.count-1 {
            return myCollectionList[0].collectionName  //need a default
        }
        else {
//            let collection = myCollectionList[index]
            return myCollectionList[index].collectionName
        }
    }
    
    func getCollectionCount()->Int{
        return myCollectionList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("JSONWordCollectionManager").appendingPathExtension("json")
    }
    
}

