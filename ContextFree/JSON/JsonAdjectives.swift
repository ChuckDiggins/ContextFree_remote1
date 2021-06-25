//
//  JsonAdjectives.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/19/21.
//

import Foundation

import UIKit

class JsonAdjective: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var adjectiveType: String  //"D" - demonstrative (this), "P" possessive (my), "A" any
    var nounLikes : String   //"*" - place holder
    var position : String  //"P" preceding, "F" following, "B" both
    var description: String {
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

var myMultiLingualAdjList: [JsonAdjective] = [
    JsonAdjective(spanish: "este", english: "this",    french: "ce", adjectiveType : "D", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "mi", english: "my", french: "mon", adjectiveType : "P", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "amable", english: "friendly", french: "amical", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "viejo", english: "old", french: "ancien", adjectiveType : "A", nounLikes : "*", position: "F"),
    JsonAdjective(spanish: "bello", english: "beautiful", french: "belle", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "blanco", english: "white", french: "blanc", adjectiveType : "C", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "amado", english: "beloved", french: "cher", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "diferente", english: "different", french: "différent", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "gracioso", english: "funny", french: "drôle", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "temoroso", english: "afraid", french: "effraye", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "molesto", english: "annoyed", french: "ennuyé", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "enfadado", english: "angry", french: "fâché", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "extraño", english: "strange", french: "bizarre", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "contenido", english: "happy", french: "fâché", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "inteligente", english: "smart", french: "intelligent", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "joven", english: "young", french: "jeune", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "anciano", english: "elderly", french: "âgé", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "seguro", english: "confident", french: "assuré", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "azul", english: "blue", french: "bleu", adjectiveType : "C", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "bueno", english: "good", french: "bon", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "cierto", english: "certain", french: "certain", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "ardiente", english: "ardent", french: "chaud", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "claro", english: "clear", french: "clair", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "confundido", english: "confused", french: "confus", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "confundido", english: "confused", french: "désorienté", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "dificíl", english: "difficult", french: "difficile", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "suave", english: "smooth", french: "doux", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "completo", english: "complete", french: "entier", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "español", english: "Spanish", french: "entier", adjectiveType : "N", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "francesa", english: "French", french: "français", adjectiveType : "N", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "completo", english: "English", french: "entier", adjectiveType : "N", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "gris", english: "gray", french: "gris", adjectiveType : "C", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "amarillo", english: "yellow", french: "jaune", adjectiveType : "C", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "justo", english: "just", french: "juste", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "pesado", english: "heavy", french: "lourd", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "malo", english: "bad", french: "mauvais", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "malo", english: "mean", french: "méchant", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "mayor", english: "better", french: "meilleur", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "peor", english: "worse", french: "pire", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "mismo", english: "same", french: "même", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "negro", english: "black", french: "noir", adjectiveType : "C", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "siento", english: "sorry", french: "navré", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "tormentoso", english: "stormy", french: "orageux", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "naranja", english: "orange", french: "orange", adjectiveType : "C", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "pobre", english: "poor", french: "pauvre", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "pequeño", english: "small", french: "petit", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "posible", english: "possible", french: "possible", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "apresurado", english: "in a hurry", french: "pressé", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "listo", english: "ready", french: "prêt", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "contento", english: "delighted", french: "ravi", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "sucio", english: "filthy", french: "sale", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "serio", english: "serious", french: "sérieux", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "estúpido", english: "stupid", french: "stupide", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "estupendo", english: "great", french: "super", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "tímido", english: "timid", french: "timide", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "todo", english: "all", french: "tout", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "triste", english: "sad", french: "triste", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "verde", english: "green", french: "vert", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "vacío", english: "empty", french: "vide", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "púrpura", english: "violet", french: "violet", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "viviendo", english: "vivid", french: "vivant", adjectiveType : "A", nounLikes : "*", position: "P"),
    JsonAdjective(spanish: "real", english: "true", french: "vrai", adjectiveType : "A", nounLikes : "*", position: "P"),
    ]


//create json from
class JsonAdjectiveManager {
    var myWordList = [JsonAdjective]()
    
    func printWords(){
        print(myWordList)
    }
    
    func printOne(jv: JsonNoun){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        for v in myMultiLingualAdjList{
            myWordList.append(v)
            print("JsonAdjectiveManager: appending adjective \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    func getLastWord()->JsonAdjective{
        return myWordList.last!
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedAdjs = try? encoder.encode(myWordList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedAdjs.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonAdjective].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    func appendWord(verb: JsonAdjective){
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
    
    func getWordAt(index: Int)->JsonAdjective{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    func getWordCount()->Int{
        return myWordList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualAdjectives").appendingPathExtension("json")
    }
    
}
