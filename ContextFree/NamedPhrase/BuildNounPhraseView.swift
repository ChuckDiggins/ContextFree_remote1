//
//  BuildNounPhraseView.swift
//  BuildNounPhraseView
//
//  Created by Charles Diggins on 1/19/22.
//

import SwiftUI

struct BuildNounPhraseView : View {
    @EnvironmentObject var cfModelView : CFModelView
    @State var phraseName = ""
    @State var cfStringList = [String]()
    @State var wordType = WordType.ambiguous
    @State var testPhrase = ""
    @State private var m_randomWordLists : RandomWordLists?
    @State var namedPhrase = NamedPhrase()
//    @State var clusterCount = 0
    @State var activeCluster = dCluster()
    @State var associatedWordCount = 0
    var verbUtilities = VerbUtilities()
    @State var str = String()
    @State var showSheet = false
    @ObservedObject var wordViewModel = WordViewModel()
    
    @State private var isPresented = true
    @State private var newPhraseName = ""
    @State private var addButtonsEnabled = false
    
//    @State var wordViewModel = WordViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        ZStack{
            Color.green.ignoresSafeArea(.all)
                .navigationTitle("Romance Noun Phrase Builder")
            
            VStack{
//                HStack {
//                    Text("Phrase name:")
//                    TextField("Phrase name ", text: $phraseName)
//                        .padding()
//                        .background(Color.gray.opacity(0.3).cornerRadius(10))
//                        .foregroundColor(.red)
//                        .font(.headline)
//
//                }.padding(5)

                Button("Add determiner",
                       action: {
                    namedPhrase.appendCluster(cfs: .Det)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                    cfStringList.append("Determiner")
                })
                
                Button("Add noun", action: {
                    namedPhrase.appendCluster(cfs: .N)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                    cfStringList.append("Noun")
                })
                
                Button("Add adjective", action: {
                    namedPhrase.appendCluster(cfs: .Adj)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                    cfStringList.append("Adjective")
                })
                
                Button("Add conjunction" , action: {
                    namedPhrase.appendCluster(cfs: .C)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                    cfStringList.append("Conjunction")
                })
                
                Button("Add existing phrase" , action: {
                    namedPhrase.appendCluster(cfs: .NP)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                    cfStringList.append("Noun phrase")
                })
                
                VStack{
                    HStack{
                        Button("Create test phrase:" , action: {
                            namedPhrase = wordViewModel.getNamedPhrase()
                            namedPhrase.createNewRandomPhrase()
                            namedPhrase.processPhraseInfo()
                            testPhrase = namedPhrase.getPhrase().getStringAtLanguage(language: .Spanish)
                            dumpNamedPhrase(namedPhrase: namedPhrase)  //
                        }).background(Color.yellow)
                        Text(testPhrase)
                            .background(Color.blue)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                NavigationLink(destination: LoadWordsIntoPhraseView(wordViewModel: wordViewModel))
                {
                Image(systemName: "person.circle").foregroundColor(.blue)
                Text("Load words into phrase singles")
                Image(systemName: "play.rectangle.fill").foregroundColor(.green)
                }
                .frame(width: 300, height: 30, alignment: .center)
                .background(Color.red)
                .foregroundColor(.white)
                .border(Color.red)
                Spacer()
                List {
                    Section(
                        header:
                            HStack{
                                Text("Singles list for this phrase")
                                Image(systemName: "flame.fill")
                            }.font(.headline)
                            .foregroundColor(.orange)
                    ){
                        ForEach( 0..<cfStringList.count, id:\.self) { index in
                            HStack{
                                Button("\(cfStringList[index])"){
                                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                                }
                                Spacer()
                                Text("Word count = \(wordViewModel.getAssociatedWords(index: index).count)")
                            }
                        }
//                        .onDelete(perform: delete)
//                        .onMove(perform: move)

                    }
                }
                .listRowBackground(Color.yellow)
                .foregroundColor(.white)
                    .font(.caption2)
            } .onAppear{
                m_randomWordLists = cfModelView.getRandomWordList()
                namedPhrase = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's first article-noun phrase", phraseType: .NP)
            }
            .foregroundColor(.black).frame(maxWidth: .infinity)
        }
    }
}



struct BuildNounPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        BuildNounPhraseView()
    }
}
