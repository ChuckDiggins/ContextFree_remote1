//
//  WordCollectionManager.swift
//  WordCollectionManager
//
//  Created by Charles Diggins on 1/11/22.
//

import Foundation

struct dWordCollectionManager{
    private var collectionList = Array<dWordCollection>()
    
    mutating func append(collection: dWordCollection){
        if !doesExist(collection: collection) {
            collectionList.append(collection)
        }
    }
    
    func getCount()->Int{
        return collectionList.count
    }
    
    func getCollectionList()->[dWordCollection]{
        return collectionList
    }
    
    func getCollection(index: Int)->dWordCollection{
        if index < collectionList.count { return collectionList[index]}
        return dWordCollection()
    }
    
    func doesExist(collection: dWordCollection)->Bool{
        for c in collectionList {
            if collection == c {return true}
        }
        return false
    }
    
    func getCollectionByName(collectionName: String)->dWordCollection{
        for collection in collectionList{
            if collection.collectionName == collectionName {return collection}
        }
        return dWordCollection()
    }
}
