//
//  BuildNounPhraseView.swift
//  BuildNounPhraseView
//
//  Created by Charles Diggins on 1/19/22.
//

import SwiftUI
import JumpLinguaHelpers

struct BuildNounPhraseView : View {
    @EnvironmentObject var cfModelView : CFModelView
    @State var phraseName = ""
    @State var cfStringList = [String]()
    @State var wordType = WordType.ambiguous
    @State var testPhrase = ""
    @State private var m_randomWordLists : RandomWordLists?
    @State var regularPhrase = dNounPhrase()
    @State var associatedWordCount = 0
    var verbUtilities = VerbUtilities()
    @State var str = String()
    @State var showSheet = false
    @ObservedObject var wordViewModel = RegularWordViewModel()
    
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
                    regularPhrase.appendCluster(cluster: dDeterminerSingle())
                    cfStringList.append("Determiner")
                })
                
                Button("Add noun", action: {
                    regularPhrase.appendCluster(cluster: dNounSingle())
                    cfStringList.append("Noun")
                })
                
                Button("Add adjective", action: {
                    regularPhrase.appendCluster(cluster: dAdjectiveSingle())
                    cfStringList.append("Adjective")
                })
   
                Button("Add conjunction" , action: {
                    regularPhrase.appendCluster(cluster: dConjunctionSingle())
                    cfStringList.append("Conjunction")
                })
                
                Button("Add existing phrase" , action: {
                    regularPhrase.appendCluster(cluster: dNounPhrase())
                    cfStringList.append("Noun phrase")
                })
                
                VStack{
                    HStack{
                        Button("Create test phrase:" , action: {
                            if wordViewModel.hasPhrase(){
                            regularPhrase = wordViewModel.getPhrase() as! dNounPhrase
                            regularPhrase.createNewRandomPhrase()
                            regularPhrase.processInfo()
                            testPhrase = regularPhrase.getStringAtLanguage(language: .Spanish)
                            //regularPhrase.dumpClusterInfo(str: "Build noun phrase view: CreateTestPhrase")
                            }
                        }).background(Color.yellow)
                        Text(testPhrase)
                            .background(Color.blue)
                            .foregroundColor(.white)
                    }
                    
                    
                }
                Spacer()
                NavigationLink(destination: LoadWordsIntoRegularPhraseView(wordViewModel: wordViewModel))
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
                                    wordViewModel.setPhrase(phrase: regularPhrase)
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
                wordViewModel.setPhrase(phrase: regularPhrase)
                regularPhrase.setRandomWordList(randomWordList: cfModelView.getRandomWordList())
               
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
