//
//  ClusterResolution.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/28/21.
//

import Foundation

struct ClusterResolution {
    let m_language : LanguageType
    let m_wsp : WordStringParser
    
    func resolveObjectAndReflexivePronouns (sentenceData: Array<SentenceData>)->Array<SentenceData>{
        let sentenceCopy = sentenceData
        
        //look for consecutive object pronouns "los hombres se nos dieron el libro" -
        // ella me lo ha dado  - she has given it to me -
        // ella la ha dado a mi
        // ella está dándola a mi
        
        for i in 0..<sentenceData.count-1{
            let thisWd = sentenceData[i]
        }
        return sentenceCopy
    }
    
    mutating func lookForCompoundVerbs(sdList : Array<SentenceData>)->Array<SentenceData>{
        var sentenceDataList = sdList
        var compoundVerbFound = true
        
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
                    var tense = nextSD.data.tense
                    
                    if  wordType == .verb && tense == .presentParticiple {
                        nextWordData = nextSD
                    }
                    else if wordType == .verb && tense == .pastParticiple {
                        nextWordData = nextSD
                    }
                    //else scan for it
                    else { nextWordData = m_wsp.getVerb(wordString: nextSD.word.word) }
                    
                    //if a participle, then combine the two verbs into a single verb using nextSD and convert the tense appropriately
                    
                    tense = nextWordData.data.tense
                    if tense == .pastParticiple {
                        let newSD = nextWordData
                        let newTense = wordData.data.tense.getPerfectTense()
                        newSD.data.tense = newTense
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.remove(at: sdIndex)
                        sentenceDataList.insert(newSD, at: sdIndex)
                        compoundVerbFound = true
                    }
                    else if tense == .presentParticiple {
                        let newSD = nextWordData
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

    /*
       mutating func resolveCompoundVerbs(sentenceData: Array<SentenceData>)->Array<SentenceData>{
        var sentenceCopy = sentenceData
        
        //resolve perfect or progressive tenses
        for i in 0..<sentenceData.count-1{
            let thisWd = sentenceData[i]
            var nextWd = sentenceData[i+1]
            
            //if two consecutive words are both conjugated verbs
            // and the first is a "perfect verb" form
            // and the second is a past participle ...
            
            if thisWd.data.wordType == .verb && nextWd.data.wordType == .verb {
                let thisVerb = thisWd.word as! SpanishVerb
                let thisBVerb = thisVerb.getBVerb()
                let auxVerbForm = thisVerb.getConjugateForm(tense: thisWd.data.tense, person: thisWd.data.person)
                //let nextVerb = nextWd.word as! SpanishVerb
                
                //consolidate into a single verb with a perfect tense
                let isPerfect = thisBVerb.isPerfectVerbForm(word: auxVerbForm)
                var nextTense = nextWd.data.tense
                
                if isPerfect && nextTense == .pastParticiple {
                    //convert the perfect verb's tense to a perfect tense and assign it to the past participle verb
                    nextWd.data.tense = thisWd.data.tense.getPerfectTense()
                    //remove the auxiliary verb (the main verb's new tense will take care of that
                    sentenceCopy.remove(at: i)
                    sentenceCopy.remove(at: i)
                    sentenceCopy.insert(nextWd, at: i)
                    continue
                }
                
                //consolidate into a single verb with a perfect tense
                let isProgressive = thisBVerb.isProgressiveVerbForm(word: auxVerbForm)
                nextTense = nextWd.data.tense
                
                if isProgressive && nextTense == .presentParticiple {
                    //convert the perfect verb's tense to a perfect tense and assign it to the past participle verb
                    nextWd.data.tense = thisWd.data.tense.getProgressiveTense()
                    //remove the auxiliary verb (the main verb's new tense will take care of that
                    sentenceCopy.remove(at: i)
                    sentenceCopy.remove(at: i)
                    sentenceCopy.insert(nextWd, at: i)
                }
            }
        }
        return sentenceCopy
    }
    */
    
    func resolveAmbiguousSingles(sentenceData: Array<SentenceData>)->Array<SentenceData>{
        var sentenceCopy = sentenceData
        var prevWordType = WordType.unknown
        
        for i in 0..<sentenceCopy.count {
            var wd = sentenceCopy[i]
            //if this word is ambiguous ...
            
            if ( wd.data.wordType == .ambiguous ){
                let amb = wd.word as! Ambiguous
                if amb.isPossiblePrepositionalPronoun() && prevWordType == .preposition {
                    wd = convertAmbiguousToNewType(sd: wd, newType: .prepositionalPronoun)
                    sentenceCopy.remove(at: i)
                    sentenceCopy.insert(wd, at: i)
                }
                if amb.isPossibleSubjectPronoun() && i < 2 {
                    //if this is the first or second word, then it has to be a subject
                    wd = convertAmbiguousToNewType(sd: wd, newType: .subjectPronoun)
                    sentenceCopy.remove(at: i)
                    sentenceCopy.insert(wd, at: i)
                    continue
                }
            }
            prevWordType = wd.data.wordType
        }
        return sentenceCopy
    }
    
    func convertAmbiguousToNewType(sd: SentenceData, newType: WordType)->SentenceData{
        var wd = sd
        var pronounResult : (PronounType, Gender, Person)
        switch m_language{
        case .French:
            var p : FrenchPronoun
            switch newType {
            case .subjectPronoun:
                p = FrenchPronoun(word: wd.word.word, def: "", type: .SUBJECT)
                pronounResult = p.isSubjectPronoun(word: wd.word.word)
            case  .prepositionalPronoun:
                p = FrenchPronoun(word: wd.word.word, def: "", type: .PREPOSITIONAL)
                pronounResult = p.isPrepositionalPronoun(word: wd.word.word)
            default:
                p = FrenchPronoun(word: wd.word.word, def: "", type: .NON_PRONOUN)
                pronounResult = p.isPrepositionalPronoun(word: wd.word.word)
            }
            
            if ( pronounResult.0 != .none ){
                wd.word = p
                wd.data.wordType = .pronoun
                wd.data.pronounType = pronounResult.0
                wd.data.gender = pronounResult.1
                wd.data.person = pronounResult.2
            }
        case .Spanish:
            var p : SpanishPronoun
            if  newType == .subjectPronoun{
                p = SpanishPronoun(word: wd.word.word, def: "", type: .SUBJECT)
                pronounResult = p.isSubjectPronoun(word: wd.word.word)
            }
            else { //if newType == .prepositionalPronoun{
                p = SpanishPronoun(word: wd.word.word, def: "", type: .PREPOSITIONAL)
                pronounResult = p.isPrepositionalPronoun(word: wd.word.word)
            }
            
            //replace this sentence data struct
            
            if ( pronounResult.0 != .none ){
                wd.word = p
                wd.data.wordType = .pronoun
                wd.data.pronounType = pronounResult.0
                wd.data.gender = pronounResult.1
                wd.data.person = pronounResult.2
            }
        case .English:
            wd = sd
        case .Italian, .Portuguese:
            wd = sd
        case .Agnostic: wd = sd
        }
        return wd
    }

}
