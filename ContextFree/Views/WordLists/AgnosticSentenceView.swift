//
//  AgnosticSentenceView.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/25/21.
//

import SwiftUI

struct AgnosticSentenceView: View {
    @EnvironmentObject var cfModelView : CFModelView
    //@State private var currentLanguageString = ""
    @State private var currentTense = Tense.preterite
    @State private var currentPerson = Person.S3
    @State private var sentenceString: String = ""
    @State private var singleList = [dSingle]()
    @State private var englishSingleList = [dSingle]()
    @State private var singleIndexList1 = [Int]()
    @State private var singleIndexList2 = [Int]()
    @State private var currentSingleIndex = 0
    @State private var surgicalTitle = "Word surgery"
    @State private var surgicalWord = ""
    @State private var surgicalProcessedWord = ""
    @State private var surgicalEnglish = ""
    @State private var surgicalSpanish = ""
    @State private var surgicalFrench = ""
    @State private var surgicalBescherelleInfo = ""
    @State private var surgicalMessage = "Click on word in sentence to perform surgery"
    @State private var surgicalLine1 = ""
    @State private var surgicalLine2 = ""
    @State private var surgicalLine3 = ""
    @State private var surgicalLine4 = ""
    @State private var surgicalLine5 = ""
    @State private var surgicalLine6 = ""
    @State private var m_clause = dIndependentAgnosticClause()
    @State private var m_englishClause = dIndependentAgnosticClause()
    @State private var newWordSelected = false
    @State private var newWordSelected1 = [Bool]()
    @State var m_randomSentence : RandomSentence!
    
    var phraseType = ["Subject pronoun / Verb",
                       "Simple noun phrase",
                       "Complex preposition phrase",
                       "Verb-adverb phrase",
                       "Simple clause"
                    ]
    @State private var selectedPhraseIndex = 0
    @State var m_randomPhraseType = RandomPhraseType.subjectPronounVerb
    
    var body: some View {
        VStack{
            VStack{
                Picker("Phrase type picker:", selection: $selectedPhraseIndex, content: {
                    Text(phraseType[0]).tag(0).font(.subheadline)
                    Text(phraseType[1]).tag(1).font(.subheadline)
                    Text(phraseType[2]).tag(2).font(.subheadline)
                    Text(phraseType[3]).tag(3).font(.subheadline)
                    Text(phraseType[4]).tag(4).font(.subheadline)
                }
                )
                //processPhraseSelection()
                Text("Selected phrase: \(phraseType[selectedPhraseIndex])").font(.subheadline)
            }
            .labelsHidden()
            .font(.subheadline)
            .padding(10)
            Text("Random sentence:")
            VStack {
                //part 1
                HStack{
                    ForEach(singleIndexList1, id: \.self){index in
                        Button(action: {
                            currentSingleIndex = index
                            newWordSelected1[currentSingleIndex].toggle()
                            newWordSelected1[currentSingleIndex] ? wordSurgery(single: singleList[index]) : changeWord()
                        }){
                            VStack{
                                Text(singleList[index].getProcessWordInWordStateData(language: .Spanish))
                                    .font(.subheadline)
                                    .foregroundColor(index == currentSingleIndex ? .red : .black)
                                Text(singleList[index].getProcessWordInWordStateData(language: .French))
                                    .font(.subheadline)
                                    .foregroundColor(index == currentSingleIndex ? .red : .black)
                                Text(englishSingleList[index].getProcessWordInWordStateData(language: .English))
                                    .font(.subheadline)
                                    .foregroundColor(index == currentSingleIndex ? .red : .black)
                            }
                        }
                    }
                    
                }
                .padding(10)
                //part2
                HStack{
                    ForEach(singleIndexList2, id: \.self){index in
                        Button(action: {
                            currentSingleIndex = index
                            newWordSelected1[currentSingleIndex].toggle()
                            newWordSelected1[currentSingleIndex] ? wordSurgery(single: singleList[index]) : changeWord()
                        }){
                            VStack{
                                Text(singleList[index].getProcessWordInWordStateData(language: .Spanish))
                                    .font(.subheadline)
                                    .foregroundColor(index == currentSingleIndex ? .red : .black)
                                Text(singleList[index].getProcessWordInWordStateData(language: .French))
                                    .font(.subheadline)
                                    .foregroundColor(index == currentSingleIndex ? .red : .black)
                                Text(englishSingleList[index].getProcessWordInWordStateData(language: .English))
                                    .font(.subheadline)
                                    .foregroundColor(index == currentSingleIndex ? .red : .black)
                            }
                        }
                    }
                }
                
            }.border(Color.green)
            .background(Color.white)
            .padding(10)
            VStack{
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {createRandomClause( )}) {
                        Text("Random sentence")
                            .padding(10)
                            .background(Color.green)
                            .foregroundColor(Color.yellow)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
            }
            .padding()
            .onAppear{
                cfModelView.createNewModel(language: .Agnostic)
                m_randomSentence = cfModelView.getRandomSentenceObject()
                createRandomClause()
            }
            
            VStack(alignment: .center){
                Button(action: {
                    generateRandomTense()
                }){
                    HStack {
                        Text("Tense: \(currentTense.rawValue)").background(Color.yellow).foregroundColor(.black).frame(width: 250, height: 80)
                            .cornerRadius(10).padding(25)
                        
                    }
                }
            }
        }
        .padding()
    }

