//
//  BuildNamedPhraseView.swift
//  BuildNamedPhraseView
//
//  Created by Charles Diggins on 1/20/22.
//

import SwiftUI
import JumpLinguaHelpers


struct BuildNamedPhraseView: View {
    @EnvironmentObject var cfModelView : CFModelView
    var clusterType : ContextFreeSymbol
    @State var phraseName = ""
    @State var cfStringList = [String]()
    @State var wordType = WordType.ambiguous
    @State var testPhrase = ""
    @State private var m_randomWordLists : RandomWordLists?
    @State var m_phrase = dCluster()
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
                    m_phrase.appendCluster(cluster: dDeterminerSingle())
                    cfStringList.append("Determiner")
                })
                
                Button("Add noun", action: {
                    m_phrase.appendCluster(cluster: dNounSingle())
                    cfStringList.append("Noun")
                })
                
                Button("Add adjective", action: {
                    m_phrase.appendCluster(cluster: dAdjectiveSingle())
                    cfStringList.append("Adjective")
                })
   
                Button("Add conjunction" , action: {
                    m_phrase.appendCluster(cluster: dConjunctionSingle())
                    cfStringList.append("Conjunction")
                })
                
                Button("Add existing phrase" , action: {
                    m_phrase.appendCluster(cluster: dNounPhrase())
                    cfStringList.append("Noun phrase")
                })
                
                VStack{
                    HStack{
                        Button("Create test phrase:" , action: {
                            if wordViewModel.hasPhrase(){
                                let phrase = wordViewModel.getPhrase()
                                phrase.createNewRandomPhrase()
                                phrase.processInfo()
                                testPhrase = phrase.getStringAtLanguage(language: .Spanish)
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
                                    wordViewModel.setPhrase(phrase: m_phrase)
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
                wordViewModel.setPhrase(phrase: m_phrase)
                let phrase = m_phrase as! dPhrase
                phrase.setRandomWordList(randomWordList: cfModelView.getRandomWordList())
               
            }
            .foregroundColor(.black).frame(maxWidth: .infinity)
        }
        
//        mutating func createButtonList(clusterType: )
    }
    
    struct ClusterTypeButton : View {
        var clusterType : ContextFreeSymbol
        var cluster : dCluster
        @State var buttonLabel = "Add ambiguous"
        @State var clusterString = "ambiguous"
        
        var body : some View {
            Button(buttonLabel,
                   action: {
                cluster.appendCluster(cluster: dDeterminerSingle())
                clusterString = ""
            })
                .onAppear{
                    clusterString = clusterType.rawValue
                    buttonLabel = "Add " + clusterString
                }
        }
    }
    
    mutating func createCorrectPhraseForGivenType(clusterType: ContextFreeSymbol) {
        switch clusterType {
        case .N: m_phrase = dNounSingle()
        case .V: m_phrase = dVerbSingle()
        case .Adj: m_phrase = dAdjectiveSingle()
        case .Det: m_phrase = dDeterminerSingle()
        case .Adv: m_phrase = dAdverbSingle()
        case .P: m_phrase = dPrepositionSingle()
        case .C: m_phrase = dConjunctionSingle()
            
        case .NP: m_phrase = dNounPhrase()
        case .VP: m_phrase = dVerbPhrase()
        case .AdvP: m_phrase = dAdverbPhrase()
        case .PP: m_phrase = dPrepositionPhrase()
        case .AP: m_phrase = dAdjectivePhrase()
        default: break
        }
    }
}


struct BuildNamedPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        BuildNamedPhraseView(clusterType: ContextFreeSymbol.UNK)
    }
}
