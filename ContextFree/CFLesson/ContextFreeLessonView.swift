//
//  ContextFreeLessonView.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/19/21.
//

import SwiftUI

struct PhraseCategory : Identifiable {
    var id : Int
    var name: String
    var isSelected: Bool = true
}

struct PhraseFilter : Identifiable {
    var id : Int
    var name: String
    var isSelected: Bool = false
}

var phraseCategories: [PhraseCategory] = [PhraseCategory(id: 0, name: "Noun phrases"),
                                          PhraseCategory(id: 1, name: "Prepositional phrases"),
                                          PhraseCategory(id: 2, name: "Verb phrases"),
                                          PhraseCategory(id: 3, name: "Adverb phrases"),
                                          PhraseCategory(id: 4, name: "Adjective phrases")
]

var phraseFilters: [PhraseFilter] = [PhraseFilter(id: 0, name: "Subject"),
                                     PhraseFilter(id: 1, name: "Personal"),
                                     PhraseFilter(id: 2, name: "Impersonal"),
                                     PhraseFilter(id: 2, name: "Object")
]

func getPhraseCategories()->[PhraseCategory]{
    return phraseCategories
}

func getPhraseFilters()->[PhraseFilter]{
    return phraseFilters
}


//struct ContextFreeLessonView: View {
//    @EnvironmentObject var cfModelView : CFModelView
//    @State private var currentLanguage = LanguageType.Spanish
//    @State private var sentenceString = ""
//    
//    @State private var currentTense = Tense.preterite
//    @State private var currentPerson = Person.S3
//    @State private var namedPhraseCount = 0
//    @State private var namedPhraseList = [dPhrase]()
//    @State private var namedClause = dPhrase(phraseName: "Chuck's first clause")
//    @State private var m_clause : dIndependentAgnosticClause?
//    @State private var m_englishClause : dIndependentAgnosticClause?
//    @State private var m_randomWordLists : RandomWordLists?
//    
//    @State private var m_cfLesson : ContextFreeLesson?
//    
//    @State var phraseCategories = [PhraseCategory]()
//    @State var phraseFilters = [PhraseFilter]()
//    @State var categoryIndex = 0
//    
//    
//    var body: some View {
//        //NavigationView {
//        // VStack{
//        HStack{
//            Button(action: {
//                currentLanguage = .Spanish
//            }){
//                Text("Spanish")
//            }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
//                .foregroundColor(currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
//            
//            Button(action: {
//                currentLanguage = .French
//            }){
//                Text("French")
//            }.font(currentLanguage == .French ? .title : .system(size: 20) )
//                .foregroundColor(currentLanguage == .French ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
//            
//            Button(action: {
//                currentLanguage = .English
//            }){
//                Text("English")
//            }.font(currentLanguage == .English ? .title : .system(size: 20) )
//                .foregroundColor(currentLanguage == .English ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
//        }.onAppear{
//            m_randomWordLists = cfModelView.getRandomWordList()
//        }
//        .padding()
//        //                }
//        //
//        //                VStack{
//        Button(action: {
//            createNamedPhrases()
//        }){
//            Text("Create named phrase")
//        }
//        
//        Text("Phrase count : \(namedPhraseCount)")
//        Text("Phrase types:")
//        VStack{
//            Text("\(namedPhraseList.count)")
//            List{
//                ForEach ((0..<namedPhraseList.count), id: \.self){ index in
//                    HStack{
//                        Text("\(namedPhraseList[index].getPhraseName())")
//                        NavigationLink(destination: DetailedPhraseView(namedPhrase: namedPhraseList[index], language: currentLanguage)){
//                        }
//                    }
//                }
//                
//               .buttonStyle(PlainButtonStyle())
//                
//            }.font(.caption)
//            List{
//                ForEach ((0..<phraseCategories.count), id: \.self){ index in
//                    HStack {
//                        Button(action: {
//                            phraseCategories[index].isSelected = phraseCategories[index].isSelected ? false : true
//                            categoryIndex = index
//                            //fillFilteredVerbs(viperViewModel : viperViewModel, verbCategories : verbCategories, verbFilters : verbFilters)
//
//                            print("Category selected = \(index) -- selected \($phraseCategories[index].isSelected)")
//                        }) {
//                            HStack{
//                                if phraseCategories[index].isSelected {
//                                    Image(systemName: "checkmark.circle.fill")
//                                        .foregroundColor(.green)
//                                        .animation(.easeIn)
//                                } else {
//                                    Image(systemName: "circle")
//                                        .foregroundColor(.primary)
//                                        .animation(.easeOut)
//                                }
//                                Text(phraseCategories[index].name)
//                            }
//                        }.buttonStyle(BorderlessButtonStyle())
//                    }
//                }
//            }.font(.caption)
//            
//            
//            .onAppear{
//                cfModelView.createNewModel(language: .Agnostic)
//                m_randomWordLists = cfModelView.getRandomWordList()
//                phraseCategories = getPhraseCategories()
//                phraseFilters = getPhraseFilters()
//                createNamedPhrases()
//            }
//            //.navigationTitle("Context Free Lessons")
//            .font(.title)
//        }
//        Spacer()
//        
//    }
//    
//    func createLesson(){
//        m_cfLesson = ContextFreeLesson(lessonName: "Chuck's first article-noun lesson", wsp: cfModelView.getWordStringParser())
//    }
//    
//    func createNamedPhrases(){
//        var NP1 = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's first article-noun phrase", phraseType: .NP)
//        NP1.appendCluster(cfs: .Det)
//        NP1.appendCluster(cfs: .N, isSubject: true)
//        NP1.processPhraseInfo()
//        
//        var NP2 = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's first article-noun-adjective phrase", phraseType: .NP)
//        NP2.appendCluster(cfs: .Det)
//        NP2.appendCluster(cfs: .N)
//        NP2.appendCluster(cfs: .Adj)
//        NP2.processPhraseInfo()
//        
//        var NP3 = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's second article-noun-adjective phrase", phraseType: .NP)
//        NP3.appendCluster(cfs: .Det)
//        NP3.appendCluster(cfs: .N)
//        NP3.appendCluster(cfs: .Adj)
//        NP3.processPhraseInfo()
//        
//        var PP = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's first prepositional phrase", phraseType: .PP)
//        PP.appendCluster(cfs: .P)
//        PP.appendNamedPhrase(phrase: NP3)
//        PP.processPhraseInfo()
//        
//        var VP = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's first verb phrase", phraseType: .VP)
//        VP.appendCluster(cfs: .V)
//        VP.appendNamedPhrase(phrase: NP2)
//        VP.appendNamedPhrase(phrase: PP)
//        VP.processPhraseInfo()
//        
//        let NP1Copy = NamedPhrase(inputPhrase: NP1, phraseName: "NP1 copy")
//        
//        namedPhraseList.removeAll()
//        namedPhraseList.append(NP1)
//        namedPhraseList.append(NP2)
//        namedPhraseList.append(NP3)
//        namedPhraseList.append(PP)
//        namedPhraseList.append(VP)
//        
//        
//        namedClause.appendNamedPhrase(namedPhrase: NP1)
//        namedClause.appendNamedPhrase(namedPhrase: VP)
//        namedClause.process()
//        print("In ContextFreeLessonView: Language is \(currentLanguage.rawValue)")
//        let clauseString = namedClause.getClause().getReconstructedSentenceString(language: currentLanguage)
//        print("\(namedClause.getName()): \(clauseString)")
//        
//        //namedPhraseList.append(namedClause)
//        
//        for np in namedPhraseList {
//            print("\(np.getPhraseName()): \(np.getPhrase().getStringAtLanguage(language: currentLanguage))")
//        }
//        print("\(NP1Copy.getPhraseName()): \(NP1Copy.getPhrase().getStringAtLanguage(language: currentLanguage))")
//        
//        namedPhraseCount = namedPhraseList.count
//        
//    }
//}
//
//struct ContextFreeLessonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContextFreeLessonView()
//    }
//}