    func changeWord(){
        let single = singleList[currentSingleIndex]
        var wsd = single.getSentenceData()
        
        switch wsd.wordType {
        case .verb:
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
            single.copyGuts(newSingle: newSingle) 
        case .adjective, .determiner, .adverb, .conjunction:
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
            single.copyGuts(newSingle: newSingle)
        case .noun:
            let nounSingle = single as! dNounSingle
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:nounSingle.isSubject())
            nounSingle.copyGuts(newSingle: newSingle)
            if nounSingle.isSubject() {
                m_clause.setPerson(value: nounSingle.getPerson())
            }
        case .preposition:
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
            single.copyGuts(newSingle: newSingle)
        default: break
        }
        wsd = single.getSentenceData()
        m_clause.processInfo()
        currentPerson = m_clause.getPerson()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
    func processPhraseSelection(){
        switch selectedPhraseIndex{
        case 0: m_randomPhraseType = RandomPhraseType.subjectPronounVerb
        case 1: m_randomPhraseType = RandomPhraseType.simpleNounPhrase
        case 2: m_randomPhraseType = RandomPhraseType.simplePrepositionPhrase
        case 3: m_randomPhraseType = RandomPhraseType.simpleVerbAdverbPhrase
        case 4: m_randomPhraseType = RandomPhraseType.simpleClause
        default:
            m_randomPhraseType = RandomPhraseType.subjectPronounVerb
        }
    }
        
    func createRandomClause(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        
        //m_clause = cfModelView.getRandomAgnosticSentence()
        processPhraseSelection()
        m_clause = cfModelView.getRandomAgnosticSentence(rft: m_randomPhraseType)
        currentPerson = m_clause.getPerson()
        let fs  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        print("French phrase: \(fs)")
        let ss  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        print("Spanish phrase: \(ss)")
        
        m_englishClause = dIndependentAgnosticClause()
        m_englishClause.copy(inClause: m_clause)
        m_englishClause.convertRomancePhraseOrderToEnglishPhraseOrder()
        let es  = m_englishClause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        print("English phrase: \(es)")
        
        //handleFrenchContractions()
        updateCurrentSentenceViewStuff()
        clearWordSurgery()
    }
    
