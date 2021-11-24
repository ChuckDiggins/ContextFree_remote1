//
//  AgnosticSentenceView.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/25/21.
//

import SwiftUI

struct NewPhrasesIn3LanguagesView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State  var singleIndexList = [[Int]]()
    @State var singleList = [dSingle]()
    @State var newWordSelected = [Bool]()
    @State var backgroundColor = [Color]()
    @State var currentSingleIndex = 0
    
    //@State private var currentLanguageString = ""
    @State private var currentTense = Tense.preterite
    @State private var currentPerson = Person.S3
    @State private var sentenceString: String = ""
    
    @State private var englishSingleList = [dSingle]()
    @State var m_clause = dIndependentAgnosticClause()
    @State var m_englishClause = dIndependentAgnosticClause()
    @State var defaultBackgroundColor = Color.yellow
    @State var highlightBackgroundColor = Color.black
    
    //@State private var newWordSelected = false
    
    @State var m_randomSentence : RandomSentence!
    @State var hasClause = false
    @State private var isSubject = false
    
    var phraseType = ["Subject pronoun / Verb",
                      "Simple noun phrase",
                      "Complex preposition phrase",
                      "Verb-adverb phrase",
                      "Simple clause"
    ]
    @State private var selectedPhraseIndex = 4
    @State var m_randomPhraseType = RandomPhraseType.simpleClause
    @ObservedObject var clauseModel = ClauseModel()
    
    var body: some View {
        GeometryReader{ geometry in
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
                    if ( hasClause ){
                        SentenceView(language: .Spanish, changeWord: {self.changeWord()}, clauseModel: clauseModel)
                        SentenceView(language: .French, changeWord: {self.changeWord()}, clauseModel: clauseModel)
                        SentenceView(language: .English, changeWord: {self.changeWord()}, clauseModel: clauseModel)
                    }
                }.onAppear{
                    singleIndexList = Array(repeating: Array(repeating: 0, count: 10), count: 5)
                    singleIndexList[1][0] = 1
                    singleIndexList[2][0] = 2
                    cfModelView.createNewModel(language: .Agnostic)
                    createRandomClause()
                    m_randomSentence = cfModelView.getRandomSentenceObject()
                    hasClause.toggle()
                }
                .padding(10)
                .border(Color.green)
                .background(Color.white)
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
        }//geometryReader
    }
    
    
    func changeWord(){
        let single = singleList[clauseModel.currentSingleIndex]
        let clauseManipulation = clauseManipulation()
        m_clause.setTense(value: currentTense)
        m_clause.setPerson(value: currentPerson)
        clauseManipulation.changeWordInClause(cfModelView: cfModelView, clause: m_clause, single: single, isSubject: isSubject)
        clauseManipulation.handleFrenchContractions(singleList: m_clause.getSingleList())
        currentPerson = m_clause.getPerson()
        currentTense = m_clause.getTense()
        updateCurrentSentenceViewStuff()
    }

    func processPhraseSelection(){
        isSubject = false
        switch selectedPhraseIndex{
        case 0:
            m_randomPhraseType = RandomPhraseType.subjectPronounVerb
            isSubject = true
        case 1: m_randomPhraseType = RandomPhraseType.simpleNounPhrase
        case 2: m_randomPhraseType = RandomPhraseType.simplePrepositionPhrase
        case 3: m_randomPhraseType = RandomPhraseType.simpleVerbAdverbPhrase
        case 4: m_randomPhraseType = RandomPhraseType.simpleClause
        default:
            m_randomPhraseType = RandomPhraseType.simpleClause
        }
    }
    
    func createRandomClause(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        processPhraseSelection()
        let clauseManipulation = clauseManipulation()
        let result = clauseManipulation.createRandomClause(cfModelView: cfModelView, tense: currentTense, randomPhraseType: m_randomPhraseType)
        m_clause = result.0
        m_englishClause = result.1
        
        currentPerson = m_clause.getPerson()
        let fs  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        print("French phrase: \(fs)")
        let ss  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        print("Spanish phrase: \(ss)")
        let es  = m_englishClause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        print("English phrase: \(es)")
        
        clauseManipulation.handleFrenchContractions(singleList: m_clause.getSingleList())
        updateCurrentSentenceViewStuff()
        clearWordSurgery()
//        clauseManipulation.countStringLengths(clause: m_clause, englishClause: m_englishClause)
    }
    
    
    func updateCurrentSentenceViewStuff(){
        // clearWordSurgery()
        var letterCount = 0
        var singleCount = 0
        backgroundColor.removeAll()
        singleList.removeAll()
        singleList = m_clause.getSingleList()
        englishSingleList = m_englishClause.getSingleList()
        currentSingleIndex = clauseModel.currentSingleIndex
        
        for single in singleList {
            letterCount += single.getProcessWordInWordStateData(language: .Spanish).count + 1
            singleCount += 1
            if letterCount > 30 {break}
        }
        
        for i in 0..<3  { singleIndexList[i].removeAll() }
        
        newWordSelected.removeAll()
        
        for i in 0 ..< singleCount {
            singleIndexList[0].append(i)
            newWordSelected.append(false)
            backgroundColor.append(defaultBackgroundColor)
        }
        for i in singleCount ..< singleList.count {
            singleIndexList[1].append(i)
            newWordSelected.append(false)
            backgroundColor.append(defaultBackgroundColor)
        }
        backgroundColor[currentSingleIndex] = highlightBackgroundColor
        //fill the clause model
        clauseModel.currentSingleIndex = currentSingleIndex
        clauseModel.singleList = singleList
        clauseModel.englishSingleList = englishSingleList
        clauseModel.singleIndexList = singleIndexList
        clauseModel.newWordSelected = newWordSelected
        clauseModel.backgroundColor = backgroundColor
    }
    
    func processSentence2(){
        m_clause = cfModelView.getAgnosticRandomSubjPronounSentence()
        sentenceString = m_clause.createNewSentenceString(language: .Spanish)
        singleList = m_clause.getSingleList()
    }
    
    func generateRandomTense(){
        currentTense = cfModelView.getNextTense()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
        //wordSurgery(single: singleList[currentSingleIndex])
    }
    
    
    
}


struct NewPhrasesIn3LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        NewPhrasesIn3LanguagesView()
    }
}


