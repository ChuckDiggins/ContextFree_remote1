////
////  AgnosticSentenceView.swift
////  ContextFree
////
////  Created by Charles Diggins on 6/25/21.
////
//
//import SwiftUI
//
//struct PhrasesIn3LanguagesView: View {
//    @EnvironmentObject var cfModelView : CFModelView
//    //@State private var currentLanguageString = ""
//    @State private var currentTense = Tense.preterite
//    @State private var currentPerson = Person.S3
//    @State private var sentenceString: String = ""
//    @State private var singleList = [dSingle]()
//    @State private var englishSingleList = [dSingle]()
//    @State private var singleIndexList1 = [Int]()
//    @State private var singleIndexList2 = [Int]()
//    @State private var currentSingleIndex = 0
//    @State private var m_clause = dIndependentAgnosticClause()
//    @State private var m_englishClause = dIndependentAgnosticClause()
//    @State private var newWordSelected = false
//    @State private var newWordSelected1 = [Bool]()
//    @State private var isSubject = false
//    
//    @State var m_randomSentence : RandomSentence!
//    
//    var phraseType = ["Subject pronoun / Verb",
//                      "Simple noun phrase",
//                      "Complex preposition phrase",
//                      "Verb-adverb phrase",
//                      "Simple clause"
//    ]
//    @State private var selectedPhraseIndex = 4
//    @State var m_randomPhraseType = RandomPhraseType.subjectPronounVerb
//    
//    var body: some View {
//        GeometryReader{ geometry in
//            VStack{
//                VStack{
//                    Picker("Phrase type picker:", selection: $selectedPhraseIndex, content: {
//                        Text(phraseType[0]).tag(0).font(.subheadline)
//                        Text(phraseType[1]).tag(1).font(.subheadline)
//                        Text(phraseType[2]).tag(2).font(.subheadline)
//                        Text(phraseType[3]).tag(3).font(.subheadline)
//                        Text(phraseType[4]).tag(4).font(.subheadline)
//                    }
//                    )
//                    //processPhraseSelection()
//                    Text("Selected phrase: \(phraseType[selectedPhraseIndex])").font(.subheadline)
//                }
//                .labelsHidden()
//                .font(.subheadline)
//                .padding(10)
//                Text("Random sentence:")
//                VStack {
//                    //part 1
//                    HStack{
//                        ForEach(singleIndexList1, id: \.self){index in
//                            Button(action: {
//                                currentSingleIndex = index
//                                newWordSelected1[currentSingleIndex].toggle()
//                                changeWord()
//                                //                            newWordSelected1[currentSingleIndex] ? wordSurgery(single: singleList[index]) : changeWord()
//                            }){
//                                VStack{
//                                    Text(singleList[index].getProcessWordInWordStateData(language: .Spanish))
//                                        .font(.subheadline)
//                                        .foregroundColor(index == currentSingleIndex ? .red : .black)
//                                    Text(singleList[index].getProcessWordInWordStateData(language: .French))
//                                        .font(.subheadline)
//                                        .foregroundColor(index == currentSingleIndex ? .red : .black)
//                                    Text(englishSingleList[index].getProcessWordInWordStateData(language: .English))
//                                        .font(.subheadline)
//                                        .foregroundColor(index == currentSingleIndex ? .red : .black)
//                                }
//                            }
//                        }
//                        
//                    }
//                    .padding(10)
//                    //part2
//                    HStack{
//                        ForEach(singleIndexList2, id: \.self){index in
//                            Button(action: {
//                                currentSingleIndex = index
//                                newWordSelected1[currentSingleIndex].toggle()
//                                changeWord()
//                                //                            newWordSelected1[currentSingleIndex] ? wordSurgery(single: singleList[index]) : changeWord()
//                            }){
//                                VStack{
//                                    Text(singleList[index].getProcessWordInWordStateData(language: .Spanish))
//                                        .font(.subheadline)
//                                        .foregroundColor(index == currentSingleIndex ? .red : .black)
//                                    Text(singleList[index].getProcessWordInWordStateData(language: .French))
//                                        .font(.subheadline)
//                                        .foregroundColor(index == currentSingleIndex ? .red : .black)
//                                    Text(englishSingleList[index].getProcessWordInWordStateData(language: .English))
//                                        .font(.subheadline)
//                                        .foregroundColor(index == currentSingleIndex ? .red : .black)
//                                }
//                            }
//                        }
//                    }
//                    
//                }.border(Color.green)
//                    .background(Color.white)
//                    .padding(10)
//                VStack{
//                    HStack(alignment: .center){
//                        Spacer()
//                        Button(action: {createRandomClause( )}) {
//                            Text("Random sentence")
//                                .padding(10)
//                                .background(Color.green)
//                                .foregroundColor(Color.yellow)
//                                .cornerRadius(25)
//                        }
//                        Spacer()
//                    }
//                    
//                   
//                }
//                .padding()
//                .onAppear{
//                    cfModelView.createNewModel(language: .Agnostic)
//                    createRandomClause()
//                    m_randomSentence = cfModelView.getRandomSentenceObject()
//                }
//                
//                
//                VStack(alignment: .center){
//                    Button(action: {
//                        generateRandomTense()
//                    }){
//                        HStack {
//                            Text("Tense: \(currentTense.rawValue)").background(Color.yellow).foregroundColor(.black).frame(width: 250, height: 80)
//                                .cornerRadius(10).padding(25)
//                            
//                        }
//                    }
//                    
//                    
//                }
//                Spacer()
//            }
//            .padding()
//        }//geometryReader
//    }
//    
//   
//
//    func changeWord(){
//        let single = singleList[currentSingleIndex]
//        let clauseManipulation = clauseManipulation()
//        m_clause.setTense(value: currentTense)
//        m_clause.setPerson(value: currentPerson)
//        clauseManipulation.changeWordInClause(cfModelView: cfModelView, clause: m_clause, single: single, isSubject: isSubject)
//        clauseManipulation.handleFrenchContractions(singleList: m_clause.getSingleList())
//        currentPerson = m_clause.getPerson()
//        currentTense = m_clause.getTense()
//        updateCurrentSentenceViewStuff()
//        //wordSurgery(single: singleList[currentSingleIndex])
//    }
//    
//    func processPhraseSelection(){
//        isSubject = false
//        switch selectedPhraseIndex{
//        case 0:
//            m_randomPhraseType = RandomPhraseType.subjectPronounVerb
//            isSubject = true
//        case 1: m_randomPhraseType = RandomPhraseType.simpleNounPhrase
//        case 2: m_randomPhraseType = RandomPhraseType.simplePrepositionPhrase
//        case 3: m_randomPhraseType = RandomPhraseType.simpleVerbAdverbPhrase
//        case 4: m_randomPhraseType = RandomPhraseType.simpleClause
//        default:
//            m_randomPhraseType = RandomPhraseType.simpleClause
//        }
//    }
//    
//    func createRandomClause(){
//        let tense = currentTense
//        while tense == currentTense {
//            currentTense = cfModelView.getRandomTense()
//        }
//        processPhraseSelection()
//        let clauseManipulation = clauseManipulation()
//        let result = clauseManipulation.createRandomClause(cfModelView: cfModelView, tense: currentTense, randomPhraseType: m_randomPhraseType)
//        m_clause = result.0
//        m_englishClause = result.1
//        
//        currentPerson = m_clause.getPerson()
//        let fs  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
//        print("French phrase: \(fs)")
//        let ss  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
//        print("Spanish phrase: \(ss)")
//        let es  = m_englishClause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
//        print("English phrase: \(es)")
//        
//        clauseManipulation.handleFrenchContractions(singleList: m_clause.getSingleList())
//        updateCurrentSentenceViewStuff()
//        //clearWordSurgery()
////        clauseManipulation.countStringLengths(clause: m_clause, englishClause: m_englishClause)
//    }
//    
//    
//    func updateCurrentSentenceViewStuff(){
//        // clearWordSurgery()
//        var letterCount = 0
//        var singleCount = 0
//        singleList.removeAll()
//        singleList = m_clause.getSingleList()
//        englishSingleList = m_englishClause.getSingleList()
//        
//        for single in singleList {
//            letterCount += single.getProcessWordInWordStateData(language: .Spanish).count + 1
//            singleCount += 1
//            if letterCount > 30 {break}
//        }
//        
//        singleIndexList1.removeAll()
//        singleIndexList2.removeAll()
//        newWordSelected1.removeAll()
//        
//        for i in 0 ..< singleCount {
//            singleIndexList1.append(i)
//            newWordSelected1.append(false)
//        }
//        for i in singleCount ..< singleList.count {
//            singleIndexList2.append(i)
//            newWordSelected1.append(false)
//        }
//    }
//
//    
//    func generateRandomTense(){
//        let tense = currentTense
//        while tense == currentTense {
//            currentTense = cfModelView.getRandomTense()
//        }
//        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
//        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
//        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
//        updateCurrentSentenceViewStuff()
//        //wordSurgery(single: singleList[currentSingleIndex])
//    }
//    
//    
//    
//}
//
//struct AgnosticSentenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhrasesIn3LanguagesView()
//    }
//}