    /*
    func handleFrenchContractions(){
        if currentLanguage == .French {
            //singleList = m_clause.getSingleList()
            
            //never check last word, because there can't be a phonetic contraction
            
            for i in 0 ..< singleList.count-1 {
                let single = singleList[i]
                let wsd = single.getSentenceData()
                switch wsd.wordType {
                case .article:
                    if wsd.gender == .masculine && wsd.number == .singular && wsd.articleType == .definite  {
                        let nextSingle = singleList[i+1]
                        print("next single = \(nextSingle.getClusterWord().word) -- starts with a vowel \(nextSingle.startsWithVowelSound() )")
                        if nextSingle.startsWithVowelSound() {
                            single.setProcessWordInWordStateData(str: "l'")
                        } else {
                            single.setProcessWordInWordStateData(str: "le")
                        }
                    }
                case .subjectPronoun:
                    break
                default: break
                }
                
            }
        }
    }
    */
    

    func updateCurrentSentenceViewStuff(){
        clearWordSurgery()
        var letterCount = 0
        var wordCount = 0
        singleList.removeAll()
        singleList = m_clause.getSingleList()
        englishSingleList = m_englishClause.getSingleList()
        
        for single in singleList {
            let wsd = single.getSentenceData()
            letterCount += wsd.word.word.count + 1
            wordCount += 1
            if letterCount > 30 {break}
            //print("processSentence1: \(single.getProcessWordInWordStateData())")
        }
        
        singleIndexList1.removeAll()
        singleIndexList2.removeAll()
        
        singleIndexList1.removeAll()
        singleIndexList2.removeAll()
        
        newWordSelected1.removeAll()
        print("\nWordStateData ... processed words")
        for i in 0 ..< wordCount {
            singleIndexList1.append(i)
            newWordSelected1.append(false)
        }
        for i in wordCount ..< singleList.count {
            singleIndexList2.append(i)
            newWordSelected1.append(false)
        }
    }
    
    func processSentence2(){
        m_clause = cfModelView.getAgnosticRandomSubjPronounSentence()
        sentenceString = m_clause.createNewSentenceString(language: .Spanish)
        singleList = m_clause.getSingleList()
    }
    
    func generateRandomTense(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
    func wordSurgery(single: dSingle){
        let wsd = single.getSentenceData()
        surgicalMessage = "Click on another word to examine"
        surgicalWord =         "\(wsd.wordType.rawValue): \(wsd.word.word)"
        switch wsd.wordType {
        case .noun:
            surgicalTitle = "Noun"
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \("")"
            surgicalLine1 = "Noun type: \(wsd.nounType.rawValue)"
            surgicalLine2 = "Gender:    \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:    \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .adjective:
            surgicalTitle = "Adjective"
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \("")"
            surgicalLine1 = "Adjective type: \(wsd.adjectiveType.rawValue)"
            surgicalLine2 = "Gender:         \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:         \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .determiner:
            surgicalTitle = "Determiner"
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \("")"
            surgicalLine1 = "Determiner type: \(wsd.determinerType.rawValue)"
            surgicalLine2 = "Gender:       \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:       \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .verb:
            surgicalTitle = "Verb"
            surgicalProcessedWord = "Conjugated: \(wsd.getProcessedWord())"
            
            let verb = wsd.word as! Verb
            surgicalSpanish = "Spanish: \(verb.spanish)"
            surgicalFrench = "French: \(verb.french)"
            surgicalEnglish = "English: \(verb.english)"
            surgicalLine2 = "Tense:      \(currentTense.rawValue)"
            surgicalLine3 = "Person:     \(currentPerson.getEnumString())"
            
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .preposition:
            surgicalTitle = "Preposition"
            surgicalEnglish = "English: \("")"
            surgicalLine1 = "Preposition type: \(wsd.prepositionType.rawValue)"
            surgicalLine2 = ""
            surgicalLine3 = ""
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        default: break
        }
        
    }
    
    func clearWordSurgery(){
        surgicalMessage = "Click on word in sentence to perform surgery"
        surgicalWord = ""
        surgicalProcessedWord = ""
        surgicalLine1 = ""
        surgicalLine2 = ""
        surgicalLine3 = ""
        surgicalLine4 = ""
        surgicalLine5 = ""
        surgicalLine6 = ""
    }

    
}

struct AgnosticSentenceView_Previews: PreviewProvider {
    static var previews: some View {
        AgnosticSentenceView()
    }
}
