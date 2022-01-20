//
//  BuildSingletonPhraseView.swift
//  BuildSingletonPhraseView
//
//  Created by Charles Diggins on 1/19/22.
//

import SwiftUI

struct BuildSingletonPhraseView : View {
    @EnvironmentObject var cfModelView : CFModelView
    @State var phraseName = ""
    @State var cfStringList = [String]()
    @State var wordType = WordType.ambiguous
    @State var testPhrase = ""
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
    @State private var clusterType = ContextFreeSymbol.AMB
    
    
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        ZStack{
            Color.green.ignoresSafeArea(.all)
                .navigationTitle("Romance Singleton Builder")
            
            VStack{
                HStack {
                    Text("Singleton name:")
                    TextField("Phrase name ", text: $phraseName)
                        .padding()
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(.red)
                        .font(.headline)

                }.padding(5)

                Button("Create determiner singleton",
                       action: {
                    namedPhrase = NamedPhrase(phraseType: .Det)
                    namedPhrase.appendNonRandomCluster(cfs: .Det)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                })
                
                Button("Create noun singleton", action: {
                    namedPhrase = NamedPhrase(phraseType: .N)
                    namedPhrase.appendNonRandomCluster(cfs: .N)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                })
                
                Button("Create adjective singleton", action: {
                    namedPhrase = NamedPhrase(phraseType: .Adj)
                    namedPhrase.appendNonRandomCluster(cfs: .Adj)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                })
                
                
                Button("Create verb singleton" , action: {
                    namedPhrase = NamedPhrase(phraseType: .V)
                    namedPhrase.appendNonRandomCluster(cfs: .V)
                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
                    
                })
                Spacer()
                VStack{
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
                }
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
                        ForEach( 0..<namedPhrase.getAssociatedWordsForCluster(index: 0).count, id:\.self) { index in
                            Button(namedPhrase.getAssociatedWordsForCluster(index: 0)[index].word, action: {
                                })
                        }
//                        .onDelete(perform: delete)
//                        .onMove(perform: move)

                    }
                }
                .listRowBackground(Color.yellow)
                .foregroundColor(.white)
                    .font(.caption2)
            } .onAppear{
                
            }
            .foregroundColor(.black).frame(maxWidth: .infinity)
        }
    }
    
}


struct BuildSingletonPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        BuildSingletonPhraseView()
    }
}
