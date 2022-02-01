//
//  JsonClause.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/23/21.
//

import Foundation

//namedClause.appendNamedPhrase(namedPhrase: NP1)
//namedClause.appendNamedPhrase(namedPhrase: VP)
//the json reader will have to look up the phrases by their name.  ID?

let jc = JsonClause(language: .Agnostic, name: "Simple clause 1",
                    phraseList: [
                        JsonClause.Phrase(phraseName: "Simple article-noun phrase"),
                        JsonClause.Phrase(phraseName: "Simple verb phrase")
                        ])

public struct JsonClause:  Codable {
    public struct Phrase : Codable {
        var phraseName : String
    }
    
    public init(language: LanguageType, name: String, phraseList : [Phrase]){
        self.language = language.rawValue
        self.clauseName = name
        self.phraseList = phraseList
        
    }
    

    public init(language: String, phraseType: String, name: String, phraseList : [Phrase]){
        self.language = language
        self.clauseName = name
        self.phraseList = phraseList
    }
    
    public init(){
        language = ""
        clauseName = ""
        self.phraseList = [Phrase]()
    }
    
    var language: String //agnostic means any language, otherwise it is language-specific
    var clauseName : String
   
    var phraseList: [Phrase]
    
}


//create json from
public class JsonClauseManager {
    var myList = [JsonClause]()
    
    public func printClauses(){
        print(myList)
    }
    
    public func printOne(jv: JsonClause){
        print(jv)
    }
    
    public func encodeInternalClauses(total: Int){
        clearClauses()
        for v in myList{
            myList.append(v)
            print("JsonClauseManager: appending clause \(v.clauseName)")
            if myList.count >= total {break}
        }
        encodeClauses()
    }
    
    public func getLastClause()->JsonClause{
        return myList.last!
    }
    
    public func encodeClauses(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode( myList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    public func decodeClauses(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonClause].self, from: data){
                myList = decodedWords
            }
        }
    }
    
    public func getClauseAtName(name: String)->JsonClause{
        for i in 0..<myList.count {
            let v = myList[i]
            if v.clauseName == name { return v }
        }
        return JsonClause()  //empty
    }
    
    public func appendClause(jl: JsonClause){
        var appendThis = true
        for i in 0..<myList.count {
            let v = myList[i]
            if v.clauseName == jl.clauseName{
                myList.remove(at: i)
                myList.insert(jl, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myList.append(jl)}
        encodeClauses()
    }
    
    public func clearClauses(){
        myList.removeAll()
    }
    
    public func getClauseAt(index: Int)->JsonClause{
        if index > myList.count-1 { return myList[0] }
        return myList[index]
    }
    
    public func getCount()->Int{
        return myList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEClauses").appendingPathExtension("json")
    }
    
}

