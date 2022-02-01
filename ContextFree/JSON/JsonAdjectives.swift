//
//  JsonAdjectives.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/19/21.
//

import Foundation

import UIKit

public class JsonAdjective: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var adjectiveType: String  //"D" - demonstrative (this), "P" possessive (my), "A" any
    var nounLikes : String   //"*" - place holder
    var position : String  //"P" preceding, "F" following, "B" both
    public var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    init(spanish: String, english: String, french: String, adjectiveType : String, nounLikes: String, position: String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.adjectiveType = adjectiveType
        self.nounLikes = nounLikes
        self.position = position
    }
}

//For Michelle Carpenter - Capítulo 3
var MichelleCarpeterAdjectiveList3: [JsonAdjective] = [
    JsonAdjective(spanish: "dulce", english: "sweet", french: "douce", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "salado", english: "salty", french: "salé", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "sabroso", english: "tasty", french: "délicieux", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "picante", english: "spicy", french: "épicé", adjectiveType : "A", nounLikes : "*", position: "F"),
    ]

var myMultiLingualAdjList: [JsonAdjective] = [
    JsonAdjective(spanish: "este", english: "this",    french: "ce", adjectiveType : "D", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "amable", english: "friendly", french: "amical", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "viejo", english: "old", french: "ancien", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "bello", english: "beautiful", french: "belle", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "blanco", english: "white", french: "blanc", adjectiveType : "C", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "amado", english: "beloved", french: "cher", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "diferente", english: "different", french: "différent", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "gracioso", english: "funny", french: "drôle", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "temoroso", english: "afraid", french: "effraye", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "molesto", english: "annoyed", french: "ennuyé", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "enfadado", english: "angry", french: "fâché", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "extraño", english: "strange", french: "bizarre", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "contenido", english: "happy", french: "fâché", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "inteligente", english: "smart", french: "intelligent", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "joven", english: "young", french: "jeune", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "anciano", english: "elderly", french: "âgé", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "seguro", english: "confident", french: "assuré", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "azul", english: "blue", french: "bleu", adjectiveType : "C", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "bueno", english: "good", french: "bon", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "cierto", english: "certain", french: "certain", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "ardiente", english: "ardent", french: "chaud", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "claro", english: "clear", french: "clair", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "confundido", english: "confused", french: "confus", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "dificíl", english: "difficult", french: "difficile", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "suave", english: "smooth", french: "doux", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "completo", english: "complete", french: "entier", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "español", english: "Spanish", french: "entier", adjectiveType : "N", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "francesa", english: "French", french: "français", adjectiveType : "N", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "completo", english: "English", french: "entier", adjectiveType : "N", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "gris", english: "gray", french: "gris", adjectiveType : "C", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "amarillo", english: "yellow", french: "jaune", adjectiveType : "C", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "justo", english: "just", french: "juste", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "pesado", english: "heavy", french: "lourd", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "malo", english: "bad", french: "mauvais", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "malo", english: "mean", french: "méchant", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "mayor", english: "better", french: "meilleur", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "peor", english: "worse", french: "pire", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "mismo", english: "same", french: "même", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "negro", english: "black", french: "noir", adjectiveType : "C", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "siento", english: "sorry", french: "navré", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "tormentoso", english: "stormy", french: "orageux", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "naranja", english: "orange", french: "orange", adjectiveType : "C", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "pobre", english: "poor", french: "pauvre", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "pequeño", english: "small", french: "petit", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "posible", english: "possible", french: "possible", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "apresurado", english: "in a hurry", french: "pressé", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "listo", english: "ready", french: "prêt", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "contento", english: "delighted", french: "ravi", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "sucio", english: "filthy", french: "sale", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "serio", english: "serious", french: "sérieux", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "estúpido", english: "stupid", french: "stupide", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "estupendo", english: "great", french: "super", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "tímido", english: "timid", french: "timide", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "todo", english: "all", french: "tout", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "triste", english: "sad", french: "triste", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "verde", english: "green", french: "vert", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "vacío", english: "empty", french: "vide", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "púrpura", english: "violet", french: "violet", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "viviendo", english: "vivid", french: "vivant", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "real", english: "true", french: "vrai", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "dulce", english: "sweet", french: "douce", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "salado", english: "salty", french: "salé", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "sabroso", english: "tasty", french: "délicieux", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "picante", english: "spicy", french: "épicé", adjectiveType : "A", nounLikes : "*", position: "F"),
    ]


//create json from
public class JsonAdjectiveManager {
    var myWordList = [JsonAdjective]()
    
    public func printWords(){
        print(myWordList)
    }
    
    public func printOne(jv: JsonAdjective){
        print(jv)
    }
    
    public func encodeInternalWords(collectionType: JsonCollectionTypes, total: Int){
        clearWords()
        var wordList = [JsonAdjective]()
        switch collectionType {
        case .All:
            wordList = myMultiLingualAdjList
        case .Simple:
            wordList = myMultiLingualAdjList
        }
        for v in wordList{
            myWordList.append(v)
            print("JsonAdjectiveManager: appending adjective \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    public func getLastWord()->JsonAdjective{
        return myWordList.last!
    }
    
    public func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedAdjs = try? encoder.encode(myWordList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedAdjs.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    public func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonAdjective].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    public func appendWord(verb: JsonAdjective){
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
    
    public func clearWords(){
        myWordList.removeAll()
    }
    
    public func getWordAt(index: Int)->JsonAdjective{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    public func getWordCount()->Int{
        return myWordList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualAdjectives").appendingPathExtension("json")
    }
    
}

