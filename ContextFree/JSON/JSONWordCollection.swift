//
//  JSONWordCollection.swift
//  JSONWordCollection
//
//  Created by Charles Diggins on 1/11/22.
//

import Foundation
struct JSONWord : Codable, CustomStringConvertible {
    var spanish: String
    var english: String
    var french: String
    var wordType: String
    var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
}
    
var CarpenterWordList: [JSONWord] = [
    JSONWord(spanish: "siempre", english: "always", french: "toujours", wordType: "adverb"),
    JSONWord(spanish: "nunca", english: "never", french: "jamais", wordType: "adverb"),
    JSONWord(spanish: "todos los dias", english: "everyday", french: "tous les jours", wordType: "adverb"),
    
    JSONWord(spanish: "dulce", english: "sweet", french: "douce", wordType: "adjective"),
    JSONWord(spanish: "salado", english: "salty", french: "salé", wordType: "adjective"),
    JSONWord(spanish: "sabroso", english: "tasty", french: "délicieux", wordType: "adjective"),
    JSONWord(spanish: "picante", english: "spicy", french: "épicé", wordType: "adjective"),
    
    JSONWord(spanish: "con", english: "with", french: "avec", wordType: "preposition"),
    JSONWord(spanish: "sin", english: "without", french: "sans",wordType: "preposition"),
    
    JSONWord(spanish: "desayuno", english: "breakfast",    french: "petir déjeuner", wordType: "noun"),
    JSONWord(spanish: "cereal", english: "cereal",    french: "céréale", wordType: "noun"),
    JSONWord(spanish: "huevo", english: "egg",    french: "œef", wordType: "noun"),
    JSONWord(spanish: "pan", english: "bread",    french: "pain", wordType: "noun"),
    JSONWord(spanish: "pan tostado", english: "toast",    french: "toast", wordType: "noun"),
    JSONWord(spanish: "plátano", english: "banana",    french: "banane", wordType: "noun"),
    JSONWord(spanish: "salchicha", english: "sausage",    french: "sausisse", wordType: "noun"),
    JSONWord(spanish: "tocino", english: "bacon",    french: "bacon", wordType: "noun"),
    JSONWord(spanish: "yogur", english: "yogurt",    french: "yaourt", wordType: "noun"),
    JSONWord(spanish: "almuerzo", english: "lunch",    french: "déjeuner", wordType: "noun"),
    JSONWord(spanish: "ensalada", english: "salad",    french: "salade", wordType: "noun"),
    JSONWord(spanish: "fresa", english: "strawberry",    french: "fraisier", wordType: "noun"),
    JSONWord(spanish: "galleta", english: "cookie",    french: "gâteau", wordType: "noun"),
    JSONWord(spanish: "hamburguesa", english: "hamburger",    french: "hamburger", wordType: "noun"),
    JSONWord(spanish: "jamón", english: "ham",    french: "jambon", wordType: "noun"),
    JSONWord(spanish: "papas fritas", english: "French fries",    french: "frites", wordType: "noun"),
    JSONWord(spanish: "manzana", english: "apple",    french: "pomme", wordType: "noun"),
    JSONWord(spanish: "naranja", english: "orange",    french: "orange", wordType: "noun"),
    JSONWord(spanish: "perro caliente", english: "hot dog",    french: "hot-dog", wordType: "noun"),
    JSONWord(spanish: "pizza", english: "pizza",    french: "pizza", wordType: "noun"),
    JSONWord(spanish: "queso", english: "cheese",    french: "fromage", wordType: "noun"),
    JSONWord(spanish: "sándwich de jamón y queso", english: "ham and cheese sandwich",    french: "sandwich jambon-fromage", wordType: "noun"),
    JSONWord(spanish: "sopa", english: "soup",    french: "soupe", wordType: "noun"),
    JSONWord(spanish: "sopa de verduras", english: "vegetable soup",    french: "soupe aux légumes", wordType: "noun"),
    JSONWord(spanish: "pollo", english: "chicken",    french: "poulet", wordType: "noun"),
    JSONWord(spanish: "sal", english: "salt",    french: "sel", wordType: "noun"),
    JSONWord(spanish: "pimienta", english: "pepper",    french: "poivre", wordType: "noun"),
    JSONWord(spanish: "azúcar", english: "sugar",    french: "sucre", wordType: "noun"),

    JSONWord(spanish: "comer", english: "eat", french: "manger", wordType: "verb"),
    JSONWord(spanish: "beber", english: "drink", french: "boire", wordType: "verb"),
    JSONWord(spanish: "gustar", english: "be pleasing to", french: "aimer", wordType: "verb"),
    ]

class JSONWordCollection: Codable {
     
    var myWordList = [JSONWord]()
    
    func printWords(){
        print(myWordList)
    }
    
    func printOne(jv: JSONWord){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        let wordList = CarpenterWordList
        
        for v in wordList{
            myWordList.append(v)
            //print("JSONWordCollection: appending word \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
//        if let encodedPreps = try? encoder.encode(collectionName){
//            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
//        }
        if let encodedPreps = try? encoder.encode(myWordList){
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JSONWord].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(adv: JSONWord){
        var appendThis = true
        for i in 0..<myWordList.count {
            let v = myWordList[i]
            if v.spanish == adv.spanish && v.french == adv.french && v.english == adv.english{
                myWordList.remove(at: i)
                myWordList.insert(adv, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myWordList.append(adv)}
        encodeWords()
    }
    func clearWords(){
        myWordList.removeAll()
    }
    
    func getJsonWordAt(index: Int)->JSONWord{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordAt(index: Int)->Word{
        var word = Word()
        if index > myWordList.count-1 {
            return Word()
        }
        else {
            let jsonWord = myWordList[index]
            let wordType = getWordTypeFromString(str: jsonWord.wordType)
            return Word(word: jsonWord.spanish, spanish: jsonWord.spanish, french: jsonWord.french, english: jsonWord.english, wordType: wordType)
        }
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEWordCollection").appendingPathExtension("json")
    }
    
}
