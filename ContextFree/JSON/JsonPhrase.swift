//
//  JsonNamedPhrase.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/21/21.
//

import Foundation

import UIKit

struct JsonPhrase: Codable {
    struct Cluster: Codable {
        var wordType: String  //if not named, then this is a single
        var clusterName: String?  //if named, then this is a phrase
        var isSubject: Bool
    }
    
    init(language: LanguageType, phraseType: ContextFreeSymbol, phraseName: String, clusterList : [Cluster]){
        self.language = language.rawValue
        self.phraseType = phraseType.rawValue
        self.phraseName = phraseName
        self.clusterList = clusterList
    }
    
    init(language: String, phraseType: String, phraseName: String, clusterList : [Cluster]){
        self.language = language
        self.phraseType = phraseType
        self.phraseName = phraseName
        self.clusterList = clusterList
    }
    
    init(){
        language = ""
        phraseType =  " "
        phraseName = ""
        self.clusterList = [Cluster]()
    }
    
    var language: String //agnostic means any language, otherwise it is language-specific
    var phraseType : String
    var phraseName: String
   
    var clusterList: [Cluster]
}

//create json from
class JsonPhraseManager {
    var myList = [JsonPhrase]()
    
    func printPhrases(){
        print(myList)
    }
    
    func printOne(jv: JsonPhrase){
        print(jv)
    }
    
    func encodeInternalPhrases(total: Int){
        clearPhrases()
        for v in myPhraseList{
            myList.append(v)
            print("JsonPhraseManager: appending phrase \(v.phraseName)")
            if myList.count >= total {break}
        }
        encodePhrases()
    }
    
    func getLastPhrase()->JsonPhrase{
        return myList.last!
    }
    
    func encodePhrases(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode( myList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodePhrases(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonPhrase].self, from: data){
                myList = decodedWords
            }
        }
    }
    
    func getPhraseAtName(language: String, name: String)->JsonPhrase{
        for i in 0..<myList.count {
            let v = myList[i]
            if v.language == language && v.phraseName == name { return v }
        }
        return JsonPhrase()  //empty
    }
    
    func appendPhrase(jl: JsonPhrase){
        var appendThis = true
        for i in 0..<myList.count {
            let v = myList[i]
            if v.phraseName == jl.phraseName && v.language == jl.language {
                myList.remove(at: i)
                myList.insert(jl, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myList.append(jl)}
        encodePhrases()
    }
    
    func clearPhrases(){
        myList.removeAll()
    }
    
    func getLessonAt(index: Int)->JsonPhrase{
        if index > myList.count-1 { return myList[0] }
        return myList[index]
    }
    
    func getCount()->Int{
        return myList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEPhrases").appendingPathExtension("json")
    }
    
}

var myPhraseList: [JsonPhrase] = [
    JsonPhrase(language: "Agnostic", phraseType: "NP", phraseName: "Simple article-noun phrase",
               clusterList: [
                            JsonPhrase.Cluster(wordType: "Art", isSubject: false),
                            JsonPhrase.Cluster(wordType: "N",isSubject: true)
                            ]),
    JsonPhrase(language: "Agnostic", phraseType: "NP", phraseName: "Simple article-noun-adjective phrase",
               clusterList: [
                            JsonPhrase.Cluster(wordType: "Art", isSubject: false),
                            JsonPhrase.Cluster(wordType: "N",isSubject: false),
                            JsonPhrase.Cluster(wordType: "Adj",isSubject: false)
               ]),
    JsonPhrase(language: "Agnostic", phraseType: "NP", phraseName: "Simple article-noun-adj-conj-adj phrase",
               clusterList: [
                            JsonPhrase.Cluster(wordType: "Art", isSubject: false),
                            JsonPhrase.Cluster(wordType: "N",isSubject: false),
                            JsonPhrase.Cluster(wordType: "Adj",isSubject: false),
                            JsonPhrase.Cluster(wordType: "C",isSubject: false),
                            JsonPhrase.Cluster(wordType: "Adj",isSubject: false)
               ]),
    JsonPhrase(language: "Agnostic", phraseType: "PP", phraseName: "Simple preposition phrase",
            clusterList: [
                            JsonPhrase.Cluster(wordType: "P", isSubject: false),
                            JsonPhrase.Cluster(wordType: "NP", clusterName: "Simple article-noun-adj-conj-adj phrase", isSubject: false),
                            ]),
    JsonPhrase(language: "Agnostic", phraseType: "VP", phraseName: "Simple verb phrase",
            clusterList: [
                            JsonPhrase.Cluster(wordType: "V", isSubject: false),
                            JsonPhrase.Cluster(wordType: "PP", clusterName: "Simple preposition phrase", isSubject: false),
                            ])
]
