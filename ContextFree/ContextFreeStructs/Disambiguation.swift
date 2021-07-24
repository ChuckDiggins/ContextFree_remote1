//
//  Disambiguation.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/12/21.
//

import Foundation

enum ContractionType{
    case conmigo
    case del
    case al
    case je    //j'aime
    case le    //l'aime
}

//mutating func parseWordListIntoWordObjects(wordList: Array<String>)->Array<Word>{
//    return getWordObjects(language: .Spanish, wordList: wordList)
//}
struct Disambiguation {
    
    var m_wsp : WordStringParser!
    
    mutating func setWordStringParser(wsp: WordStringParser){
        m_wsp = wsp
    }
    
    mutating func findContraction(language: LanguageType, singleList : Array<dSingle>, contractionType: ContractionType)->Array<dSingle>{
        var newSingleList = singleList
        switch contractionType {
        case .conmigo:
            break
        case .del:
            break
        case .al:
            break
        case .je:
            break
        case .le:
            newSingleList = findLeContraction(singleList: singleList)
        }
        return  newSingleList
        
    }

    mutating func findLeContraction(singleList : Array<dSingle>)->Array<dSingle>{
        //var newSingleList = singleList
        //no contraction will start with the last single
        for i in 0 ..< singleList.count-1 {
            let single = singleList[i]
            let wsd = single.getSentenceData()
            switch wsd.wordType {
            case .Art:
                if wsd.gender == .masculine && wsd.number == .singular && wsd.articleType == .definite  {
                    let nextSingle = singleList[i+1]
                    print("next single = \(nextSingle.getClusterWord().word) -- starts with a vowel \(nextSingle.startsWithVowelSound() )")
                    if nextSingle.startsWithVowelSound() {
                        single.setProcessWordInWordStateData(str: "l'")
                    } else {
                        single.setProcessWordInWordStateData(str: "le")
                    }
                }
            case .PersPro:
                break
            default: break
            }
        }
        return  singleList
    }
    
    mutating func prescreen(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = sdList
        
        sentenceDataList = lookForProgressivePlusAttachedPronouns(sdList: sdList)
        
        //printSentenceDataList(msg: "After prescreen", sdList : sentenceDataList)
        return sentenceDataList
    }
    
    mutating func lookForCompoundVerbs(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = sdList
        var compoundVerbFound = true
        //var tense = Tense.present
        while compoundVerbFound {
            for sdIndex in 0 ..< sdList.count-1 {
                compoundVerbFound = false
                let sd = sdList[sdIndex]
                
                //first word should be a progressiveVerb
                let wordData = m_wsp.getVerb(wordString: sd.word.word)
                
                //if the verb is auxiliary, check to see if the next word is either progressive or perfect
                if wordData.data.verbType == .auxiliary {
                    let nextSD = sdList[sdIndex+1]
                    var nextWordData : SentenceData
                    //if this word has already been determined to be a verb and is a present or past participle, then use as is
                    
                    let wordType = nextSD.data.wordType
                    let tense = nextSD.data.tense
                    
                    if  wordType == .V && tense == .presentParticiple {
                        nextWordData = nextSD
                    }
                    else if wordType == .V && tense == .pastParticiple {
                        nextWordData = nextSD
                    }
                    //else scan for it
                    else { nextWordData = m_wsp.getVerb(wordString: nextSD.word.word) }
                    
                    //if a participle, then combine the two verbs into a single verb using nextSD and convert the tense appropriately
                    
                    if nextWordData.data.tense == .pastParticiple {
                        let newSD = nextSD
                        newSD.data.tense = wordData.data.tense.getPerfectTense()
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.insert(newSD, at: sdIndex)
                        compoundVerbFound = true
                    }
                    else if nextWordData.data.tense == .presentParticiple {
                        let newSD = nextSD
                        newSD.data.tense = wordData.data.tense.getProgressiveTense()
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.insert(newSD, at: sdIndex)
                        compoundVerbFound = true
                    }
                }
            }
        }
        return sentenceDataList
    }
    
    mutating func lookForProgressivePlusAttachedPronouns(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = sdList
        //handle object pronouns of various sorts, detaching them from other words
        //such as vendiéndomelos = viendo + me + los
        
        var workingIndex = 0
        for sd in sdList {
            let newWordList = m_wsp.handleObjectPronouns(wordString: sd.word.word)
            if ( newWordList.count > 0 ){
                //first word should be a progressiveVerb
                var wordData = m_wsp.getVerb(wordString: newWordList[0])
                sentenceDataList.remove(at: workingIndex)
                sentenceDataList.insert(wordData, at: workingIndex)
                workingIndex += 1
                
                //if 3 words, then the second word is an indirect object pronoun and the third is a direct object pronoun
                if (newWordList.count == 3){
                    wordData = m_wsp.getObjectPronoun(wordString: newWordList[1], type : .INDIRECT_OBJECT)
                    sentenceDataList.insert(wordData, at: workingIndex)
                    workingIndex += 1
                    wordData = m_wsp.getObjectPronoun(wordString: newWordList[2], type : .DIRECT_OBJECT)
                    sentenceDataList.insert(wordData, at: workingIndex)
                    workingIndex += 1
                }
                else if ( newWordList.count == 2){
                    wordData = m_wsp.getObjectPronoun(wordString: newWordList[1], type : .DIRECT_OBJECT)
                    sentenceDataList.insert(wordData, at: workingIndex)
                    workingIndex += 1
                }
            }
            else {
                workingIndex += 1
            }
        }
        return sentenceDataList
        
    }
}
