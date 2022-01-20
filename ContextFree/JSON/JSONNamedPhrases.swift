//
//  JSONNamedPhrases.swift
//  JSONNamedPhrases
//
//  Created by Charles Diggins on 1/18/22.
//

import Foundation

var sampleNamedPhraseList: [JSONNamedPhrase] = [
    JSONNamedPhrase(id: 0, phraseName: "My first named phrase", clusterType: "NP", componentPhrases: ["Det", "N", "Adj"]),
    JSONNamedPhrase(id: 0, phraseName: "My second named phrase", clusterType: "NP", componentPhrases: ["Det", "N", "Adj"]),
    JSONNamedPhrase(id: 0, phraseName: "My third named phrase", clusterType: "NP", componentPhrases: ["Det", "N", "Adj", "C", "Adj"]),
    ]

class JSONNamedPhrase: Codable, CustomStringConvertible {
    var idNum: Int
    var phraseName: String
    var clusterType: String
    var componentPhrases : [String]
    var jsonWords = [JSONWord]()
    var description: String {
        return "\(self.phraseName) \(self.clusterType)"
    }
    
    init(id: Int, phraseName:String, clusterType:String, componentPhrases: [String] ){
        self.idNum = id
        self.phraseName = phraseName
        self.clusterType = clusterType
        self.componentPhrases = componentPhrases
    }
    
    class JSONNamedPhraseManager: Codable {
         
        var myPhraseList = [JSONNamedPhrase]()
        
        func printWords(){
            print(myPhraseList)
        }
        
        func printOne(jv: JSONNamedPhrase){
            print(jv)
        }
        
        func encodeInternalWords(total: Int){
            clearWords()
            let phraseList = sampleNamedPhraseList
            
            for v in phraseList{
                myPhraseList.append(v)
                //print("JSONNamedPhraseManager: appending phrase")
                if myPhraseList.count >= total {break}
            }
            encodeWords()
        }
        
        func encodeWords(){
            //encode to JSON
            let encoder = JSONEncoder()
    //        if let encodedPreps = try? encoder.encode(collectionName){
    //            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
    //        }
            if let encodedPreps = try? encoder.encode(myPhraseList){
                try? encodedPreps.write(to: getURL(), options: .noFileProtection)
            }
        }
        
        func decodeWords(){
            let decoder = JSONDecoder()
            
            if let data = try? Data.init(contentsOf: getURL()){
                if let decodedWords = try? decoder.decode([JSONNamedPhrase].self, from: data){
                    myPhraseList = decodedWords
                }
            }
        }
        
        func getPhraseAt(index: Int)->NamedPhrase{
            let namedPhrase = NamedPhrase()
            if index > myPhraseList.count-1 {
                return NamedPhrase()
            }
            else {
                let jsonNamedPhrase = myPhraseList[index]
                let clusterType = getClusterTypeFromString(str: jsonNamedPhrase.clusterType)
//                return NamedPhrase(inputPhrase: jsonNamedPhrase.phraseName, phraseName: <#T##String#>)
            }
            return namedPhrase
        }
        
        func clearWords(){
            
        }
        
        func getURL()->URL{
            let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return docsURL.appendingPathComponent("JumpLingua named phrases").appendingPathExtension("json")
        }
    }
}
