//
//  VerbUtilities.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 12/15/20.
//

import Foundation
//retrieves preposition, verb ending, is reflexive, strips out verb itself


struct Utilities {

    func getLastNCharactersInString(inputString: String, copyCount: Int) -> String {
        if ( copyCount >= inputString.count ){
            return ""
        }
        
        let inputStringReversed = String(inputString.reversed())
        var newString = ""
        for i in 0..<copyCount{
            newString.append(inputStringReversed[inputStringReversed.index(inputStringReversed.startIndex, offsetBy: i)])
        }
        return newString
    }
    
    mutating func findIndexOfLastOccurenceOfTargetStringInInputString(inputString: String, targetString: String) -> Int {
        //var index = -1
        var inputStringCopy = inputString
        let inputLetterCount = inputStringCopy.count
        
        if ( inputString.hasSuffix(targetString)){
            return inputStringCopy.count - targetString.count
        }

        //peel back the input string copy until target string is the suffix
        
        for _ in 0..<inputLetterCount {
            inputStringCopy.removeLast()
            if ( inputStringCopy.hasSuffix(targetString)){
                return inputStringCopy.count - targetString.count
            }
        }
        
        return -1
    }

    mutating func replaceSubrange(inputString : String, fromString : String, toString : String)-> String {
        var startIndex = findIndexOfLastOccurenceOfTargetStringInInputString(inputString: inputString, targetString: fromString)
        if startIndex < 0 {startIndex = inputString.count - 1}  //if not found, then start at the end of the input string
        let endIndex = startIndex + fromString.count
        
        var outputWord = ""
        
        //write the first part
        
        for i in 0..<startIndex {
            outputWord += getStringCharacterAt(input: inputString, charIndex: i)
        }
    
        outputWord += toString
        
        //if there are any letters left in the input string, append them here
        
        if ( endIndex < inputString.count ){
            for i in endIndex..<inputString.count {
                outputWord += getStringCharacterAt(input: inputString, charIndex: i)
            }
        }
        return ( outputWord)
    }
    
    mutating func replaceSubrangeAndGetBeforeAndAfterStrings(inputString : String, fromString : String, toString : String)-> (String, String, String) {
        var startIndex = findIndexOfLastOccurenceOfTargetStringInInputString(inputString: inputString, targetString: fromString)
        if startIndex < 0 {startIndex = inputString.count - 1}  //if not found, then start at the end of the input string
        let endIndex = startIndex + fromString.count
        
        var outputWord = ""
        var part1 = ""

        
        //write the first part
        
        for i in 0..<startIndex {
            outputWord += getStringCharacterAt(input: inputString, charIndex: i)
        }
        
        part1 = outputWord
        outputWord += toString

        
        var part2 = ""
        //if there are any letters left in the input string, append them here
        
        if ( endIndex < inputString.count ){
            for i in endIndex..<inputString.count {
                outputWord += getStringCharacterAt(input: inputString, charIndex: i)
                part2 += getStringCharacterAt(input: inputString, charIndex: i)
            }
        }
        return ( outputWord, part1, part2)
    }
    

    
    func getStringCharacterAt(input : String, charIndex : Int)->String{
        let char = input[input.index(input.startIndex, offsetBy: charIndex)]
        return String(char)
    }
    
    func getListOfWords(characterArray: String) -> [String] {
        var wordList = [String]()
        let word = removeLeadingOrFollowingBlanks(characterArray: characterArray)
        var outputWord = ""
        
        for c in word
        {
            if ( isCharacter(input: c))
            {
                outputWord += String(c).lowercased()  //ss.append(c)
            }
            //if this is a blank and the word is not empty, then add word to wordList
            else if (c == " " && outputWord.count > 0)
            {
                wordList.append(outputWord)
                outputWord.removeAll()
            }
        }
        
        //add the last word to wordList here
        wordList.append(outputWord)
        
        return wordList
    }
    
    //removes any leading or following blanks
    func removeLeadingOrFollowingBlanks(characterArray: String)->String
    {
        var ss = ""
        
        //skip over any initial blanks in the string until first character is found
        
        var bFirstCharacter = false;
        
        for c in characterArray
        {
            if ( c == " " && !bFirstCharacter)
            {
                continue
            }
            else
            {
                bFirstCharacter = true
            }
            ss += String(c).lowercased()  //ss.append(c)
        }
        
        //There should only be at most one blank at the end
        while (ss.hasSuffix(" "))
        {
            ss.remove(at: ss.index(before: ss.endIndex))
        }
        return ss
    }//func removeLeadingOrFollowingBlanks
    
    struct VerbCategory {
        var id = UUID()
        var name : String
        var description : String
        var verbStrings = [String]()
        
        mutating func addVerb(verbString : String ){
            verbStrings.append(verbString)
        }
        
        func getVerbStrings()->[String]{
            return verbStrings
        }
    }
    
    func isCharacter(input: Character)->Bool {
        if (input >= "a" && input <= "z") || (input >= "A" && input <= "Z"
            || input == "á" || input == "é" || input == "í" || input == "ó" || input == "ú"
            || input == "ü" || input == "ñ") {
           return true
        }
     return false
    }
    
    func containsOnlyLetters(input: String) -> Bool {
       for chr in input {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
             return false
          }
       }
       return true
    }


}
