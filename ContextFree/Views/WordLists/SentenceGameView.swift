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
    @State private var currentLanguageString = ""
    @State private var currentTense = Tense.present
    @State private var currentPerson = Person.S3
    @State private var sentenceString: String = ""
    @State private var wsdList = [WordStateData]()
    @State private var wsdIndex1 = [Int]()
    @State private var wsdIndex2 = [Int]()
    //@State private var currentWsd = WordStateData()
    @State private var currentWsdIndex = 0
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

    var s1 = 0
    var s2 = 0
    
    @State private var m_clause = dIndependentClause(language: .Spanish)
    
    var body: some View {
        
        VStack{
            HStack {
                Spacer()
                Button(action: {
                    currentLanguage = .Spanish
                    cfModelView.createNewModel(language: currentLanguage)
                    sentenceString = ""
                    currentLanguageString = "Spanish"
                    createRandomClause()
                }){
                    Text("Spanish")
                }
                Spacer()
                Button(action: {
                    currentLanguage = .French
                    cfModelView.createNewModel(language: currentLanguage)
                    sentenceString = ""
                    currentLanguageString = "French"
                    createRandomClause()
                }){
                    Text("French")
                }
                
            }.background(Color.yellow)
            .padding()
            Text("Current language: \(currentLanguageString)")
                .background(currentLanguage == .Spanish ? Color.orange : Color.pink)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Random sentence:")
            
            //Text(sentenceString).border(Color.green)
            VStack {
                HStack{
                    ForEach(wsdIndex1, id: \.self){index in
                        Button(action: {
                            currentWsdIndex = index
                            wordSurgery(wsd: wsdList[index])
                        }){
                            Text(wsdList[index].getProcessedWord())
                        }.background(Color.yellow)
                    }
                }.background(Color.yellow)
                HStack{
                    ForEach(wsdIndex2, id: \.self){index in
                        Button(action: {
                            currentWsdIndex = index
                            wordSurgery(wsd: wsdList[index])
                        }){
                            Text(wsdList[index].getProcessedWord())
                        }.background(Color.yellow)
                    }
                }.background(Color.yellow)
            }.border(Color.green)
            .padding()
            VStack{
                HStack{
                    Button(action: {createRandomClause( )}) {
                        Text("Random sentence")
                            .background(Color.green)
                            .foregroundColor(Color.yellow)
                    }
                    Button(action: {processSentence2( )}) {
                        Text("Subject-verb")
                            .background(Color.blue)
                            .foregroundColor(Color.yellow)
                    }
                }
            }
            .padding()
            .onAppear{currentLanguage = .Spanish
                cfModelView.createNewModel(language: currentLanguage)
                currentLanguageString = "Spanish"
                createRandomClause()
            }
            
            VStack{
                Button(action: {
                    generateRandomTense()
                }){
                    HStack {
                        Text("Tense: ").background(Color.yellow).foregroundColor(.black)
                    }
                    Text("\(currentTense.rawValue)").background(Color.red).foregroundColor(.white)
                }
                
                Button(action: {
                    generateRandomPerson()
                }){
                    HStack {
                        Text("Person: ").background(Color.yellow).foregroundColor(.black)
                        Text("\(currentPerson.getEnumString())").background(Color.red).foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        HStack {
            Button(action: {
                let wsd = wsdList[currentWsdIndex]
                var newSingle = RandomWordLists(wsp: cfModelView.getParser()).getRandomWordAsSingle(wordType : wsd.wordType, isSubject: false)
                var newWsd = newSingle.getSentenceData()
                switch wsd.wordType {
                case .verb:
                    newWsd.tense = currentTense
                    newWsd.person = currentPerson
                case .adjective, .article:
                    newWsd.gender = wsd.gender
                    newWsd.number = wsd.number
                case .noun:
                    newWsd.number = wsd.number
                default: break
                }
                newSingle.setSentenceData(data: newWsd)
                wsdList[currentWsdIndex] = newWsd
                print("newSingle = \(newSingle.getClusterWord().word)")
            }){
                Text("Change")
            }.background(Color.green)
        }
        VStack{
            Text("Word surgery").font(.headline)
            Text(surgicalMessage).font(.caption).foregroundColor(.red)
            Text(surgicalWord)
            Text(surgicalProcessedWord)
            Text(surgicalLine1)
            Text(surgicalLine2)
            Text(surgicalLine3)
            Text(surgicalLine4)
            Text(surgicalLine5)
            Text(surgicalLine6)
        }.border(Color.green)
        .padding(5)
        Spacer()
    }
    
    func wordSurgery(wsd: WordStateData){
        surgicalMessage = "Click on another word to examine"
        surgicalWord =         "\(wsd.wordType.rawValue): \(wsd.word.word)"
        
        switch wsd.wordType {
        case .noun:
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalLine1 = "Noun type: \(wsd.nounType.rawValue)"
            surgicalLine2 = "Gender:    \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:    \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .adjective:
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalLine1 = "Adjective type: \(wsd.adjectiveType.rawValue)"
            surgicalLine2 = "Gender:         \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:         \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .article:
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalLine1 = "Article type: \(wsd.articleType.rawValue)"
            surgicalLine2 = "Gender:       \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:       \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .verb:
            surgicalProcessedWord = "Conjugated: \(wsd.getProcessedWord())"
            let verb = wsd.word as! RomanceVerb
            let bVerb = verb.getBVerb() as! BRomanceVerb
            surgicalLine1 = "Verb type:  \(wsd.verbType.rawValue)"
            surgicalLine2 = "Tense:      \(currentTense.rawValue)"
            surgicalLine3 = "Person:     \(currentPerson.getEnumString())"
            surgicalLine3 = "Verb model: \(bVerb.getBescherelleInfo())"
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .preposition:
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
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            m_clause = cfModelView.getRandomSentence()
            sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
            UpdateCurrentSentenceViewStuff()
            clearWordSurgery()
        }
    }
    
    func UpdateCurrentSentenceViewStuff(){
        clearWordSurgery()
        var letterCount = 0
        var wordCount = 0
        wsdList.removeAll()
        wsdList = m_clause.getWordStateDataList()
        for wsd in wsdList {
            letterCount += wsd.word.word.count + 1
            wordCount += 1
            if letterCount > 30 {break}
            print("processSentence1: \(wsd.getProcessedWord())")
        }
        
        wsdIndex1.removeAll()
        wsdIndex2.removeAll()
        print("\nWordStateData ... processed words")
        for i in 0 ..< wordCount {
            wsdIndex1.append(i)
        }
        for i in wordCount ..< wsdList.count {
            wsdIndex2.append(i)
        }
        
    }
    
    func processSentence2(){
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            m_clause = cfModelView.getRandomSubjPronounSentence()
            sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
            wsdList = m_clause.getWordStateDataList()
        }
    }
    
    func generateRandomTense(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
        UpdateCurrentSentenceViewStuff()
        wordSurgery(wsd: wsdList[currentWsdIndex])
    }
    
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
        UpdateCurrentSentenceViewStuff()
        wordSurgery(wsd: wsdList[currentWsdIndex])
    }
    
}

struct SentenceGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceGameView()
    }
}
