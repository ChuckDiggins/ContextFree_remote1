////
////  MultiLanguageMultiPhraseView.swift
////  MultiLanguageMultiPhraseView
////
////  Created by Charles Diggins on 1/22/22.
////
//
//import SwiftUI
//
//struct MultiLanguageMultiPhraseView: View {
//    @EnvironmentObject var cfModelView : CFModelView
//    @State var maxDisplayLines = 1
//    @State var singleIndexList = [[Int]]()
//    @State var singleList = [dSingle]()
//    @State var singleStringList = [String]()
//    @State var phraseStringList = [String]()
//    @State var phraseColorList = [Color]()
//    @State var wordTypeList = [String]()
//    @State var newWordSelected = [Bool]()
//    @State var backgroundColor = [Color]()
//    @State var currentSingleIndex = 0
//    @State var phraseIndexMapping = [PhraseIndexMapping]()
//    
//    //@State private var currentLanguageString = ""
//    @State private var currentTense = Tense.preterite
//    @State private var currentPerson = Person.S3
//    @State private var sentenceString: String = ""
//    
//    @State private var englishSingleList = [dSingle]()
//    @State var m_clause : AgnosticClause?
//    @State var m_englishClause : AgnosticClause?
//    
//    @State var defaultBackgroundColor = Color.yellow
//    @State var highlightBackgroundColor = Color.black
//    
//    //@State private var newWordSelected = false
//    
//    @State var m_randomSentence : RandomSentence!
//    @State var hasClause = false
//    @State private var isSubject = false
//    @State var showWorkSheet = false
//    
//    @State var spanishActivated  = true
//    @State var frenchActivated = false
//    @State var englishActivated = true
//    
//    var phraseType = ["Subject pronoun / Verb",
//                      "Simple noun phrase",
//                      "Complex preposition phrase",
//                      "Verb-adverb phrase",
//                      "Simple clause"
//    ]
//    
//    
//    @State private var selectedPhraseIndex = 4
//    @State var m_randomPhraseType = RandomPhraseType.simpleClause
//    @State var clauseModel = ClauseModel()
//    
//    var body: some View {
//        GeometryReader{ geometry in
//            VStack{
//                HStack(){
//                    Toggle(isOn: $spanishActivated){  Text("Spanish")  }
//                    Spacer()
//                    Toggle(isOn: $frenchActivated){  Text("French")  }
//                    Spacer()
//                    Toggle(isOn: $englishActivated){  Text("English")  }
//                }.frame(maxWidth: .infinity)
//                .background(Color.purple.opacity(0.3))
//                .font(.caption)
//                VStack{
//                    Picker("Phrase type picker:", selection: $selectedPhraseIndex, content: {
//                        Text(phraseType[0]).tag(0).font(.subheadline)
//                        Text(phraseType[1]).tag(1).font(.subheadline)
//                        Text(phraseType[2]).tag(2).font(.subheadline)
//                        Text(phraseType[3]).tag(3).font(.subheadline)
//                        Text(phraseType[4]).tag(4).font(.subheadline)
//                    }
//                    )
//                    Text("Selected phrase: \(phraseType[selectedPhraseIndex])").font(.subheadline)
//                }
//                .labelsHidden()
//                .font(.subheadline)
//                .padding(10)
//                Text("Random sentence:")
//                VStack {
//                    if ( hasClause ){
//                        if ( spanishActivated ){
//                            SentenceView(language: .Spanish, changeWord: {self.changeWord()}, clauseModel: clauseModel)}
//                        if ( frenchActivated ){
//                            SentenceView(language: .French, changeWord: {self.changeWord()}, clauseModel: clauseModel)}
//                        if ( englishActivated ){
//                            SentenceView(language: .English, changeWord: {self.changeWord()}, clauseModel: clauseModel)
//                        }
//                    }
//                }.onAppear{
//                    singleIndexList = Array(repeating: Array(repeating: 0, count: 10), count: 5)
//                    singleIndexList[1][0] = 1
//                    singleIndexList[2][0] = 2
//                    cfModelView.createNewModel(language: .Agnostic)
//                    createRandomClause()
//                    m_randomSentence = cfModelView.getRandomSentenceObject()
//                    hasClause.toggle()
//                }
//                .padding(10)
//                .border(Color.green)
//                .background(Color.white)
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
//                }
//                .padding()
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
//                    Button(action: {
//                        showWorkSheet.toggle()
//                    }, label: {
//                        Text("Show worksheet").foregroundColor(.red)
//                            .padding(20)
//                            .background(Color.white.cornerRadius(10))
//                    })
//                        .fullScreenCover(isPresented: $showWorkSheet, content: {
////                            ClauseWorkSheet(m_clause: m_clause!, singleStringList: singleStringList,
////                                            phraseStringList: phraseStringList,
////                                            phraseColorList: phraseColorList,
////                                            wordTypeList:  wordTypeList   )
//                        })
//                }
//            }
//            .padding()
//        }//geometryReader
//    }
//    
//    
//    func changeWord(){
//        let tempSingleList = m_clause!.getSingleList()
//        for single in tempSingleList {
//            print("enter - changeWord: \(single.getClusterWord().word)")
//        }
//        processPhraseSelection()
//        
//        let single = singleList[clauseModel.currentSingleIndex]
//        let clauseManipulation = AgnosticClauseProcesses(m_clause: m_clause!, m_englishClause: m_englishClause!)
//        m_clause!.setTense(value: currentTense)
//        m_clause!.setPerson(value: currentPerson)
//        
//        let clause = clauseManipulation.changeWordInClause(cfModelView: cfModelView, clause: m_clause!, single: single, isSubject: isSubject)
//        clauseManipulation.handleFrenchContractions(singleList: clause.getSingleList())
//        currentPerson = m_clause!.getPerson()
//        currentTense = m_clause!.getTense()
//        m_clause = clause
//        updateCurrentSentenceViewStuff(clause: clause, englishClause: m_englishClause!)
//    }
//    
//    func generateRandomTense(){
//        var tempSingleList = m_clause!.getSingleList()
//        for single in tempSingleList {
//            print("enter - generateRandomTense: \(single.getClusterWord().word)")
//        }
//        currentTense = cfModelView.getNextTense()
//        m_clause!.setTenseAndPerson(tense: currentTense, person: currentPerson)
//        sentenceString = m_clause!.createNewSentenceString(language: .Spanish)
//        sentenceString = m_clause!.createNewSentenceString(language: .French)
//        sentenceString = m_clause!.createNewSentenceString(language: .English)
//        
//        tempSingleList = m_clause!.getSingleList()
//        for single in tempSingleList {
//            print("pt 2 - generateRandomTense: \(single.getClusterWord().word)")
//        }
//        updateCurrentSentenceViewStuff(clause: m_clause!, englishClause: m_englishClause!)
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
//        let clause = result.0
//        let englishClause = result.1
//        
//        m_clause = result.0
//        m_englishClause = result.1
//        
////        let tempSingleList = clause.getSingleList()
////        for single in tempSingleList {
////            print("createRandomClause: \(single.getClusterWord().word)")
////        }
//        updateCurrentSentenceViewStuff(clause: clause, englishClause: englishClause)
//    }
//    
//    
//    func updateCurrentSentenceViewStuff(clause: dIndependentAgnosticClause, englishClause: dIndependentAgnosticClause){
//        
//        var letterCount = 0
//        var singleCount = 0
//        backgroundColor.removeAll()
//        singleList.removeAll()
//        singleList = clause.getSingleList()
//        englishSingleList = englishClause.getSingleList()
//        currentSingleIndex = clauseModel.currentSingleIndex
//        singleStringList = clause.getSingleStringList(language: .Spanish)
//        wordTypeList = clause.getWordTypeList()
//        phraseStringList = clause.getParentPhraseTypeList()
//        
//        //AgnosticPhraseMapping
//        for i in 0..<phraseStringList.count {
//            phraseColorList.append(.green)
//            let pim = PhraseIndexMapping(cfs : singleList[i].getWordType(), agnosticIndex: i, spanishIndex: i, frenchIndex: i, englishIndex: i)
//            phraseIndexMapping.append(pim)
//        }
//    
//        for single in singleList {
//            letterCount += single.getProcessWordInWordStateData(language: .Spanish).count + 1
//            singleCount += 1
//            if letterCount > 30 {break}
//        }
//        
//        //up to three lines
//        
//        for i in 0..<3  { singleIndexList[i].removeAll() }
//        
//        newWordSelected.removeAll()
//        
//        maxDisplayLines = 1
//        for i in 0 ..< singleCount {
//            singleIndexList[0].append(i)
//            newWordSelected.append(false)
//            backgroundColor.append(defaultBackgroundColor)
//        }
//        
//        if singleCount < singleList.count {maxDisplayLines = 2}
//        
//        for i in singleCount ..< singleList.count {
//            singleIndexList[1].append(i)
//            newWordSelected.append(false)
//            backgroundColor.append(defaultBackgroundColor)
//        }
//        
//        let tempSingleList = clause.getSingleList()
//        for single in tempSingleList {
//            print("updateCurrentSentenceViewStuff: \(single.getClusterWord().word)")
//        }
//        
//        clauseModel.set(currentSingleIndex: currentSingleIndex,
//                                  maxLines: maxDisplayLines,
//                                  singleIndexListForEachLine: singleIndexList,
//                                  singleList: singleList, englishSingleList: englishSingleList,
//                                  newWordSelected: newWordSelected,
//                                  backGroundColor: backgroundColor)
//        //backgroundColor[currentSingleIndex] = highlightBackgroundColor
//    }
//    
//    func processSentence2(){
//        m_clause = cfModelView.getAgnosticRandomSubjPronounSentence()
//        sentenceString = m_clause!.createNewSentenceString(language: .Spanish)
//        singleList = m_clause!.getSingleList()
//    }
//    
//    
//    
//    struct ClauseWorkSheet: View {
//        @Environment(\.presentationMode) var presentationMode
//        @State var m_clause : dIndependentAgnosticClause
//        @State var singleStringList : [String]
//        @State var phraseStringList : [String]
//        @State var phraseColorList : [Color]
//        @State var wordTypeList : [String]
//        
//        var colors: [Color] = [.blue, .yellow, .green]
//        var gridItems = [GridItem(.fixed(20.0)),
//                         GridItem(.flexible()),
//                         GridItem(.flexible()),
//                         GridItem(.fixed(30.0))]
//        var languageGridItems = [GridItem(.flexible()),
//                         GridItem(.flexible()),
//                         GridItem(.flexible())]
//        
//        var body: some View {
//            ZStack(alignment: .topLeading){
//                Color.gray
//                    .edgesIgnoringSafeArea(.all)
//                VStack{
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.green)
//                            .font(.largeTitle)
//                            .padding(20)
//                    })
//                    LazyVGrid(columns: languageGridItems, spacing: 5){
//                        WordCell(thisLanguage: .English, wordText: "English", backgroundColor: .gray, foregroundColor: .yellow, fontSize: .system(size: 20),
//                                 function: fillStringLists )
//                        WordCell(thisLanguage: .Spanish, wordText: "Spanish", backgroundColor: .gray, foregroundColor: .yellow, fontSize: .system(size: 20),
//                                 function: fillStringLists)
//                        WordCell(thisLanguage: .French, wordText: "French", backgroundColor: .gray, foregroundColor: .yellow, fontSize: .system(size: 20),
//                                 function: fillStringLists)
//                    }
//                    Text("Agnostic clause items")
//                    //NavigationView {
//                    ScrollView{
//                        LazyVGrid(columns: gridItems, spacing: 5){
//                            ForEach ((0..<singleStringList.count), id: \.self){ index in
//                                WordCellButton(wordText: "\(index)", backgroundColor: .blue, foregroundColor: .black, fontSize: Font.subheadline)
//                                WordCellButton(wordText: singleStringList[index], backgroundColor: .yellow, foregroundColor: .black, fontSize: Font.subheadline)
//                                WordCellButton(wordText: phraseStringList[index], backgroundColor: phraseColorList[index], foregroundColor: .black, fontSize: Font.subheadline)
//                                WordCellButton(wordText: wordTypeList[index], backgroundColor: .green, foregroundColor: .black, fontSize: Font.subheadline)
//                            }
//                        }
//                        //}.navigationBarTitle("Clause items")
//                    }
//                    
//                }
//            }
//        }
//        
//        func fillStringLists(language: LanguageType){
//            singleStringList = m_clause.getSingleStringList(language: language)
//            wordTypeList = m_clause.getWordTypeList()
//            phraseStringList = m_clause.getParentPhraseTypeList()
//            phraseColorList.removeAll()
//            for i in 0 ..< phraseStringList.count {
//                if phraseStringList[i] == "NP" { phraseColorList.append(.green) }
//                else if phraseStringList[i] == "VP" { phraseColorList.append(.blue) }
//                else if phraseStringList[i] == "PP" { phraseColorList.append(.yellow) }
//                else { phraseColorList.append(.yellow) }
//            }
//        }
//        
//        
//        struct DrawingConstants {
//            static let cardSize: CGFloat = 60
//            static let opacity: CGFloat = 0.6
//            static let fontSize: CGFloat = 32.0
//        }
//
//        
//    }
//    
//
//}
//
//
//struct MultiLanguageMultiPhraseView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiLanguageMultiPhraseView()
//    }
//}
