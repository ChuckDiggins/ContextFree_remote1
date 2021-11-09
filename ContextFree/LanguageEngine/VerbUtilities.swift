//
//  VerbUtilities.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 12/15/20.
//

import Foundation
/*
 é
 É
 á
 ó
 í
 ü
 ú
 ñ
 ç
 ß
 */
//


struct VerbUtilities {

 
    func doesWordContainLetter(inputString: String, letter: String)->Bool{
        if let _: Range<String.Index> = inputString.range(of: letter) {
            return true
        }
        return false
    }
    
    func reconstructVerbPhrase(verbWord: String, residualPhrase: String, isReflexive: Bool)->String{
        var verbPhrase = verbWord
        if  isReflexive {verbPhrase += "se"}
        if residualPhrase.count > 0 { verbPhrase += " " + residualPhrase}
        return verbPhrase
    }
   
    func isVowel(letter: String)->Bool{
        if (letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u" ){return true}
        if (letter == "á" || letter == "é" || letter == "í" || letter == "ó" || letter == "ú" ){return true}
        if (letter == "ü" || letter == "û") {return true}
        if (letter == "É" || letter == "Ê" || letter == "ê") {return true}
        return false
    }

    func doesWordContainSubstring(inputString: String, subString: String)->(Bool, Int, Int){
        if let range: Range<String.Index> = inputString.range(of: subString) {
            let index1: Int = inputString.distance(from: inputString.startIndex, to: range.lowerBound)
            let index2: Int = inputString.distance(from: inputString.startIndex, to: range.upperBound)
            print("index: ", index1)
            print("index2: ", index2)
            return (true, index1, index2)
        }
        return (false, 0, 0)
    }
    
    func doesWordListContainSubstringList(inputWordList: [Word], subStringList: [String], startIndex : Int)->(Int){
        var wordIndex = startIndex
        var matching = false
        let subStringCount = subStringList.count
        var inputIndex = 0
        var compareIndex = 0
        var hitCount = 0
        while wordIndex < inputWordList.count {
            inputIndex = 0
            
            matching = true
            hitCount = 0
            compareIndex = wordIndex
            while (inputIndex < subStringCount && matching) {
                if ( inputWordList[compareIndex].word == subStringList[inputIndex]){
                    hitCount += 1
                    matching = true
                }
                else {
                    matching = false
                }
                compareIndex += 1
                inputIndex += 1
            }
            if hitCount == subStringCount {return wordIndex}
            wordIndex += 1
        }
        
        return -1
    }
    
    func doesStringListContainSubstringList(inputStringList: [String], subStringList: [String], startIndex : Int)->(Int){
        var wordIndex = startIndex
        var matching = false
        let subStringCount = subStringList.count
        var inputIndex = 0
        var compareIndex = 0
        var hitCount = 0
        while wordIndex < inputStringList.count {
            inputIndex = 0
            
            matching = true
            hitCount = 0
            compareIndex = wordIndex
            while (inputIndex < subStringCount && matching) {
                if ( inputStringList[compareIndex] == subStringList[inputIndex]){
                    hitCount += 1
                    matching = true
                }
                else {
                    matching = false
                }
                compareIndex += 1
                inputIndex += 1
            }
            if hitCount == subStringCount {return wordIndex}
            wordIndex += 1
        }
        
        return -1
    }
    
    func getLastNCharactersInString(inputString: String, copyCount: Int) -> String {
        var newString = ""
        
        //if we only want the last letter and there is only one letter, then return it
        if copyCount == 1 && inputString.count == 1 {
            return inputString
        }
        
        if ( copyCount >= inputString.count ){
            return ""
        }
        
        let inputStringReversed = String(inputString.reversed())
        for i in 0..<copyCount{
            newString.append(inputStringReversed[inputStringReversed.index(inputStringReversed.startIndex, offsetBy: i)])
        }
        newString = String(newString.reversed())
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
    
    func makeSentenceByEliminatingExtraBlanksAndDoingOtherStuff(characterArray: String)->String{
        var sentenceString = ""
        if characterArray.isEmpty {return ""}
        
        let listOfWords = getListOfWordsIncludingPunctuation(characterArray: characterArray)
        
        //put words together here into a sentence
        
        var c : Character = " "
        
        for word in listOfWords {
            if !word.isEmpty {
                c = word[word.startIndex]
                if isPunctuation(input: c){sentenceString += word}
                else {sentenceString += word + " "}
            }
        }
        if ( sentenceString.suffix(1) == " "){sentenceString.removeLast()}
            
        sentenceString.capitalizeFirstLetter()
            
        return sentenceString
    }
    
    func getListOfWordsIncludingPunctuation(characterArray: String) -> [String] {
        var wordList = [String]()
        var word = removeLeadingOrFollowingBlanks(characterArray: characterArray)
        word = separatePunctuationFromCharactersInString(characterArray: word)
        
        var outputWord = ""
        
        for c in word
        {
            if ( isCharacterIncludingPunctuation(input: c))
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
    
    //This allows getListOfWordsIncludingPunctuation to see punctuation as words
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
    

    //removes any leading or following blanks
    func separatePunctuationFromCharactersInString(characterArray: String)->String
    {
        var ss = ""
        
        //skip over any initial blanks in the string until first character is found
        
        //var bFirstCharacter = false;
        
        for c in characterArray
        {
            //separate it by blanks
            
            if isPunctuation(input: c){
                ss += " " + String(c) + " "
            }
            else {
                ss += String(c).lowercased()  //ss.append(c)
            }
        }
        return ss
    }//func removeLeadingOrFollowingBlanks
    
    func startsWithVowelSound(characterArray: String)->Bool{
        for c in characterArray
        {
            //separate it by blanks
            
            if isVowel(letter: String(c)){
                return true
            }
            if c == "h" {return true}
            
            return false
        }
        
        return false
    }
    
    func isCharacter(input: Character)->Bool {
        if (input >= "a" && input <= "z") || (input >= "A" && input <= "Z")
            || input == "á" || input == "é" || input == "í" || input == "ó" || input == "ú"
            || input == "ü" || input == "ñ"
            || input == "ç" || input == "è"  || input == "ê" || input == "î"
            || input == "'" {
           return true
        }
     return false
    }
    
    func isCharacterIncludingPunctuation(input: Character)->Bool {
        if (input >= "a" && input <= "z") || (input >= "A" && input <= "Z")
            || input == "á" || input == "é" || input == "í" || input == "ó" || input == "ú"
            || input == "ü" || input == "ñ"
            || input == "ç" || input == "è"  || input == "ê" || input == "î"
        { return true }
        if isPunctuation(input: input)
        { return true }
     return false
    }
    
    func isPunctuation(input: Character)->Bool {
        if input == "." || input == "," || input == "?" || input == "¿" || input == "'"
                || input == "!" || input == "¡" || input == ":" || input == ";" || input == "\'" || input == "\""
        { return true }
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
    //sample verb word = "tenerse" -> tener + true
    func testForReflexiveEnding (testWord: String) -> (verb:String, bIsReflexive: Bool)
    {
        var  isReflexive = false
        var  verbWord = testWord
        
        //if verbWord is reflexive, strip off final two letters
        
        if ( verbWord.hasSuffix("se")){
            isReflexive = true
            verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
            verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
        }

        return (verb : verbWord, bIsReflexive: isReflexive)
    }
    
    func testForFrenchReflexiveEnding (testWord: String) -> (verb:String, bIsReflexive: Bool)
    {
        var  isReflexive = false
        var  workingWord = testWord
    
        //if verbWord is reflexive, strip off final two letters
    
        if workingWord.hasPrefix("se ") {
            isReflexive = true
            workingWord = removeFirstLetters(characterArray: workingWord, removeCount: 3)
        }
        else if workingWord.hasPrefix("s'") {
            isReflexive = true
            workingWord = removeFirstLetters(characterArray: workingWord, removeCount: 2)
        }
        return (verb : workingWord, bIsReflexive: isReflexive)
    }
    
    func removeFirstLetters(characterArray: String, removeCount: Int)->String{
        var ss = String()
        var charIndex = 0
        
        for c in characterArray {
            if charIndex >= removeCount {
                ss += String(c)
            }
            charIndex += 1
        }
        return ss
    }

    func  analyzeEnglishWordPhrase(testString: String) -> (verbWord:String, verbEnding: VerbEnding, residualPhrase:String, isReflexive: Bool)
    {
        let wordList = getListOfWords(characterArray: testString)
   
        //if analyzeWordPhrase returns an empty verbWord, the testString does not start with a legitimate Spanish verb
        if wordList.isEmpty {
            return  (verbWord: "", verbEnding:.none, residualPhrase: "", isReflexive: false)
        }
        
        var verbWord = ""
        var  residualPhrase = ""

        //assume that the first word is a legitimate verb
        
        verbWord = wordList[0]

        //if more than one word in the wordList, then there must be a residual phrase attached
        //build the residual phrase from the remaining words in the list
        
        if wordList.count > 1 {
            for i in 1..<wordList.count {
                residualPhrase += wordList[i] + " "
            }
        }
    return (verbWord:verbWord, verbEnding:.none, residualPhrase: residualPhrase, isReflexive: false)
    }//func analyzeEnglishWordPhrase

    func  analyzeSpanishWordPhrase(testString: String) -> (verbWord:String, verbEnding: VerbEnding, residualPhrase:String, isReflexive: Bool)
    {
        let wordList = getListOfWords(characterArray: testString)
   
        //if analyzeWordPhrase returns an empty verbWord, the testString does not start with a legitimate Spanish verb
        if wordList.isEmpty {
            return  (verbWord:"", verbEnding:.none, residualPhrase:"", isReflexive:false)
        }
        
        var verbWord = ""
        var  residualPhrase = ""
        var isReflexive = false

        verbWord = wordList[0]
        
        if ( verbWord.count > 2 ){
            //if word is a verb with a reflexive ending, then return the word without the "se" ending
            let result = testForReflexiveEnding(testWord: verbWord)
            verbWord = result.0
            isReflexive = result.1
        }
        
        //check to see if the verbWord has a legitimate verb (ar, er, ir, ír or oir (french)) ending
        
        let verbEnding = determineVerbEnding(verbWord: verbWord)
        
        if ( verbEnding == VerbEnding.none){
            return  (verbWord:"", verbEnding:.none, residualPhrase:"", isReflexive:false)
        }

        //if more than one word in the wordList, then there must be a residual phrase attached
        //build the residual phrase from the remaining words in the list
        
        if wordList.count > 1 {
            for i in 1..<wordList.count {
                residualPhrase += wordList[i] + " "
            }
        }
        return (verbWord:verbWord, verbEnding: verbEnding, residualPhrase: residualPhrase, isReflexive: isReflexive)
    }
        
    func  analyzeFrenchWordPhrase(phraseString: String) -> (verbWord:String, verbEnding: VerbEnding, residualPhrase:String, isReflexive: Bool)
    {
        var testString = phraseString
        var verbWord = ""
        var residualPhrase = ""
        var isReflexive = false
    
        if ( testString.count > 2 ){
            //if word is a verb with a reflexive ending, then return the word without the "se" ending
            let result = testForFrenchReflexiveEnding(testWord: testString)
            testString = result.0
            isReflexive = result.1
        }
    
        let wordList = getListOfWords(characterArray: testString)
   
        //if analyzeWordPhrase returns an empty verbWord, the testString does not start with a legitimate Spanish verb
        if wordList.isEmpty {
            return  (verbWord:"", verbEnding:.none, residualPhrase:"", isReflexive:false)
        }
        
        verbWord = wordList[0]
  
        //check to see if the verbWord has a legitimate verb (ar, er, ir, ír or oir (french)) ending
        
        let verbEnding = determineVerbEnding(verbWord: verbWord)
        
        if ( verbEnding == VerbEnding.none){
            return  (verbWord:"", verbEnding:.none, residualPhrase:"", isReflexive:false)
        }

        //if more than one word in the wordList, then there must be a residual phrase attached
        //build the residual phrase from the remaining words in the list
        
        if wordList.count > 1 {
            for i in 1..<wordList.count {
                residualPhrase += wordList[i] + " "
            }
        }

        return (verbWord:verbWord, verbEnding: verbEnding, residualPhrase: residualPhrase, isReflexive: isReflexive)
    }//func analyzeWordPhrase

    mutating func getVerbStem(verbWord: String, verbEnding : VerbEnding )->String {
        var verbStem = verbWord
        verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        if verbEnding == .OIR {
            verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        }
        return verbStem
    }
    

    //removeExtraBlanks looks at a verb phrase and removes anything more that a single blank between each word
    
    func removeExtraBlanks (verbString: String)->String
    {
        var ss = ""
        
        //remove any multiple blanks in the string
        
        var hasBlank = false;
        
        for c in verbString
        {
            //if this is a contiguous blank, skip it
            
            if ( c == " " && hasBlank )
            {
                hasBlank = true
                continue
            }
                
            else if ( c == " ")
            {
                hasBlank = true;
            }
            //if this is a non-blank, reset hasBlank
            else
            {
                hasBlank = false
            }
            ss += String(c).lowercased()  //ss.append(c)
        }
        return ss
    }//

    

    
    //removes any leading or following blanks
    func removeNonAlphaCharactersButLeaveBlanks(characterArray: String)->String
    {
        var ss = ""
         
        for c in characterArray
        {
            if ( c == " " || isCharacter(input: c))
            {
                ss += String(c).lowercased()  //ss.append(c)
            }
        }
        
        return ss
    }//func removeNonAlphaCharactersButLeaveBlanks

    func removeLastLetters(verbWord : String, letterCount : Int)->String {
        var newWord = verbWord
        
        for _ in 0..<letterCount {
            newWord.remove(at: newWord.index(before: newWord.endIndex))
            //print("verbWord \(verbWord) ... newWord \(newWord)")
        }
        
        //print("verbWord \(verbWord) ... newWord \(newWord)")
        
        //remove any remaining spaces
        repeat { newWord.remove(at: newWord.index(before: newWord.endIndex)) }
        while newWord.hasSuffix(" ")
        
        return newWord
    }

    //determineVerbEnding determines what type verb AR, ER or IR
    func  determineVerbEnding (verbWord: String)-> VerbEnding
    {
        var verbType : VerbEnding
        
        if (verbWord.hasSuffix("ar"))
        {
            verbType = VerbEnding.AR
        }
        else if (verbWord.hasSuffix("er"))
        {
            verbType = VerbEnding.ER
        }
        else if (verbWord.hasSuffix("ir"))
        {
            verbType = VerbEnding.IR
        }
        else if (verbWord.hasSuffix("ír"))
        {
            verbType = VerbEnding.accentIR  //oír and reír
        }
        else if (verbWord.hasSuffix("re"))
        {
            verbType = VerbEnding.OIR
        }
        
        else {
            verbType = VerbEnding.none
        }
        return verbType
    }


    //remove2LetterVerbEnding removes verb ending (ar, er, ir) ... assumes this word has already been tested to have legitimate verb ending
    // for the current language:
    func remove2LetterVerbEnding (word: String)->String
    {
        var verbWord = word
        verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
        verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
        return verbWord
    }

    // French has the oir-ending
    func remove3LetterVerbEnding (word: String)->String
    {
        var verbWord = word
        verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
        verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
        verbWord.remove(at: verbWord.index(before: verbWord.endIndex))
        return verbWord
    }
    
   
}

