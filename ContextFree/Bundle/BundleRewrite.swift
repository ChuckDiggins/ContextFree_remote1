//
//  Bundle.swift
//  Bundle
//
//  Created by Charles Diggins on 1/30/22.
//

import Foundation

struct dBundleRewrite{
//    var idNum: Int
////    var language : String
//    var teacher : String
//    var bundleName : String
//    var tenseList = [String]()
//    var collectionList = [JSONCollectionStruct]()
//    var phraseList = [JSONNamedLoadedPhrase]()
    var idNum: Int
    var teacher: String
    var bundleName: String
    var tenseList = [Tense]()
    var collectionList = [dWordCollection]()
    var phraseList = [dCluster]()
    
    init(){
        self.idNum = 0
        self.teacher = "no teacher"
        self.bundleName = "no name"
    }
    
    init(idNum: Int, teacher: String, bundleName: String, tenseList : [Tense], collectionList: [dWordCollection], phraseList: [dCluster]){
        self.idNum = idNum
        self.teacher = teacher
        self.bundleName = bundleName
        self.tenseList = tenseList
        self.phraseList = phraseList
    }
    
    func getTeacher()->String{
        return teacher
    }
    
    func getBundleName()->String{
        return bundleName
    }
    
    func getTenseList()->[Tense]{
        return tenseList
    }
    
    func getWordCollectionList()->[dWordCollection]{
        return collectionList
    }
    
    func getPhraseList()->[dCluster]{
        return phraseList
    }
    
    mutating func setWordCollectionList(collectionList: [dWordCollection]){
        self.collectionList = collectionList
    }
    
    mutating func setPhraseList(phraseList: [dCluster]){
        self.phraseList = phraseList
    }
}
