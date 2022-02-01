//
//  JsonNamedPhrase.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/21/21.
//

import Foundation

import UIKit

public struct JSONNamedLoadedPhrase: Codable {
    var language: String //agnostic means any language, otherwise it is language-specific
    var phraseType : String
    var phraseName: String
    var wordList =  [JSONWord]()  //for use when this is a single
    var isSingle = false
    var clusterList: [Cluster]
    
    public struct Cluster: Codable {
        var wordType: String  //if not named, then this is a single
        var clusterName: String?  //if named, then this is a phrase
        var isSubject: Bool
    }
    
    public init(language: LanguageType, phraseType: ContextFreeSymbol, phraseName: String, clusterList : [Cluster], wordList : [JSONWord]){
        self.language = language.rawValue
        self.phraseType = phraseType.rawValue
        self.phraseName = phraseName
        self.clusterList = clusterList
        self.wordList = wordList
    }
    
    public  init(language: LanguageType, phraseType: ContextFreeSymbol, phraseName: String, clusterList : [Cluster]){
        self.language = language.rawValue
        self.phraseType = phraseType.rawValue
        self.phraseName = phraseName
        self.clusterList = clusterList
    }
    
    public init(language: String, phraseType: String, phraseName: String, clusterList : [Cluster]){
        self.language = language
        self.phraseType = phraseType
        self.phraseName = phraseName
        self.clusterList = clusterList
    }
    
    public init(){
        language = ""
        phraseType =  " "
        phraseName = ""
        self.clusterList = [Cluster]()
    }
    
    public func createCluster()->dCluster{
        var newCluster = dCluster()
        
        switch phraseType{
        case "NP": newCluster = dNounPhrase()
        case "VP": newCluster = dVerbPhrase()
        case "N":
            newCluster = dNounSingle()
        case "V": newCluster = dVerbSingle()
        default: break
        }
        if clusterList.count > 0 {
            var subCluster = dCluster()
            for _ in clusterList {
                switch phraseType{
                case "NP": subCluster = dNounPhrase()
                case "VP": subCluster = dVerbPhrase()
                case "PP": subCluster = dPrepositionPhrase()
                case "N": subCluster = dNounSingle()
                case "V": subCluster = dVerbSingle()
                case "Adj": subCluster = dAdjectiveSingle()
                case "Det": subCluster = dDeterminerSingle()
                case "P": subCluster = dPrepositionSingle()
                default: break
                }
                newCluster.appendCluster(cluster: subCluster)
            }
        }
        return newCluster
    }
    
    public func wordListCount()->Int{
        return wordList.count
    }
}

//create json from
public class JsonPhraseManager {
    var myList = [JSONNamedLoadedPhrase]()
    
    public func printPhrases(){
        print(myList)
    }
    
    public func printOne(jv: JSONNamedLoadedPhrase){
        print(jv)
    }
    
    public func encodeInternalPhrases(total: Int){
        clearPhrases()
        for v in myPhraseList{
            myList.append(v)
            print("JsonPhraseManager: appending phrase \(v.phraseName)")
            if myList.count >= total {break}
        }
        encodePhrases()
    }
    
    public func getLastPhrase()->JSONNamedLoadedPhrase{
        return myList.last!
    }
    
    public func encodePhrases(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode( myList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    public func decodePhrases(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JSONNamedLoadedPhrase].self, from: data){
                myList = decodedWords
            }
        }
    }
    
    public func getPhraseAtName(language: String, name: String)->JSONNamedLoadedPhrase{
        for i in 0..<myList.count {
            let v = myList[i]
            if v.language == language && v.phraseName == name { return v }
        }
        return JSONNamedLoadedPhrase()  //empty
    }
    
    public func appendPhrase(jl: JSONNamedLoadedPhrase){
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
    
    public func clearPhrases(){
        myList.removeAll()
    }
    
    public func getLessonAt(index: Int)->JSONNamedLoadedPhrase{
        if index > myList.count-1 { return myList[0] }
        return myList[index]
    }
    
    public func getCount()->Int{
        return myList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEPhrases").appendingPathExtension("json")
    }
    
    
}

var myPhraseList: [JSONNamedLoadedPhrase] = [
    JSONNamedLoadedPhrase(language: .Agnostic, phraseType: .N, phraseName: "Breakfast noun single",
               clusterList: [
                JSONNamedLoadedPhrase.Cluster(wordType: "N",isSubject: true)
               ],
                          wordList : [
                               JSONWord(spanish: "pimienta", english: "pepper",    french: "poivre", wordType: "noun"),
                               JSONWord(spanish: "azúcar", english: "sugar",    french: "sucre", wordType: "noun"),
                          ]),
    
    JSONNamedLoadedPhrase(language: "Agnostic", phraseType: "NP", phraseName: "Simple article-noun phrase",
               clusterList: [
                            JSONNamedLoadedPhrase.Cluster(wordType: "Art", isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "N",isSubject: true)
                            ]),
    
    JSONNamedLoadedPhrase(language: "Agnostic", phraseType: "NP", phraseName: "Simple article-noun-adjective phrase",
               clusterList: [
                            JSONNamedLoadedPhrase.Cluster(wordType: "Art", isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "N",isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "Adj",isSubject: false)
               ]),
    
    JSONNamedLoadedPhrase(language: "Agnostic", phraseType: "NP", phraseName: "Simple article-noun-adj-conj-adj phrase",
               clusterList: [
                            JSONNamedLoadedPhrase.Cluster(wordType: "Art", isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "N",isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "Adj",isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "C",isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "Adj",isSubject: false)
               ]),
    
    JSONNamedLoadedPhrase(language: "Agnostic", phraseType: "PP", phraseName: "Simple preposition phrase",
            clusterList: [
                            JSONNamedLoadedPhrase.Cluster(wordType: "P", isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "NP", clusterName: "Simple article-noun-adj-conj-adj phrase", isSubject: false),
                            ]),
    
    JSONNamedLoadedPhrase(language: "Agnostic", phraseType: "VP", phraseName: "Simple verb phrase",
            clusterList: [
                            JSONNamedLoadedPhrase.Cluster(wordType: "V", isSubject: false),
                            JSONNamedLoadedPhrase.Cluster(wordType: "PP", clusterName: "Simple preposition phrase", isSubject: false),
                            ])
]
