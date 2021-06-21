//
//  JSONTest.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/27/21.
//

import UIKit

class JsonNoun: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var frenchGender: String
    var spanishGender: String
    var englishPlural: String
    var nounType: String  //"RTA"
    var verbLikes : String   //"AbCdEf" - Furniture, Idea, Thing
    var adjLikes : String
    var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    init(spanish: String, english: String, french: String, spanishGender: String, frenchGender: String, englishPlural: String, nounType : String, verbLikes: String, adjLikes: String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.spanishGender = spanishGender
        self.frenchGender = frenchGender
        self.englishPlural = englishPlural
        self.nounType = nounType
        self.verbLikes = verbLikes
        self.adjLikes = adjLikes
        
    }
    
    //if intransitive, then no object likes
    
    init(spanish: String, english: String, french: String, spanishGender: String, frenchGender: String, englishPlural: String, verbLikes: String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.spanishGender = spanishGender
        self.frenchGender = frenchGender
        self.englishPlural = englishPlural
        self.nounType = "N"
        self.verbLikes = verbLikes
        self.adjLikes = ""
    }
}

var myMultiLingualWordList: [JsonNoun] = [
    JsonNoun(spanish: "oreja", english: "ear",    french: "oreille", spanishGender : "F", frenchGender : "F", englishPlural: "ears", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "mano", english: "hand",    french: "main", spanishGender : "M", frenchGender : "M", englishPlural: "ears", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "pie", english: "foot",    french: "pied", spanishGender : "M", frenchGender : "M", englishPlural: "feet", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "cara", english: "face",    french: "visage", spanishGender : "F", frenchGender : "F", englishPlural: "visages", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "familia", english: "family",    french: "famille", spanishGender : "M", frenchGender : "F", englishPlural: "families", nounType : "Any", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "tio", english: "uncle",    french: "uncle", spanishGender : "M", frenchGender : "M", englishPlural: "uncles", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "esposo", english: "husband",    french: "mari", spanishGender : "M", frenchGender : "M", englishPlural: "husbands", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "esposa", english: "wife",    french: "femme", spanishGender : "F", frenchGender : "F", englishPlural: "wives", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "hija", english: "daughter",    french: "fille", spanishGender : "F", frenchGender : "F", englishPlural: "daughters", nounType : "P", verbLikes: "", adjLikes: ""),
    
    JsonNoun(spanish: "bebé", english: "baby",    french: "bebe", spanishGender : "M", frenchGender : "M", englishPlural: "babies", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "niño", english: "child",    french: "enfant", spanishGender : "M", frenchGender : "M", englishPlural: "infants", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "hijo", english: "son",    french: "fils", spanishGender : "M", frenchGender : "M", englishPlural: "sons", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "niño", english: "boy",    french: "garçon", spanishGender : "M", frenchGender : "M", englishPlural: "boys", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "niña", english: "girl",    french: "fille", spanishGender : "F", frenchGender : "F", englishPlural: "girls", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "hombre", english: "man",    french: "homme", spanishGender : "M", frenchGender : "M", englishPlural: "men", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "mujer", english: "woman",    french: "femme", spanishGender : "F", frenchGender : "F", englishPlural: "women", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "amigo", english: "friend",    french: "ami", spanishGender : "M", frenchGender : "M", englishPlural: "friends", nounType : "P", verbLikes: "", adjLikes: ""),
    
    JsonNoun(spanish: "jefe", english: "boss",    french: "chef", spanishGender : "M", frenchGender : "M",  englishPlural: "bosses", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "vecina", english: "neighbor",    french: "voisine", spanishGender : "F", frenchGender : "M", englishPlural: "neighbors", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "vestido", english: "dress",    french: "robe", spanishGender : "M", frenchGender : "M", englishPlural: "dresses", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "camisa", english: "shirt",    french: "chemise", spanishGender : "F", frenchGender : "M", englishPlural: "shirts", nounType : "T", verbLikes: "", adjLikes: ""),
    
    JsonNoun(spanish: "libro", english: "book ",    french: "livre", spanishGender : "M", frenchGender : "M", englishPlural: "books", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "bicicleta", english: "bike",    french: "bicyclette", spanishGender : "F", frenchGender : "F", englishPlural: "bikes", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "tren", english: "train",    french: "train", spanishGender : "M", frenchGender : "M", englishPlural: "trains", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "autobús", english: "bus",    french: "bus", spanishGender : "M", frenchGender : "M", englishPlural: "buses", nounType : "T", verbLikes: "", adjLikes: ""),
    
    JsonNoun(spanish: "dinero", english: "money ",    french: "argent", spanishGender : "M", frenchGender : "M", englishPlural: "ears", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "bicicleta", english: "bike",    french: "bicyclette", spanishGender : "F", frenchGender : "F", englishPlural: "ears", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "mesa", english: "table",    french: "table", spanishGender : "F", frenchGender : "F", englishPlural: "tables", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "auto", english: "car",    french: "voiture", spanishGender : "M", frenchGender : "M", englishPlural: "cars", nounType : "T", verbLikes: "", adjLikes: ""),
    
    JsonNoun(spanish: "zapato", english: "shoe",    french: "chaussure", spanishGender : "M", frenchGender : "M", englishPlural: "shoes", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "sombrero", english: "hat",    french: "chapeau", spanishGender : "M", frenchGender : "M", englishPlural: "hats", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "pelo", english: "hair",    french: "cheveux", spanishGender : "M", frenchGender : "M", englishPlural: "hair", nounType : "T", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "médico", english: "doctor",    french: "médecin", spanishGender : "M", frenchGender : "M", englishPlural: "doctors", nounType : "P", verbLikes: "", adjLikes: ""),
    JsonNoun(spanish: "enfermedad", english: "illness",    french: "maladie", spanishGender : "F", frenchGender : "M", englishPlural: "illnesses", nounType : "T", verbLikes: "", adjLikes: ""),
    ]

//create json from
class JsonNounManager {
    var myWordList = [JsonNoun]()
    
    func printVerbs(){
        print(myWordList)
    }
    
    func printOne(jv: JsonNoun){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        for v in myMultiLingualWordList{
            myWordList.append(v)
            print("JsonVerbManager: appending noun \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func getLastWord()->JsonNoun{
        return myWordList.last!
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedNouns = try? encoder.encode(myWordList){
            //print(String(data: encodedVerbs, encoding: .utf8)!)
            try? encodedNouns.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonNoun].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(verb: JsonNoun){
        var appendThis = true
        for i in 0..<myWordList.count {
            let v = myWordList[i]
            if v.spanish == verb.spanish && v.french == verb.french {
                myWordList.remove(at: i)
                myWordList.insert(verb, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myWordList.append(verb)}
        encodeWords()
    }
    
    func clearWords(){
        myWordList.removeAll()
    }
    
    func getWordAt(index: Int)->JsonNoun{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
    
    
    
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualNouns").appendingPathExtension("json")
    }
    
}
