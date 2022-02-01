//
//  JSONAdverbs.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/28/21.
//

import Foundation

public class JsonAdverb: Codable, CustomStringConvertible {
    var english: String
    var french: String
    var spanish: String
    var adverbType: String  //"D" - demonstrative (this), "P" possessive (my), "A" any
    var verbLikes : String   //"*" - place holder
    var adjLikes : String   //"*" - place holder
    var position : String  //"P" preceding, "F" following, "B" both
    public var description: String {
        return "\(self.spanish) \(self.english) \(self.french)"
    }
    
    init(spanish: String, english: String, french: String, adverbType : String, verbLikes: String, adjLikes: String, position: String){
        self.spanish = spanish
        self.english = english
        self.french = french
        self.adverbType = adverbType
        self.verbLikes = verbLikes
        self.adjLikes = adjLikes
        self.position = position
    }
}

//adverb types
// M = manner - bien, así, mejor
// P = place - aquí, arriba, dónde
// T = time - hoy, ahora,
// I = intensity - poco, más, cuanto
// D = doubt - posiblemente, tal vez
// A = affirmation - ciertamente
// E = exclusion - apenas

var myMultiLingualAdverbList: [JsonAdverb] = [
    JsonAdverb(spanish: "siempre", english: "always", french: "toujours", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "nunca", english: "never", french: "jamais", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "jamás", english: "never", french: "jamais", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    // M = manner - bien, así, mejor
    JsonAdverb(spanish: "bien", english: "well",    french: "bien", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "mal", english: "badly",    french: "mal", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "así", english: "thus",    french: "ainsi", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "deprisa", english: "quickly",    french: "vite", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "despacio", english: "slowly",    french: "lentemente", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "mejor", english: "better",    french: "mieux", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "peor", english: "worse",    french: "pire", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "a mano", english: "by hand", french: "à pied", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "a pie", english: "on foot", french: "à la main", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "a mano", english: "by hand", french: "à pied", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "a pie", english: "on foot", french: "à la main", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "a escondidas", english: "secretly", french: "en secret", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "a pie", english: "on foot", french: "à la main", adverbType : "M", verbLikes : "*", adjLikes : "*", position: "P"),
    // P = place - aquí, arriba, dónde
    JsonAdverb(spanish: "aquí", english: "here",    french: "ici", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "ahí", english: "there",    french: "là", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "allí", english: "there",    french: "là-bas", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "cerca", english: "near",    french: "près", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "lejos", english: "far",    french: "loin", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "enfrente", english: "in front of",    french: "en face de", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "frente a", english: "in front of",    french: "en face de", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "atrás", english: "behind",    french: "en arrière", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "detrás", english: "behind",    french: "par derrière", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "arriba", english: "above",    french: "en haut", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "arriba", english: "above",    french: "au-dessus", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "por encima", english: "over",    french: "par en haut", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "por abajo", english: "below",    french: "en bas", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "debajo", english: "under",    french: "en dessous", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "dentro", english: "inside",    french: "dedans", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "en el interior", english: "inside", french: "à l'intérieur", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "en el exterior", english: "outside", french: "à l'extérieur", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "afuera", english: "outside",    french: "dehors", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "dónde", english: "where",    french: "où", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "en alguna parte", english: "somewhere", french: "quelque part", adverbType : "P", verbLikes : "*", adjLikes : "*", position: "P"),
    
    // T = time - hoy, ahora,
    JsonAdverb(spanish: "hoy", english: "today", french: "aujourd'hui", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "ayer", english: "yesterday", french: "hier", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "mañana", english: "tomorrow", french: "demain", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "ahora", english: "now", french: "maintenant", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "antes", english: "before", french: "avant", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "después", english: "puis", french: "after", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "luego", english: "later", french: "après", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "temprano", english: "early", french: "tôt", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "tarde", english: "late", french: "tard", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "entonces", english: "then", french: "alors", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "aún", english: "yet", french: "encore", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "en fin", english: "at last", french: "à la fin", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    
    JsonAdverb(spanish: "a veces", english: "sometimes", french: "parfois", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "de vez en cuando", english: "once in a while", french: "de temps en temps", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "todos los dias", english: "everyday", french: "tous les jours", adverbType : "T", verbLikes : "*", adjLikes : "*", position: "P"),
    // I = intensity - poco, más, cuanto
    JsonAdverb(spanish: "poco", english: "a little", french: "en peu", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "muy", english: "very", french: "très", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "mucho", english: "very", french: "très", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "más", english: "more", french: "plus", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "menos", english: "less", french: "moins", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "demasiado", english: "too much", french: "trop", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "tanto", english: "as much", french: "autant", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "tan", english: "so much", french: "tant", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "bastante", english: "enough", french: "assez", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "casi", english: "almost", french: "presque", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "cuanto", english: "combien", french: "how much", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "en serio", english: "seriously", french: "au sérieux", adverbType : "I", verbLikes : "*", adjLikes : "*", position: "P"),
    // D = doubt - posiblemente, tal vez
    JsonAdverb(spanish: "tal vez", english: "perhaps", french: "peut-être", adverbType : "D", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "puede ser", english: "maybe", french: "peut-être", adverbType : "D", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "por casualidad", english: "by chance", french: "par hasard", adverbType : "D", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "posiblemente", english: "possibly", french: "possiblement", adverbType : "D", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "probablemente", english: "probably", french: "probablement", adverbType : "D", verbLikes : "*", adjLikes : "*", position: "P"),
    // A = affirmation - ciertamente
    JsonAdverb(spanish: "ciertamente", english: "certainly", french: "certainement", adverbType : "A", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "realmente", english: "really", french: "réellement", adverbType : "A", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "efectivamente", english: "effectively", french: "effectivement", adverbType : "A", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "exactamente", english: "exactly", french: "exactement", adverbType : "A", verbLikes : "*", adjLikes : "*", position: "P"),
    // E = exclusion - apenas
    JsonAdverb(spanish: "sólo", english: "only", french: "seulement", adverbType : "E", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "solamente", english: "only", french: "seulement", adverbType : "E", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "únicamente", english: "merely", french: "uniquement", adverbType : "E", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "simplemente", english: "simply", french: "simplement", adverbType : "E", verbLikes : "*", adjLikes : "*", position: "P"),
    JsonAdverb(spanish: "apenas", english: "hardly", french: "à peine", adverbType : "E", verbLikes : "*", adjLikes : "*", position: "P"),
    ]
    
    
//create json from
public class JsonAdverbManager {
    var myWordList = [JsonAdverb]()
    
    public func printWords(){
        print(myWordList)
    }
    
    public func printOne(jv: JsonAdverb){
        print(jv)
    }
    
    public func encodeInternalWords(collectionType: JsonCollectionTypes, total: Int){
        clearWords()
        var wordList = [JsonAdverb]()
        switch collectionType {
        case .All:
            wordList = myMultiLingualAdverbList
        case .Simple:
            wordList = myMultiLingualAdverbList
        }
        for v in wordList{
            myWordList.append(v)
            print("JsonPrepositionManager: appending adverb \(v.spanish), \(v.french), \(v.english)")
            if myWordList.count >= total {break}
        }
        encodeWords()
    }
    
    public func getLastWord()->JsonAdverb{
        return myWordList.last!
    }
    
    public func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode(myWordList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonAdverb].self, from: data){
                myWordList = decodedWords
            }
        }
    }
    
    public func appendWord(adv: JsonAdverb){
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
    
    public func clearWords(){
        myWordList.removeAll()
    }
    
    public func getWordAt(index: Int)->JsonAdverb{
        if index > myWordList.count-1 { return myWordList[0] }
        return myWordList[index]
    }
    
    public func getWordCount()->Int{
        return myWordList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFEMultiLingualAdverbs").appendingPathExtension("json")
    }
    
}





    
