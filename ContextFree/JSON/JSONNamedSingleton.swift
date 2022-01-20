////
////  JSONNamedSingleton.swift
////  JSONNamedSingleton
////
////  Created by Charles Diggins on 1/19/22.
////
//
//import Foundation
//
//var sampleNamedSingletonList: [JSONNamedSingleton] = [
//    JSONNamedSingleton(id: 0, singletonName: "People", clusterType: "N", associatedWords : JSONWord(spanish: "huevo", english: "egg",    french: "œef", wordType: "noun"))
//                        [
//                       JSONWord(spanish: "desayuno", english: "breakfast",    french: "petir déjeuner", wordType: "noun"),
//                       JSONWord(spanish: "cereal", english: "cereal",    french: "céréale", wordType: "noun"),
//                       JSONWord(spanish: "huevo", english: "egg",    french: "œef", wordType: "noun")])
//    
//    JSONNamedSingleton(id: 1, singletonName: "Breakfast foods", clusterType: "N", componentPhrases: ["Det", "N", "Adj"]),
//    JSONNamedSingleton(id: 2, singletonName: "Lunch foods", clusterType: "N", componentPhrases: ["Det", "N", "Adj", "C", "Adj"]),
//    ]
//
//class JSONNamedSingleton: Codable, CustomStringConvertible {
//    var idNum: Int
//    var singletonName: String
//    var clusterType: String
//    var associatedWords : JSONWord
//    //var associatedWords : [JSONWord]
//    var description: String {
//        return "\(self.singletonName) \(self.clusterType)"
//    }
//    
//    init(id: Int, singletonName:String, clusterType:String, associatedWords: JSONWord ){
//        self.idNum = id
//        self.singletonName = singletonName
//        self.clusterType = clusterType
//        self.associatedWords = associatedWords
//    }
//    
//    class JSONNamedPhraseManager: Codable {
//         
//        var mySingletonList = [JSONNamedSingleton]()
//        
//        func printWords(){
//            print(myPhraseList)
//        }
//        
//        func printOne(jv: JSONNamedSingleton){
//            print(jv)
//        }
//        
//        func encodeInternalWords(total: Int){
//            clearWords()
//            let phraseList = sampleNamedSingletonList
//            
//            for v in phraseList{
//                mySingletonList.append(v)
//                //print("JSONNamedPhraseManager: appending phrase")
//                if mySingletonList.count >= total {break}
//            }
//            encodeWords()
//        }
//        
//        func encodeWords(){
//            //encode to JSON
//            let encoder = JSONEncoder()
//    //        if let encodedPreps = try? encoder.encode(collectionName){
//    //            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
//    //        }
//            if let encodedPreps = try? encoder.encode(mySingletonList){
//                try? encodedPreps.write(to: getURL(), options: .noFileProtection)
//            }
//        }
//        
//        func decodeWords(){
//            let decoder = JSONDecoder()
//            
//            if let data = try? Data.init(contentsOf: getURL()){
//                if let decodedWords = try? decoder.decode([JSONNamedSingleton].self, from: data){
//                    mySingletonList = decodedWords
//                }
//            }
//        }
//        
//        func getPhraseAt(index: Int)->NamedPhrase{
//            let namedPhrase = NamedPhrase()
//            if index > mySingletonList.count-1 {
//                return NamedPhrase()
//            }
//            else {
//                let jsonNamedSingleton = mySingletonList[index]
//                let clusterType = getClusterTypeFromString(str: jsonNamedSingleton.clusterType)
////                return NamedPhrase(inputPhrase: jsonNamedPhrase.phraseName, phraseName: <#T##String#>)
//            }
//            return namedPhrase
//        }
//        
//        func clearWords(){
//            
//        }
//        
//        func getURL()->URL{
//            let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            return docsURL.appendingPathComponent("JumpLingua named singletons").appendingPathExtension("json")
//        }
//    }
//}
