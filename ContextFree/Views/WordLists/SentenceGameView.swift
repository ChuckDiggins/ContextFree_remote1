//
//  RandomSentenceGeneratorView.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct SentenceGameView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    //@State private var currentLanguageString = ""
    @State private var currentTense = Tense.preterite
    @State private var currentPerson = Person.S3
    @State private var sentenceString: String = ""
    //@State private var wsdList = [WordStateData]()
    @State private var singleList = [dSingle]()
    @State private var currentWordIndex = 0
    @State private var singleIndexList1 = [Int]()
    @State private var singleIndexList2 = [Int]()
    //@State private var currentWsd = WordStateData()
    @State private var currentSingleIndex = 0
    @State private var surgicalTitle = "Word surgery"
    @State private var surgicalWord = ""
    @State private var surgicalProcessedWord = ""
    @State private var surgicalEnglish = ""
    @State private var surgicalBescherelleInfo = ""
    @State private var surgicalMessage = "Click on word in sentence to perform surgery"
    @State private var surgicalLine1 = ""
    @State private var surgicalLine2 = ""
    @State private var surgicalLine3 = ""
    @State private var surgicalLine4 = ""
    @State private var surgicalLine5 = ""
    @State private var surgicalLine6 = ""
    @State private var m_clause = dIndependentClause(language: .Spanish)
    @State private var newWordSelected = false
    @State private var newWordSelected1 = [Bool]()
    @State var m_randomSentence : RandomSentence!
    
    var s1 = 0
    var s2 = 0
    
    
    
    var body: some View {
        
        HStack{
            Button(action: {
                currentLanguage = .Spanish
                m_clause = dIndependentClause(language: currentLanguage)
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                createRandomClause()
                m_randomSentence = cfModelView.getRandomSentenceObject()
            }){
                Text("Spanish")
            }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
            Button(action: {
                currentLanguage = .French
                m_clause = dIndependentClause(language: currentLanguage)
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                createRandomClause()
                m_randomSentence = cfModelView.getRandomSentenceObject()
            }){
                Text("French")
            }.font(currentLanguage == .Spanish ? .system(size: 20) : .title)
            .foregroundColor(currentLanguage == .Spanish ? Color(UIColor(named: "SurgeryBackground")!) : Color.red)
            Button(action: {
                currentLanguage = .English
                m_clause = dIndependentClause(language: currentLanguage)
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                createRandomClause()
                m_randomSentence = cfModelView.getRandomSentenceObject()
            }){
                Text("English")
            }.font(currentLanguage == .English ? .system(size: 20) : .title)
            .foregroundColor(currentLanguage == .Spanish ? Color(UIColor(named: "SurgeryBackground")!) : Color.red)
        }.onAppear{
            currentLanguage = cfModelView.getCurrentLanguage()
        }.padding()
        
        //VStack(alignment: .leading){
        VStack{
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
                            Text(singleList[index].getProcessWordInWordStateData())
                                .font(.subheadline)
                                .foregroundColor(index == currentSingleIndex ? .red : .black)
                        }
                    }
                }
                //part2
                HStack{
                    ForEach(singleIndexList2, id: \.self){index in
                        Button(action: {
                            currentSingleIndex = index
                            newWordSelected1[currentSingleIndex].toggle()
                            newWordSelected1[currentSingleIndex] ? wordSurgery(single: singleList[index]) : changeWord()
                        }){
                            Text(singleList[index].getProcessWordInWordStateData())
                                .font(.subheadline)
                                .foregroundColor(index == currentSingleIndex ? .red : .black)
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
                    Button(action: {processSentence2( )}) {
                        Text("Subject-verb")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(Color.yellow)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
            }
            .padding()
            .onAppear{currentLanguage = .Spanish
                cfModelView.createNewModel(language: currentLanguage)
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
        
        
        VStack(alignment: .center){
            Text(surgicalTitle).font(.headline)
            Text(surgicalMessage).font(.caption).foregroundColor(.red)
                .padding(2)
            Text(surgicalWord).font(Font.body.bold())
            Text(surgicalProcessedWord).font(Font.body.bold())
            Text(surgicalEnglish)
            Text(surgicalLine1)
            Text(surgicalLine2)
            Text(surgicalLine3)
            Text(surgicalLine4)
            Text(surgicalLine5)
        }
        .border(Color.green)
        .background(Color(UIColor(named: "SurgeryBackground")!))
        .padding(50)
        Spacer()
        
    }
    
    func addNewWord(){
        
    }
    
    func changeWord(){
        let single = singleList[currentSingleIndex]
        var wsd = single.getSentenceData()
        switch wsd.wordType {
        case .verb:
            switch currentLanguage{
            case .Spanish, .French:
                let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
                single.copyGuts(newSingle: newSingle)
                let newVerbSingle = newSingle as! dVerbSingle
                var spVerb = newVerbSingle.getClusterWord() as! RomanceVerb
                let bVerb = spVerb.getBVerb()
                let verbSingle = single as! dVerbSingle
                spVerb = verbSingle.getClusterWord() as! RomanceVerb
                spVerb.setBVerb(bVerb: bVerb)
            case .English:
                let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
                single.copyGuts(newSingle: newSingle)
                let newVerbSingle = newSingle as! dVerbSingle
                var spVerb = newVerbSingle.getClusterWord() as! EnglishVerb
                let bVerb = spVerb.getBVerb()
                let verbSingle = single as! dVerbSingle
                spVerb = verbSingle.getClusterWord() as! EnglishVerb
                spVerb.setBVerb(bVerb: bVerb)
            default: break
            }
        case .adjective, .determiner:
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
            single.copyGuts(newSingle: newSingle)
        case .noun:
            let nounSingle = single as! dNounSingle
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:nounSingle.isSubject())
            nounSingle.copyGuts(newSingle: newSingle)
        case .preposition:
            let newSingle = m_randomSentence.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
            single.copyGuts(newSingle: newSingle)
        default: break
        }
        wsd = single.getSentenceData()
        m_clause.processInfo()
        currentPerson = m_clause.getPerson()
        //m_clause.dumpNounPhraseData()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
        //m_clause.dumpNounPhraseData()
        handleFrenchContractions()
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
            surgicalEnglish = "English: \(wsd.word.def)"
            surgicalLine1 = "Noun type: \(wsd.nounType.rawValue)"
            surgicalLine2 = "Gender:    \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:    \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .adjective:
            surgicalTitle = "Adjective"
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            surgicalLine1 = "Adjective type: \(wsd.adjectiveType.rawValue)"
            surgicalLine2 = "Gender:         \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:         \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .determiner:
            surgicalTitle = "Determiner"
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            surgicalLine1 = "Determiner type: \(wsd.determinerType.rawValue)"
            surgicalLine2 = "Gender:       \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:       \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .verb:
            surgicalTitle = "Verb"
            surgicalProcessedWord = "Conjugated: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            switch currentLanguage{
            case .Spanish:
                let verb = wsd.word as! RomanceVerb
                let bVerb = verb.getBVerb() as! BRomanceVerb
                surgicalLine1 = "French:  \(verb.french)"
                surgicalLine3 = "Verb model: \(bVerb.getBescherelleInfo())"
            case .French:
                let verb = wsd.word as! RomanceVerb
                let bVerb = verb.getBVerb() as! BRomanceVerb
                surgicalLine1 = "Spanish:  \(verb.spanish)"
                surgicalLine3 = "Verb model: \(bVerb.getBescherelleInfo())"
            case .English:
                let verb = wsd.word as! EnglishVerb
                let bVerb = verb.getBVerb() as! BEnglishVerb
                surgicalLine1 = "English:  \(verb.english)"
                surgicalLine3 = "Verb model: \(bVerb.getBescherelleInfo())"
            default: break
            }
            
            surgicalLine2 = "Tense:      \(currentTense.rawValue)"
            surgicalLine3 = "Person:     \(currentPerson.getEnumString())"
            
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .preposition:
            surgicalTitle = "Preposition"
            surgicalEnglish = "English: \(wsd.word.def)"
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
    
    func createRandomClause(){
        if currentLanguage == .French || currentLanguage == .Spanish || currentLanguage == .English {
            let tense = currentTense
            while tense == currentTense {
                currentTense = cfModelView.getRandomTense()
            }
            m_clause = cfModelView.getRandomSentence()
            currentPerson = m_clause.getPerson()
            sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
            handleFrenchContractions()
            updateCurrentSentenceViewStuff()
            clearWordSurgery()
        }
    }
    
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
    
    func updateCurrentSentenceViewStuff(){
        clearWordSurgery()
        var letterCount = 0
        var wordCount = 0
        singleList.removeAll()
        singleList = m_clause.getSingleList()
        
        for single in singleList {
            if single.getWordType() == .determiner {
                let det = single as! dDeterminerSingle
                let sd = det.getSentenceData()
                let detWord = det.getSentenceData().getProcessedWord()
                print ("\(detWord)")
            }
            let wsd = single.getSentenceData()
            letterCount += wsd.word.word.count + 1
            wordCount += 1
            if letterCount > 30 {break}
            //print("processSentence1: \(single.getProcessWordInWordStateData())")
        }
        
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
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            m_clause = cfModelView.getRandomSubjPronounSentence()
            sentenceString = m_clause.createNewSentenceString()
            singleList = m_clause.getSingleList()
        }
    }
    
    func generateRandomTense(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
}

struct SentenceGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceGameView()
    }
}
