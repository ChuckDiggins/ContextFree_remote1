//
//  RandomSentenceGeneratorView.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct PhraseInSingleLanguageView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    
    @State private var currentTense = Tense.preterite
    @State private var currentPerson = Person.S3
    @State private var sentenceString: String = ""

    @State  var singleIndexList = [[Int]]()
    @State var singleList = [dSingle]()
    @State var newWordSelected = [Bool]()
    @State var backgroundColor = [Color]()
    @State var currentSingleIndex = 0

    @State private var m_clause = dIndependentAgnosticClause()
    @State private var m_englishClause = dIndependentAgnosticClause()
    @State var m_randomSentence : RandomSentence!
    @State private var isSubject = false
    @ObservedObject var clauseModel = ClauseModel()
    @State var hasClause = false
    let defaultBackgroundColor = Color.yellow
    let highlightBackgroundColor = Color.black
    @ObservedObject var languageSelection = LanguageSelection(language: .Spanish)
    
    var s1 = 0
    var s2 = 0
    var  textSizeTotal = 0
    
    
    var body: some View {
        LanguageSelectorView(currentLanguage: currentLanguage, languageSelection: languageSelection, newLanguageSelected: {self.newLanguageSelected()})
        
        VStack{
            Text("Random sentence:")
            
            VStack {
                if ( hasClause ){
                    SentenceView(language: currentLanguage, changeWord: {self.changeWord()}, clauseModel: clauseModel)
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
                singleIndexList = Array(repeating: Array(repeating: 0, count: 10), count: 5)
                singleIndexList[1][0] = 1
                singleIndexList[2][0] = 2
                currentLanguage = .Spanish
                //cfModelView.createNewModel(language: currentLanguage)
                m_randomSentence = cfModelView.getRandomSentenceObject()
                createRandomClause()
                hasClause.toggle()
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
        .border(Color.green)
        //.background(Color(UIColor(named: "SurgeryBackground")!))
        .padding(50)
        Spacer()
        
    }
    
    func newLanguageSelected(){
        currentLanguage = languageSelection.selectedLanguage
        cfModelView.createNewModel(language: currentLanguage)
        sentenceString = ""
        createRandomClause()
        m_randomSentence = cfModelView.getRandomSentenceObject()
    }
    
    func changeWord(){
        let single = singleList[currentSingleIndex]
        let clauseManipulation = clauseManipulation(m_clause: m_clause, m_englishClause: m_englishClause)
        m_clause.setTense(value: currentTense)
        m_clause.setPerson(value: currentPerson)
        clauseManipulation.changeWordInClause(cfModelView: cfModelView, clause: m_clause, single: single, isSubject: isSubject)
        clauseManipulation.handleFrenchContractions(singleList: m_clause.getSingleList())
        currentPerson = m_clause.getPerson()
        currentTense = m_clause.getTense()
        updateCurrentSentenceViewStuff()
    }
    
    func createRandomClause(){
        let clauseManipulation = clauseManipulation(m_clause: m_clause, m_englishClause: m_englishClause)
        let result = clauseManipulation.createRandomClause(cfModelView: cfModelView, tense: currentTense, randomPhraseType: .simpleClause)
        
        if currentLanguage == .English { m_clause = result.1 }
        else { m_clause = result.0 }
        
        currentPerson = m_clause.getPerson()
        _  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
        clauseManipulation.handleFrenchContractions(singleList: m_clause.getSingleList())
        updateCurrentSentenceViewStuff()
    }
    
    func updateCurrentSentenceViewStuff(){
        var letterCount = 0
        var singleCount = 0
        backgroundColor.removeAll()
        singleList.removeAll()
        singleList = m_clause.getSingleList()
        currentSingleIndex = clauseModel.currentSingleIndex
        
        for single in singleList {
            letterCount += single.getProcessWordInWordStateData(language: currentLanguage).count + 1
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
        clauseModel.englishSingleList = singleList
        clauseModel.singleIndexList = singleIndexList
        clauseModel.newWordSelected = newWordSelected
        clauseModel.backgroundColor = backgroundColor
    }

    func generateRandomTense(){
        currentTense = cfModelView.getNextTense()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
}

struct SentenceGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        PhraseInSingleLanguageView()
    }
}
