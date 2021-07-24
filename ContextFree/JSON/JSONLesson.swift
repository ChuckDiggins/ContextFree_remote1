//
//  JSONLesson.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/21/21.
//

import Foundation

import UIKit

class JsonLesson: Codable, CustomStringConvertible {
    var language: String //agnostic means any language, otherwise it is language-specific
    var lessonName : String
    var description: String {
        return "\(self.lessonName) "
    }
    
    init(language: LanguageType, lessonName : String){
        self.language = language.rawValue
        self.lessonName = lessonName
    }
}

var myLessonList: [JsonLesson] = [
    JsonLesson(language: .Agnostic, lessonName: "My first lesson"),
    JsonLesson(language: .Spanish, lessonName: "My first Spanish-specific lesson")
]

//create json from
class JsonLessonManager {
    var myLessonList = [JsonLesson]()
    
    func printWords(){
        print(myLessonList)
    }
    
    func printOne(jv: JsonLesson){
        print(jv)
    }
    
    func encodeInternalWords(total: Int){
        clearWords()
        for v in myLessonList{
            myLessonList.append(v)
            print("JsonLessonManager: appending lesson \(v.lessonName)")
            if myLessonList.count >= total {break}
        }
        encodeWords()
    }
    
    func getLastWord()->JsonLesson{
        return myLessonList.last!
    }
    
    func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode( myLessonList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonLesson].self, from: data){
                myLessonList = decodedWords
            }
        }
    }
    
    func appendLesson(jl: JsonLesson){
        var appendThis = true
        for i in 0..<myLessonList.count {
            let v = myLessonList[i]
            if v.lessonName == jl.lessonName{
                myLessonList.remove(at: i)
                myLessonList.insert(jl, at:i)
                appendThis = false
                break
            }
        }
        if ( appendThis ){myLessonList.append(jl)}
        encodeWords()
    }
    
    func clearWords(){
        myLessonList.removeAll()
    }
    
    func getLessonAt(index: Int)->JsonLesson{
        if index > myLessonList.count-1 { return myLessonList[0] }
        return myLessonList[index]
    }
    
    func getWordCount()->Int{
        return myLessonList.count
    }
     
    func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFELessons").appendingPathExtension("json")
    }
    
}




