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
    @State private var wordSelected = false
    
    var s1 = 0
    var s2 = 0
    
    
    
    var body: some View {
        
        HStack{
            Button(action: {
                currentLanguage = .Spanish
                m_clause = dIndependentClause(language: currentLanguage)
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                //currentLanguageString = "Spanish"
                createRandomClause()
            }){
                Text("Spanish")
            }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
            Button(action: {
                currentLanguage = .French
                m_clause = dIndependentClause(language: currentLanguage)
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                //currentLanguageString = "French"
                createRandomClause()
            }){
                Text("French")
            }.font(currentLanguage == .Spanish ? .system(size: 20) : .title)
            .foregroundColor(currentLanguage == .Spanish ? Color(UIColor(named: "SurgeryBackground")!) : Color.red)
        }.onAppear{
            currentLanguage = cfModelView.getCurrentLanguage()
        }.padding()
        
        VStack(alignment: .leading){
            Text("Random sentence:")
            
            VStack {
                HStack{
                    ForEach(singleIndexList1, id: \.self){index in
                        Button(action: {
                            currentSingleIndex = index
                            wordSelected.toggle()
                            wordSelected ? wordSurgery(single: singleList[index]) : changeWord()
                        }){
                            Text(singleList[index].getProcessWordInWordStateData())
                                .font(.callout)
                                .foregroundColor(index == currentSingleIndex ? .purple : .black)
                        }
                    }
                }
                HStack{
                    ForEach(singleIndexList2, id: \.self){index in
                        Button(action: {
                            currentSingleIndex = index
                            wordSelected.toggle()
                            wordSelected ? wordSurgery(single: singleList[index]) : changeWord()
                        }){
                            Text(singleList[index].getProcessWordInWordStateData())
                                .font(.callout)
                                .foregroundColor(index == currentSingleIndex ? .purple : .black)
                        }
                    }
                }
            }.border(Color.green)
            .padding(10)
            VStack{
                HStack(alignment: .center){
                    Button(action: {createRandomClause( )}) {
                        Text("Random sentence")
                            .padding(10)
                            .background(Color.green)
                            .foregroundColor(Color.yellow)
                    }
                    Button(action: {processSentence2( )}) {
                        Text("Subject-verb")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(Color.yellow)
                    }
                }
            }
            .padding()
            .onAppear{currentLanguage = .Spanish
                cfModelView.createNewModel(language: currentLanguage)
                createRandomClause()
            }
            
            VStack(alignment: .center){
                Button(action: {
                    generateRandomTense()
                }){
                    HStack (alignment: .center){
                        Text("Tense: ").background(Color.yellow).foregroundColor(.black)
                        Text("\(currentTense.rawValue)").background(Color.red).foregroundColor(.white)
                    }
                }
                
                /*
                 Button(action: {
                 generateRandomPerson()
                 }){
                 HStack {
                 Text("Person: ").background(Color.yellow).foregroundColor(.black)
                 Text("\(currentPerson.getEnumString())").background(Color.red).foregroundColor(.white)
                 }
                 }
                 */
            }
        }
        .padding()
        
        VStack {
            NavigationLink(destination: AddVerbToDictionary()){
                Text("Add new verb to dictionary")
            }.frame(width: 200, height: 50)
            .foregroundColor(.white)
            .padding(.leading, 10)
            .background(Color.orange)
        }
        
        VStack(alignment: .center){
            Text("Word surgery").font(.headline)
            Text(surgicalMessage).font(.caption).foregroundColor(.red)
            Text(surgicalWord)
            Text(surgicalEnglish)
            Text(surgicalProcessedWord)
            Text(surgicalLine1)
            Text(surgicalLine2)
            Text(surgicalLine3)
            Text(surgicalLine4)
            Text(surgicalLine5)
        }.border(Color.green)
        .background(Color(UIColor(named: "SurgeryBackground")!))
        .padding(5)
        Spacer()
        
    }
    
    func addNewWord(){
        
    }
    
    func changeWord(){
        let single = singleList[currentSingleIndex]
        var wsd = single.getSentenceData()
        let newSingle = RandomWordLists(wsp: cfModelView.getParser()).getRandomWordAsSingle(wordType : wsd.wordType, isSubject:false)
        switch wsd.wordType {
        case .verb:
            single.copyGuts(newSingle: newSingle)
            let newVerbSingle = newSingle as! dVerbSingle
            var spVerb = newVerbSingle.getClusterWord() as! RomanceVerb
            let bVerb = spVerb.getBVerb()
            let verbSingle = single as! dVerbSingle
            spVerb = verbSingle.getClusterWord() as! RomanceVerb
            spVerb.setBVerb(bVerb: bVerb)
        case .adjective, .article:
            single.copyGuts(newSingle: newSingle)
        case .noun:
            let nounSingle = single as! dNounSingle
            nounSingle.copyGuts(newSingle: newSingle)
        case .preposition:
            single.copyGuts(newSingle: newSingle)
        default: break
        }
        wsd = single.getSentenceData()
        m_clause.processInfo()
        currentPerson = m_clause.getPerson()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
        UpdateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
    func wordSurgery(single: dSingle){
        let wsd = single.getSentenceData()
        surgicalMessage = "Click on another word to examine"
        surgicalWord =         "\(wsd.wordType.rawValue): \(wsd.word.word)"
        switch wsd.wordType {
        case .noun:
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            surgicalLine1 = "Noun type: \(wsd.nounType.rawValue)"
            surgicalLine2 = "Gender:    \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:    \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .adjective:
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            surgicalLine1 = "Adjective type: \(wsd.adjectiveType.rawValue)"
            surgicalLine2 = "Gender:         \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:         \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .article:
            surgicalProcessedWord = "Current form: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            surgicalLine1 = "Article type: \(wsd.articleType.rawValue)"
            surgicalLine2 = "Gender:       \(wsd.gender.rawValue)"
            surgicalLine3 = "Number:       \(wsd.number.rawValue)"
            surgicalLine4 = ""
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .verb:
            surgicalProcessedWord = "Conjugated: \(wsd.getProcessedWord())"
            surgicalEnglish = "English: \(wsd.word.def)"
            let verb = wsd.word as! RomanceVerb
            let bVerb = verb.getBVerb() as! BRomanceVerb
            if currentLanguage == .Spanish {  surgicalLine1 = "French:  \(verb.french)" }
            else { surgicalLine1 = "Spanish: \(verb.spanish)"    }
            surgicalLine2 = "Tense:      \(currentTense.rawValue)"
            surgicalLine3 = "Person:     \(currentPerson.getEnumString())"
            surgicalLine3 = "Verb model: \(bVerb.getBescherelleInfo())"
            surgicalLine5 = ""
            surgicalLine6 = ""
        case .preposition:
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
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            let tense = currentTense
            while tense == currentTense {
                currentTense = cfModelView.getRandomTense()
            }
            m_clause = cfModelView.getRandomSentence()
            currentPerson = m_clause.getPerson()
            sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
            UpdateCurrentSentenceViewStuff()
            clearWordSurgery()
        }
    }
    
    func UpdateCurrentSentenceViewStuff(){
        clearWordSurgery()
        var letterCount = 0
        var wordCount = 0
        singleList.removeAll()
        singleList = m_clause.getSingleList()
        
        for single in singleList {
            let wsd = single.getSentenceData()
            letterCount += wsd.word.word.count + 1
            wordCount += 1
            if letterCount > 30 {break}
            print("processSentence1: \(single.getProcessWordInWordStateData())")
        }
        
        singleIndexList1.removeAll()
        singleIndexList2.removeAll()
        print("\nWordStateData ... processed words")
        for i in 0 ..< wordCount {
            singleIndexList1.append(i)
        }
        for i in wordCount ..< singleList.count {
            singleIndexList2.append(i)
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
        UpdateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(tense: currentTense, person: currentPerson)
        UpdateCurrentSentenceViewStuff()
        wordSurgery(single: singleList[currentSingleIndex])
    }
    
}

struct SentenceGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceGameView()
    }
}
