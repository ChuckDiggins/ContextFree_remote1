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
    
    mutating func applyMorphModel(language: LanguageType, inputMorphStruct:CFMorphStruct, cfMorphModel : CFMorphModel )->CFMorphStruct{
        let workingMorphStruct = inputMorphStruct
        
        //let workingSingleList = m_clause.getWorkingSingleList()
        
        return workingMorphStruct
    }
    
    //WorkInProgress
    
    mutating func applyMorphModelToSimplePhrases(language: LanguageType, inputMorphStruct:CFMorphStruct, cfMorphModel : CFMorphModel )->CFMorphStruct{
        let currentLanguage = language
        let workingMorphStruct = inputMorphStruct
        
        var lookForNounPhrase = false
        
        for cfOperation in cfMorphModel.mpsList {
            switch cfOperation.from {
            case .followingAdjective: lookForNounPhrase = true
            default: break
            }
            
            switch cfOperation.to {
            case .precedingAdjective: lookForNounPhrase = true
            default: break
            }
        }
        
        //ask for next noun phrase
        var phraseSingleList = [dSingle]()
        
        if lookForNounPhrase {
            let result = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .Subject)
            phraseSingleList = result.0
            //let gender = result.1
            //let number = result.2
            //let person = result.3
            if phraseSingleList.count == 0 {
                print("could not retieve a subject phrase")
                return workingMorphStruct
            }
            //applyMorphModelToSimplePhrase(phraseSingleList: phraseSingleList, )
        }
        return workingMorphStruct
    }
    
    /*
    mutating func applyMorphModelToSimplePhrase(language: LanguageType, inputMorphStruct:CFMorphStruct, cfMorphModel : CFMorphModel )->CFMorphStruct{
        let currentLanguage = language
        var workingMorphStruct = inputMorphStruct
        
        return workingMorphStruct
    }
    */
    
    mutating func retrieveAppropriatPronounPhrase(language: LanguageType, inputMorphStruct:CFMorphStruct, cfMorphModel : CFMorphModel )->CFMorphStruct{
        let workingMorphStruct = inputMorphStruct
    
        for cfOperation in cfMorphModel.mpsList{
            print("\ncfOperation: \(cfOperation.morphOperation.rawValue)")
        }
        
        return workingMorphStruct
    }
    
    /*
    mutating func createCfRemove(language: LanguageType, inputMorphStruct:CFMorphStruct, mos: MorphOperationStruct )->CFMorphStruct{
        let currentLanguage = language
        var workingMorphStruct = inputMorphStruct
        var equivalentPronounDescription = ""
        var targetPronounType = PronounType.PERSONAL  //ambiguous
        
        
        switch mos.from {
        case .subjectPronoun:
            equivalentPronounDescription = "remove subject pronoun"
            targetPronounType = .SUBJECT
        case .directObjectPronoun:
            equivalentPronounDescription = "remove direct object pronoun"
            targetPronounType = .DIRECT_OBJECT
        case .indirectObjectPronoun:
            equivalentPronounDescription = "remove indirect object pronoun"
            targetPronounType = .INDIRECT_OBJECT
        default: break
        }
        
        let workingSingleList = m_clause.getWorkingSingleList()
        var removeIndex = -1
        
        //find the personal pronoun
        for index in 0 ..< workingSingleList.count {
            let single = workingSingleList[index]
            let pronounType = single.getPronounType()
            if pronounType == targetPronounType {
                removeIndex = index
                break
            }
        }
        
        if removeIndex > 0 {
            workingMorphStruct = remove(language: currentLanguage, inputMorphStruct: workingMorphStruct, removeIndex: removeIndex, equivalentPronounDescription: equivalentPronounDescription)
        } else {
            print("executeCfRemove: Could not find \(...equivalentPronounDescription)")
        }
        return workingMorphStruct
    }
*/
    
        /*
    mutating func applyMorphModel(language: LanguageType, inputMorphStruct:CFMorphStruct, cfMorphModel : CFMorphModel )->CFMorphStruct{
        let currentLanguage = language
        var workingMorphStruct = inputMorphStruct
        var equivalentPronoun = Pronoun()
        var equivalentPronounSingle = dPersonalPronounSingle()
        var equivalentPronounDescription = ""
        var workingSingleList = m_clause.getWorkingSingleList()
        var verbIndex = -1
        var doIndex = -1
        var inDoIndex = -1
        var subjIndex = -1
        var selectedList = [Bool]()
        var phraseSingleList = [dSingle]()
        var phraseIndexList = [Int]()

        var result: (singleList: [dSingle], gender: Gender, number: Number, person: Person)
        //retrieve the appropriate pronoun phrase
        for cfOperation in cfMorphModel.mpsList{
            print("\ncfOperation: \(cfOperation.morphOperation.rawValue)")
            switch cfOperation.morphOperation {
            case .remove: workingMorphStruct = createCfRemove(language: currentLanguage, inputMorphStruct: inputMorphStruct, mos: cfOperation)
            case .grab:
                switch cfOperation.from {
                case .subjectPhrase:
                    result = getEquivalentPronoun(clause: m_clause, type: .SUBJECT, language: currentLanguage)
                    equivalentPronounDescription = "subject pronoun"//
                case .directObjectPhrase:
                    result = getEquivalentPronoun(clause: m_clause, type: .DIRECT_OBJECT, language: currentLanguage)
                    equivalentPronounDescription = "direct object pronoun"
                case .indirectObjectPhrase:
                    result = getEquivalentPronoun(clause: m_clause, type: .INDIRECT_OBJECT, language: currentLanguage)
                    equivalentPronounDescription = "indirect object pronoun"
                default:
                    break
                }
            default:  break
            }

            //create a new pronoun single to work with
            
            let wsd = WordStateData()
            wsd.language = language
            wsd.word = Word()
            wsd.pronounType = equivalentPronoun.type
            wsd.gender = result.gender
            wsd.number = result.number
            wsd.person = result.person
            wsd.wordType = .Pronoun
            //equivalentPronounSingle = dPersonalPronounSingle(word: equivalentPronoun, data: wsd)
            //let equivalentPronounString = getWordString(language:language, single: equivalentPronounSingle)
            
             //create a parallel array of booleans to indicate selected or not
           
            selectedList.removeAll()
            for _ in workingSingleList {
                selectedList.append(false)
            }
                
            //find the location of a few important words
            
            var moveFromIndex = -1
            var moveToIndex = -1
            dumpWorkingSingleList(language: language, showPronounTypes: true)
            let workingSingleList = m_clause.getWorkingSingleList()
            for ssIndex in 0 ..< workingSingleList.count {
                let single = workingSingleList[ssIndex]
                if  single.getClusterType() == .V {
                    verbIndex = ssIndex
                }
                else if  single.getPronounType() == .SUBJECT {
                    subjIndex = ssIndex
                }
                else if  single.getPronounType() == .DIRECT_OBJECT {
                    doIndex = ssIndex
                }
                else if  single.getPronounType() == .INDIRECT_OBJECT {
                    inDoIndex = ssIndex
                }
            }
            
            switch cfOperation.from {
            case .indirectObjectPronoun: moveFromIndex = inDoIndex
            case .directObjectPronoun: moveFromIndex = doIndex
            case .subjectPronoun: moveFromIndex = subjIndex
            default: break
            }
            
            switch cfOperation.location {
            case .precedingVerb:  moveToIndex = verbIndex
            case .precedingDOPronoun:
                if doIndex >= 0 {moveToIndex = doIndex}
                else {moveToIndex = verbIndex}
            default: break
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
                workingMorphStruct = grab(language: currentLanguage, inputMorphStruct: workingMorphStruct, selectedList: selectedList,  phraseSingleList : phraseSingleList, equivalentPronounSingle : equivalentPronounSingle, equivalentPronounDescription: equivalentPronounDescription)
            case .replace:
                workingMorphStruct = replace(language: currentLanguage, inputMorphStruct: workingMorphStruct, selectedList: selectedList, phraseSingleList : phraseSingleList, equivalentPronounSingle : equivalentPronounSingle, equivalentPronounDescription: equivalentPronounDescription)
            case .insertBefore:
                workingMorphStruct = insertBefore(language: currentLanguage, inputMorphStruct: workingMorphStruct, insertIndex: moveToIndex, equivalentPronounSingle : equivalentPronounSingle, equivalentPronounDescription: equivalentPronounDescription)
            case .remove:
                break
            case .contract:
                break
            case .convert:
                break
            case .append:
                break
            case .move:
                workingMorphStruct = moveSingle(language: currentLanguage, inputMorphStruct: workingMorphStruct, removeIndex: moveFromIndex, moveToIndex: moveToIndex,  equivalentPronounDescription: equivalentPronounDescription)
                break
            default:
                break
            }
            
        }//operation loop

        return workingMorphStruct
    }//applyMorphModel
    */
        
    mutating func getEquivalentPronoun(clause: dIndependentAgnosticClause, type: PronounType, language: LanguageType)->([dSingle], Gender, Number, Person){
        let result = clause.getCompositeSentenceString(language: language, targetFunction: .Subject)
        let phraseSingleList = result.0
        let gender = result.1
        let number = result.2
        let person = result.3
        return (phraseSingleList, gender, number, person)
    }
    
    
    mutating func getWordString(language: LanguageType, single: dSingle)->String{
        if single.isPersonalPronounType(){
            let ppSingle = single as! dPersonalPronounSingle
            return ppSingle.getWordStringAtLanguage(language: language)
        }
        return single.getProcessWordInWordStateData(language: language) + " "
    }
    
    mutating func grab (language: LanguageType, inputMorphStruct:CFMorphStruct, selectedList:[Bool], phraseSingleList : [dSingle], equivalentPronounSingle : dPersonalPronounSingle, equivalentPronounDescription: String)->CFMorphStruct{
        
        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        let workingSingleList = m_clause.getWorkingSingleList()
        var doPhrase = ""
        for i in 0 ..< phraseSingleList.count {
            doPhrase += getWordString(language: language, single: phraseSingleList[i]) + " "
        }
        
        //fill part1 - prefunctional part ... if any
        var breakIndex = 0
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                breakIndex = ssIndex
                break
            }
            let single = workingSingleList[ssIndex]
            morphStep.part1 += getWordString(language: language, single: single) + " "
        }
        
        //fill part2 -- functional part - should start off with selected word
        
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                //let wordString = getWordString(language: language, single: workingSingleList[ssIndex])
                morphStep.part2 = doPhrase + " "
                //grabString = doPhrase  + " "
            } else {
                breakIndex = ssIndex
                break
            }
        }
        //fill part3 -- postfunctional part ... if any
        for ssIndex in breakIndex ..< workingSingleList.count {
            morphStep.part3 += getWordString(language: language, single: workingSingleList[ssIndex])
        }
        morphStep.comment1 = "Grab the \(equivalentPronounDescription) ("
        morphStep.comment2 = "\(doPhrase)"
        morphStep.comment3 = ") in the sentence"
        workingMorphStruct.append(morphStep: morphStep)
        
        print("\nGrab: \(equivalentPronounDescription)")
        print("MorphSteps: \(morphStep.part1), \(morphStep.part2), \(morphStep.part3) ")
        print("Comment: \(morphStep.comment1) \(morphStep.comment2) \(morphStep.comment3) ")
        
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        return workingMorphStruct
    }
    
    mutating func replace(language: LanguageType, inputMorphStruct:CFMorphStruct, selectedList:[Bool],
                          phraseSingleList : [dSingle], equivalentPronounSingle : dPersonalPronounSingle, equivalentPronounDescription: String)->CFMorphStruct{
        
        //Replace the current phrase with the equivalent pronoun

        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        var workingSingleList = m_clause.getWorkingSingleList()
        print("\nBefore replace")
        m_clause.dumpWorkingSingleList(language: language, showPronounTypes:true)
        var doPhrase = ""
        var breakIndex = 0
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                breakIndex = ssIndex
                break
            }
            morphStep.part1 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        
        //fill part2 -- functional part - should start off with selected word
        
        let equivalentPronounString = equivalentPronounSingle.getWordStringAtLanguage(language:language)
        
        for ssIndex in breakIndex ..< workingSingleList.count {
            if selectedList[ssIndex] {
                morphStep.part2 += equivalentPronounString + " "
                //remove these singles from the single list
                for _ in 0 ..< phraseSingleList.count {
                    doPhrase += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
                    workingSingleList.remove(at: ssIndex)
                }
                workingSingleList.insert(equivalentPronounSingle, at: ssIndex)
                breakIndex = ssIndex + 1
                break
            } else {
                breakIndex = ssIndex
                break
            }
        }
        
        //fill part3 -- postfunctional part ... if any
        for ssIndex in breakIndex ..< workingSingleList.count {
            morphStep.part3 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        morphStep.comment1 = "Replace \(equivalentPronounDescription) "
        morphStep.comment2 = "(\(doPhrase)) "
        morphStep.comment3 = "with pronoun "
        morphStep.comment4 = "(\(equivalentPronounString))"
        workingMorphStruct.append(morphStep: morphStep)
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        //
        print("\nAfter replace")
        m_clause.dumpWorkingSingleList(language: language, showPronounTypes:true)
        
        print("\nReplace: \(equivalentPronounDescription) -\(doPhrase)- with \(equivalentPronounString)")
        print("MorphSteps: \(morphStep.part1) +  \(morphStep.part2) + \(morphStep.part3) ")
        print("Comment\(morphStep.comment1) \(morphStep.comment2)\(morphStep.comment3)\(morphStep.comment4) ")
        return workingMorphStruct
    }
    
    mutating func moveSingle (language: LanguageType, inputMorphStruct:CFMorphStruct, removeIndex:Int, moveToIndex:Int, equivalentPronounDescription: String)->CFMorphStruct
    {
        let workingMorphStruct = inputMorphStruct
        
        var workingSingleList = m_clause.getWorkingSingleList()
        var targetSingle = dSingle()
        
        //-------------------------------------------------------------------------------------------------------
        //first remove the target single
        
        var morphStep = CFMorphStep()
        for ssIndex in 0 ..< removeIndex {
            morphStep.part1 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        targetSingle = workingSingleList[removeIndex]
        let pronounStr = getWordString(language: language, single: targetSingle) + " "
        
        //morphStep.part2 += pronoun.getString() + " "
        workingSingleList.remove(at: removeIndex)

        //fill part3 -- postfunctional part ... if any
        for ssIndex in removeIndex ..< workingSingleList.count {
            morphStep.part3 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        morphStep.comment1 = "Remove the \(equivalentPronounDescription) "
        morphStep.comment2 = "(\(pronounStr))"
        workingMorphStruct.append(morphStep: morphStep)
        
        //-------------------------------------------------------------------------------------------------------
        // next move the single to where it belongs
        
        morphStep = CFMorphStep()
        for ssIndex in 0 ..< moveToIndex {
            morphStep.part1 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        morphStep.part2 = getWordString(language: language, single: targetSingle) + " "
        //fill part3 -- postfunctional part ... if any
        for ssIndex in moveToIndex ..< workingSingleList.count {
            morphStep.part3 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        // insert the single last so the morphSteps don't have to take into account the changing indices
        workingSingleList.insert(targetSingle, at: moveToIndex)
        morphStep.comment1 = "Insert the \(equivalentPronounDescription) "
        morphStep.comment2 = "(\(pronounStr))"
        workingMorphStruct.append(morphStep: morphStep)
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        
        
        print("\nRemove: \(equivalentPronounDescription)  at index \(removeIndex)")
        print("MorphSteps:\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        print("Comment: \(morphStep.comment1) (\(morphStep.comment2 ) \(morphStep.comment3) ")

        return workingMorphStruct
    }
    mutating func remove (language: LanguageType, inputMorphStruct:CFMorphStruct, removeIndex:Int, equivalentPronounDescription: String)->CFMorphStruct{
        
        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        var workingSingleList = m_clause.getWorkingSingleList()
        
        for ssIndex in 0 ..< removeIndex {
            morphStep.part1 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        
        let pronounStr = getWordString(language: language, single: workingSingleList[removeIndex]) + " "
        
        //morphStep.part2 += pronoun.getString() + " "
        workingSingleList.remove(at: removeIndex)

        //fill part3 -- postfunctional part ... if any
        for ssIndex in removeIndex ..< workingSingleList.count {
            morphStep.part3 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        morphStep.comment1 = "Remove the \(equivalentPronounDescription) "
        morphStep.comment2 = "(\(pronounStr))"
        workingMorphStruct.append(morphStep: morphStep)
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        
        print("\nRemove: \(equivalentPronounDescription)  at index \(removeIndex)")
        print("MorphSteps:\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        print("Comment: \(morphStep.comment1) (\(morphStep.comment2 ) \(morphStep.comment3) ")

        return workingMorphStruct
    }
    mutating func insertBefore (language: LanguageType, inputMorphStruct:CFMorphStruct, insertIndex:Int, equivalentPronounSingle : dPersonalPronounSingle,  equivalentPronounDescription: String)->CFMorphStruct{
       
        let equivalentPronounString = getWordString(language: language, single: equivalentPronounSingle) + " "
        
        let workingMorphStruct = inputMorphStruct
        var morphStep = CFMorphStep()
        var workingSingleList = m_clause.getWorkingSingleList()
        
        var breakIndex = 0
        for ssIndex in breakIndex ..< insertIndex {
            morphStep.part1 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        
        morphStep.part2 += equivalentPronounString + " "
        breakIndex = insertIndex //this only accounts for a single word verb ... we need to find the core verb phrase
        workingSingleList.insert(equivalentPronounSingle, at: insertIndex)
        
        breakIndex = insertIndex + 1
        
        // está comprando
        // quiero mandar
        
        //fill part3 -- postfunctional part ... if any
        for ssIndex in breakIndex ..< workingSingleList.count {
            morphStep.part3 += getWordString(language: language, single: workingSingleList[ssIndex]) + " "
        }
        morphStep.comment1 = "Move the \(equivalentPronounDescription) -> "
        morphStep.comment2 = "\(equivalentPronounString)"
        morphStep.comment3 = " to new location"
        workingMorphStruct.append(morphStep: morphStep)
        m_clause.setWorkingSingleList(singleList: workingSingleList)
        
        print("\nInsertBefore: \(equivalentPronounDescription) \(equivalentPronounString) before index \(insertIndex)")
        print("MorphSteps:\(morphStep.part1) + .. \(morphStep.part2) + ..\(morphStep.part3) ")
        print("Comment: \(morphStep.comment1) (\(morphStep.comment2 ) \(morphStep.comment3) ")

        return workingMorphStruct
    }
}
