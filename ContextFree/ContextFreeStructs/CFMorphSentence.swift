//
//  CFMorphSentence.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/7/21.
//

import Foundation

struct CFMorphSentence {
    var m_clause : dIndependentAgnosticClause
    var subjectPronoun = ""
    var directObjectPronoun = ""
    var indirectObjectPronoun = ""
    
    
    
    mutating func convertSpanishPhrasesToPersonalPronouns(inputMorphStruct:CFMorphStruct, ppFunctionList: [PPFunctionType])->CFMorphStruct {
        let currentLanguage = LanguageType.Spanish
        var equivalentPronounString = ""
        var equivalentPronounDescription = ""
        var equivalentPronoun = Pronoun()
        var workingMorphStruct = inputMorphStruct
        var masterSingleList = m_clause.getSingleList()
        var verbIndex = 0
        
        var phraseSingleList = [dSingle]()
        var phraseIndexList = [Int]()
        
        for ppFunction in ppFunctionList{
            switch ppFunction{
            case .none:
                return workingMorphStruct
            case .subject:
                equivalentPronounString = m_clause.getSubjectPronounString(language: currentLanguage)
                equivalentPronounDescription = "subject pronoun"
                phraseSingleList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .Subject)
            case .directObject:
                equivalentPronounString = m_clause.getDirectObjectPronounString(language: currentLanguage)
                equivalentPronounDescription = "direct object pronoun"
                phraseSingleList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .DirectObject)
            case .indirectObject:
                equivalentPronounString = m_clause.getIndirectObjectPronounString(language: currentLanguage)
                equivalentPronounDescription = "indirect object pronoun"
                phraseSingleList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .IndirectObject)
            case .prepositionalObject:
                equivalentPronounDescription = "prepositional object pronoun"
                return workingMorphStruct
            }
            
            //create a parallel array of booleans to indicate selected or not
            
            var selectedList = [Bool]()
            for _ in 0 ..< masterSingleList.count {
                selectedList.append(false)
            }
            
            //find the location of the first verb single
            
            for ssIndex in 0 ..< masterSingleList.count {
                let single = masterSingleList[ssIndex]
                if ( single.getClusterType() == .V ){
                    verbIndex = ssIndex
                    break
                }
            }
            
            //fill the phraseIndexList indices ...
            phraseIndexList.removeAll()
            for phraseIndex in 0 ..< phraseSingleList.count {
                let phraseSingle = phraseSingleList[phraseIndex]
                for ssIndex in 0 ..< masterSingleList.count {
                    let single = masterSingleList[ssIndex]
                    //literally checking their addresses to confirm that they point to the same object
                    if phraseSingle == single {
                        phraseIndexList.append(ssIndex)
                        selectedList[ssIndex] = true
                        break
                    }
                }
            }
            
            for ssIndex in 0 ..< masterSingleList.count {
                print("masterSingleList \(masterSingleList[ssIndex]): selectedList \(selectedList[ssIndex])")
            }
            
            //------------------------------------------------------------------------------
            //step 1 - highlight the current functional phrase
            
            var morphStep = CFMorphStep()
            
            //fill part1 - prefunctional part ... if any
            var breakIndex = 0
            for ssIndex in breakIndex ..< masterSingleList.count {
                if selectedList[ssIndex] {
                    breakIndex = ssIndex
                    break
                }
                morphStep.part1 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
            }
            
            //fill part2 -- functional part - should start off with selected word
            
            var doPhrase = ""
            for ssIndex in breakIndex ..< masterSingleList.count {
                if selectedList[ssIndex] {
                    morphStep.part2 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
                    doPhrase = masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage)
                } else {
                    breakIndex = ssIndex
                    break
                }
            }
            //fill part3 -- postfunctional part ... if any
            for ssIndex in breakIndex ..< masterSingleList.count {
                morphStep.part3 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
            }
            morphStep.comment1 = "Grab the "
            morphStep.comment2 = "\(equivalentPronounDescription) "
            morphStep.comment3 = "phrase in sentence"
            workingMorphStruct.append(morphStep: morphStep)
            
            print("\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
            //------------------------------------------------------------------------------
            //step 2 - replace the current phrase with the equivalent pronoun
            
            //fill part1 - prefunctional part ... if any
            
            morphStep = CFMorphStep()
            breakIndex = 0
            for ssIndex in breakIndex ..< masterSingleList.count {
                if selectedList[ssIndex] {
                    breakIndex = ssIndex
                    break
                }
                morphStep.part1 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
            }
            
            //fill part2 -- functional part - should start off with selected word
            
            for ssIndex in breakIndex ..< masterSingleList.count {
                if selectedList[ssIndex] {
                    morphStep.part2 += equivalentPronounString + " "
                    //remove these singles from the single list
                    for removeIndex in 0 ..< phraseSingleList.count {
                        masterSingleList.remove(at: ssIndex)
                    }
                    breakIndex = ssIndex
                    break
                } else {
                    breakIndex = ssIndex
                    break
                }
            }
            
            //fill part3 -- postfunctional part ... if any
            for ssIndex in breakIndex ..< masterSingleList.count {
                morphStep.part3 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
            }
            morphStep.comment1 = "Replace the \(equivalentPronounDescription) "
            morphStep.comment2 = "\(doPhrase) -> \(equivalentPronoun)"
            morphStep.comment3 = ""
            workingMorphStruct.append(morphStep: morphStep)
            
            print("\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
            
            if ppFunction == .subject { continue }
            
            //
            //step 3 - move the direct object pronoun in front of the verb
            //
            
            //fill part1 - subject ... preVerb
            
            morphStep = CFMorphStep()
            breakIndex = 0
            for ssIndex in breakIndex ..< verbIndex {
                morphStep.part1 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
            }
            
            morphStep.part2 += equivalentPronounString + " "
            breakIndex = verbIndex //this only accounts for a single word verb ... we need to find the core verb phrase
            // está comprando
            // quiero mandar
            
            //fill part3 -- postfunctional part ... if any
            for ssIndex in breakIndex ..< masterSingleList.count {
                morphStep.part3 += masterSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
            }
            morphStep.comment1 = "Move the \(equivalentPronounDescription) -> "
            morphStep.comment2 = "\(equivalentPronoun)"
            morphStep.comment3 = " <- before the verb"
            workingMorphStruct.append(morphStep: morphStep)
            
            print("equivalentPronounDescription:")
            print("\(morphStep.comment1) + .. \(morphStep.comment2) + ..\(morphStep.comment3) ")
            print("\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        }
        return workingMorphStruct
    }
    
    mutating func applyMorphModel(language: LanguageType, inputMorphStruct:CFMorphStruct, cfMorphModel : CFMorphModel )->CFMorphStruct{
        let currentLanguage = language
        var workingMorphStruct = inputMorphStruct
        var equivalentPronoun = Pronoun()
        var equivalentPronounString = ""
        var equivalentPronounDescription = ""
        var workingSingleList = m_clause.getWorkingSingleList()
        var verbIndex = 0
        var selectedList = [Bool]()
        
        var phraseSingleList = [dSingle]()
        var phraseIndexList = [Int]()
    
        //retrieve the appropriate pronoun phrase
        for cfOperation in cfMorphModel.mpsList{
            switch cfOperation.from {
            case .subjectPhrase:
                equivalentPronounString = m_clause.getSubjectPronounString(language: currentLanguage)
                equivalentPronounDescription = "subject pronoun"
                phraseSingleList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .Subject)
                if phraseSingleList.count == 0 {
                    print("could not retieve a subject phrase")
                    return workingMorphStruct
                }
            case .directObjectPhrase:
                equivalentPronounString = m_clause.getDirectObjectPronounString(language: currentLanguage)
                equivalentPronounDescription = "direct object pronoun"
                phraseSingleList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .DirectObject)
                if phraseSingleList.count == 0 {
                    print("could not retieve a direct object phrase")
                    return workingMorphStruct
                }
            case .indirectObjectPhrase:
                equivalentPronounString = m_clause.getIndirectObjectPronounString(language: currentLanguage)
                equivalentPronounDescription = "indirect object pronoun"
                phraseSingleList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .IndirectObject)
                if phraseSingleList.count == 0 {
                    print("could not retieve an indirect object phrase")
                    return workingMorphStruct
                }
            default:
                break
            }
            
            //create a parallel array of booleans to indicate selected or not
           
            selectedList.removeAll()
            for _ in 0 ..< workingSingleList.count {
                selectedList.append(false)
            }
            
            //find the location of the first verb single
            
            for ssIndex in 0 ..< workingSingleList.count {
                let single = workingSingleList[ssIndex]
                if ( single.getClusterType() == .V ){
                    verbIndex = ssIndex
                    break
                }
            }
            
            //fill the phraseIndexList ...
            //also, set the selectedList to true for this phrase type
            
            phraseIndexList.removeAll()
            for phraseIndex in 0 ..< phraseSingleList.count {
                let phraseSingle = phraseSingleList[phraseIndex]
                for ssIndex in 0 ..< workingSingleList.count {
                    let single = workingSingleList[ssIndex]
                    //literally checking their addresses to confirm that they point to the same object
                    if phraseSingle == single {
                        phraseIndexList.append(ssIndex)
                        selectedList[ssIndex] = true
                        break
                    }
                }
            }
            
            //------------------------------------------------------------------------------
            //step 1 - highlight the current functional phrase
               
            switch cfOperation.morphOperation {
            case .grab:
                workingMorphStruct = grab(language: currentLanguage, inputMorphStruct: workingMorphStruct, selectedList: selectedList, equivalentPronounDescription: equivalentPronounDescription)
            case .replace:
                workingMorphStruct = replace(language: currentLanguage, inputMorphStruct: workingMorphStruct, selectedList: selectedList, phraseSingleList : phraseSingleList, equivalentPronounString:equivalentPronounString, equivalentPronounDescription: equivalentPronounDescription)
            case .insertBefore:
                workingMorphStruct = insertBefore(language: currentLanguage, inputMorphStruct: workingMorphStruct, insertIndex: verbIndex, equivalentPronounString:equivalentPronounString, equivalentPronounDescription: equivalentPronounDescription)
            case .remove:
                break
            case .contract:
                break
            case .convert:
                break
            case .append:
                break
            case .move:
                break
            }
            
        }//operation loop
        
        
        return workingMorphStruct
    }
    
    mutating func grab (language: LanguageType, inputMorphStruct:CFMorphStruct, selectedList:[Bool], equivalentPronounDescription: String)->CFMorphStruct{
        
        let currentLanguage = language
        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        var workingSingleList = m_clause.getWorkingSingleList()
        
        //fill part1 - prefunctional part ... if any
        var breakIndex = 0
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                breakIndex = ssIndex
                break
            }
            morphStep.part1 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
        }
        
        //fill part2 -- functional part - should start off with selected word
        
        
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                morphStep.part2 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
                
            } else {
                breakIndex = ssIndex
                break
            }
        }
        //fill part3 -- postfunctional part ... if any
        for ssIndex in breakIndex ..< workingSingleList.count {
            morphStep.part3 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
        }
        morphStep.comment1 = "Grab the "
        morphStep.comment2 = "\(equivalentPronounDescription) "
        morphStep.comment3 = "phrase in sentence"
        workingMorphStruct.append(morphStep: morphStep)
        
        print("\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        print("\(morphStep.comment1) + .. \(morphStep.comment2) + ..\(morphStep.comment3) ")
        
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        return workingMorphStruct
    }
    
    mutating func replace(language: LanguageType, inputMorphStruct:CFMorphStruct, selectedList:[Bool],
                          phraseSingleList : [dSingle], equivalentPronounString:String, equivalentPronounDescription: String)->CFMorphStruct{
        //step 2 - replace the current phrase with the equivalent pronoun
        
        let currentLanguage = language
        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        var workingSingleList = m_clause.getWorkingSingleList()
        
        var doPhrase = ""
        var breakIndex = 0
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                breakIndex = ssIndex
                
                break
            }
            morphStep.part1 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
        }
        
        //fill part2 -- functional part - should start off with selected word
        
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                doPhrase = workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage)
                morphStep.part2 += equivalentPronounString + " "
                //remove these singles from the single list
                for _ in 0 ..< phraseSingleList.count {
                    workingSingleList.remove(at: ssIndex)
                }
                
                breakIndex = ssIndex
                break
            } else {
                breakIndex = ssIndex
                break
            }
        }
        
        //fill part3 -- postfunctional part ... if any
        for ssIndex in breakIndex ..< workingSingleList.count {
            morphStep.part3 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
        }
        morphStep.comment1 = "Replace the \(equivalentPronounDescription) "
        morphStep.comment2 = "\(doPhrase) -> \(equivalentPronounString)"
        morphStep.comment3 = ""
        workingMorphStruct.append(morphStep: morphStep)
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        
        print("\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        print("\(morphStep.comment1) + .. \(morphStep.comment2) + ..\(morphStep.comment3) ")
        return workingMorphStruct
    }
    
    mutating func insertBefore (language: LanguageType, inputMorphStruct:CFMorphStruct, insertIndex:Int, equivalentPronounString:String, equivalentPronounDescription: String)->CFMorphStruct{
        
        let currentLanguage = language
        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        var workingSingleList = m_clause.getWorkingSingleList()
        
        var breakIndex = 0
        for ssIndex in breakIndex ..< insertIndex {
            morphStep.part1 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
        }
        
        morphStep.part2 += equivalentPronounString + " "
        breakIndex = insertIndex //this only accounts for a single word verb ... we need to find the core verb phrase
        
        // está comprando
        // quiero mandar
        
        //fill part3 -- postfunctional part ... if any
        for ssIndex in breakIndex ..< workingSingleList.count {
            morphStep.part3 += workingSingleList[ssIndex].getProcessWordInWordStateData(language: currentLanguage) + " "
        }
        morphStep.comment1 = "Move the \(equivalentPronounDescription) -> "
        morphStep.comment2 = "\(equivalentPronounString)"
        morphStep.comment3 = " <- before the verb"
        workingMorphStruct.append(morphStep: morphStep)
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        
        print("equivalentPronounDescription:")
        print("\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        print("\(morphStep.comment1) + .. \(morphStep.comment2) + ..\(morphStep.comment3) ")

        return workingMorphStruct
    }
}
