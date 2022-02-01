//
//  JSONLesson.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/21/21.
//

import Foundation

import UIKit

public class JsonLesson: Codable, CustomStringConvertible {
    var language: String //agnostic means any language, otherwise it is language-specific
    var lessonName : String
    public var description: String {
        return "\(self.lessonName) "
    }
    
    public init(language: LanguageType, lessonName : String){
        self.language = language.rawValue
        self.lessonName = lessonName
    }
}

var myLessonList: [JsonLesson] = [
    JsonLesson(language: .Agnostic, lessonName: "My first lesson"),
    JsonLesson(language: .Spanish, lessonName: "My first Spanish-specific lesson")
]

//create json from
public class JsonLessonManager {
    var myLessonList = [JsonLesson]()
    
    public func printWords(){
        print(myLessonList)
    }
    
    public func printOne(jv: JsonLesson){
        print(jv)
    }
    
    public func encodeInternalWords(total: Int){
        clearWords()
        for v in myLessonList{
            myLessonList.append(v)
            print("JsonLessonManager: appending lesson \(v.lessonName)")
            if myLessonList.count >= total {break}
        }
        encodeWords()
    }
    
    public func getLastWord()->JsonLesson{
        return myLessonList.last!
    }
    
    public func encodeWords(){
        //encode to JSON
        let encoder = JSONEncoder()
        if let encodedPreps = try? encoder.encode( myLessonList){
            //print(String(data: encodedAdjs, encoding: .utf8)!)
            try? encodedPreps.write(to: getURL(), options: .noFileProtection)
        }
    }
    
    public func decodeWords(){
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: getURL()){
            if let decodedWords = try? decoder.decode([JsonLesson].self, from: data){
                myLessonList = decodedWords
            }
        }
    }
    
    public func appendLesson(jl: JsonLesson){
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
    
    public func clearWords(){
        myLessonList.removeAll()
    }
    
    public func getLessonAt(index: Int)->JsonLesson{
        if index > myLessonList.count-1 { return myLessonList[0] }
        return myLessonList[index]
    }
    
    public func getWordCount()->Int{
        return myLessonList.count
    }
     
    public func getURL()->URL{
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsURL.appendingPathComponent("SPIFELessons").appendingPathExtension("json")
    }
    
}




