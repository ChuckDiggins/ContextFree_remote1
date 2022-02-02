//
//  FilledPhraseView.swift
//  FilledPhraseView
//
//  Created by Charles Diggins on 1/9/22.
//

import SwiftUI
import JumpLinguaHelpers

struct FilledPhraseView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    
    
    @State  var phrases = ["Placeholder 1",
                          "Placeholder 2"]
    
    var body: some View {
//        NavigationView{
            VStack{
                NavigationLink("Build regular noun phrase", destination: BuildNounPhraseView())
//                NavigationLink("Build named noun phrase", destination: BuildNounPhraseScreen())
                NavigationLink("Build verb phrase", destination: BuildVerbPhraseScreen())
                NavigationLink("Build preposition phrase", destination: BuildPrepositionPhraseScreen())
                NavigationLink("Build adjective phrase", destination: BuildAdjectivePhraseScreen())
                NavigationLink("Build simple clause", destination: BuildSimpleClauseScreen())
            VStack{
                List {
                    Section(
                        header:
                            HStack{
                                Text("Filled phrases")
                                Image(systemName: "flame.fill")
                            }.font(.headline)
                            .foregroundColor(.orange)
                    ){
                        ForEach(phrases, id:\.self) { phrase in
                            Text(phrase.capitalized)
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                        .listRowBackground(Color.yellow)
                    }
                }.foregroundColor(.black)
                    .font(.caption2)

            }
            }
            .onAppear {
                cfModelView.createNewModel(language: .Agnostic)
                currentLanguage = .Spanish
            }
  
    }
    func delete(indexSet: IndexSet){
    //    fruits.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet,  newOffset: Int){
    //    fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    
}

struct FilledPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        FilledPhraseView()
    }
}


//struct BuildNounPhraseScreen : View {
//    @EnvironmentObject var cfModelView : CFModelView
//    @State var phraseName = ""
//    @State var cfStringList = [String]()
//    @State var wordType = WordType.ambiguous
//    @State var testPhrase = ""
//    @State private var m_randomWordLists : RandomWordLists?
//    @State var namedPhrase = NamedPhrase()
////    @State var clusterCount = 0
//    @State var activeCluster = dCluster()
//    @State var associatedWordCount = 0
//    var verbUtilities = VerbUtilities()
//    @State var str = String()
//    @State var showSheet = false
//    @ObservedObject var wordViewModel = WordViewModel()
//
//    @State private var isPresented = true
//    @State private var newPhraseName = ""
//    @State private var addButtonsEnabled = false
//
////    @State var wordViewModel = WordViewModel()
//
//    @Environment(\.presentationMode) var presentationMode
//    var body : some View {
//        ZStack{
//            Color.green.ignoresSafeArea(.all)
//                .navigationTitle("Romance Noun Phrase Builder")
//
//            VStack{
////                HStack {
////                    Text("Phrase name:")
////                    TextField("Phrase name ", text: $phraseName)
////                        .padding()
////                        .background(Color.gray.opacity(0.3).cornerRadius(10))
////                        .foregroundColor(.red)
////                        .font(.headline)
////
////                }.padding(5)
//
//                Button("Add determiner",
//                       action: {
//                    namedPhrase.appendCluster(cfs: .Det)
//                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
//                    cfStringList.append("Determiner")
//                })
////                    .disabled(addButtonsEnabled ? phraseName.count > 3 : phraseName.count < 3)
//
//                Button("Add noun", action: {
//                    namedPhrase.appendCluster(cfs: .N)
//                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
//                    cfStringList.append("Noun")
//                })
////                    .disabled(addButtonsEnabled ? phraseName.count > 3 : phraseName.count < 3)
//
//                Button("Add adjective", action: {
//                    namedPhrase.appendCluster(cfs: .Adj)
//                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
//                    cfStringList.append("Adjective")
//                })
//
//
//                Button("Add conjunction" , action: {
//                    namedPhrase.appendCluster(cfs: .C)
//                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
//                    cfStringList.append("Conjunction")
//                })
//
//                Button("Add existing phrase" , action: {
//                    namedPhrase.appendCluster(cfs: .NP)
//                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
//                    cfStringList.append("Noun phrase")
//                })
//
//                VStack{
//                    HStack{
//                        Button("Create test phrase:" , action: {
//                            namedPhrase = wordViewModel.getNamedPhrase()
//                            namedPhrase.createNewRandomPhrase()
//                            namedPhrase.processPhraseInfo()
//                            testPhrase = namedPhrase.getPhrase().getStringAtLanguage(language: .Spanish)
//                            dumpNamedPhrase(namedPhrase: namedPhrase)  //
//                        }).background(Color.yellow)
//                        Text(testPhrase)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                    }
//
//
//                }
//                Spacer()
//                NavigationLink(destination: LoadWordsIntoPhraseView(wordViewModel: wordViewModel))
//                {
//                Image(systemName: "person.circle").foregroundColor(.blue)
//                Text("Load words into phrase singles")
//                Image(systemName: "play.rectangle.fill").foregroundColor(.green)
//                }
//                .frame(width: 300, height: 30, alignment: .center)
//                .background(Color.red)
//                .foregroundColor(.white)
//                .border(Color.red)
//                Spacer()
//                List {
//                    Section(
//                        header:
//                            HStack{
//                                Text("Singles list for this phrase")
//                                Image(systemName: "flame.fill")
//                            }.font(.headline)
//                            .foregroundColor(.orange)
//                    ){
//                        ForEach( 0..<cfStringList.count, id:\.self) { index in
//                            HStack{
//                                Button("\(cfStringList[index])"){
//                                    wordViewModel.setNamedPhrase(namedPhrase: namedPhrase)
//                                }
//                                Spacer()
//                                Text("Word count = \(wordViewModel.getAssociatedWords(index: index).count)")
//                            }
//                        }
////                        .onDelete(perform: delete)
////                        .onMove(perform: move)
//
//                    }
//                }
//                .listRowBackground(Color.yellow)
//                .foregroundColor(.white)
//                    .font(.caption2)
//            } .onAppear{
//                m_randomWordLists = cfModelView.getRandomWordList()
//                namedPhrase = NamedPhrase(randomWord: m_randomWordLists!, phraseName: "Chuck's first article-noun phrase", phraseType: .NP)
//            }
//            .foregroundColor(.black).frame(maxWidth: .infinity)
//        }
//    }
//}
//

func alertView()->String {
    var phraseName = ""
    
    let alert = UIAlertController(title: "Phrase name:", message: "Enter name here", preferredStyle: .alert)
    alert.addTextField{ (pass) in
        pass.isSecureTextEntry = false
        pass.placeholder = "Phrase name"
    }
    
    let answerButton = UIAlertAction(title: "OK", style: .default){ (_) in
        // do something here
        phraseName = alert.textFields![0].text!
    }
    
    let cancelButton = UIAlertAction(title: "Cancel", style: .destructive){ (_) in
        //same
    }
    
    alert.addAction(cancelButton)
    alert.addAction(answerButton)
    
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
        //do something here
    })
    
    return phraseName
}


struct LoadWordsIntoPhrasesView : View {
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        Text("Hello")
    }
}


struct BuildVerbPhraseScreen : View {
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        ZStack{
            Color.purple.ignoresSafeArea(.all)
                .navigationTitle("Verb Phrase")
            VStack{
                Button("Back Button") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                Spacer()
                NavigationLink("Click here", destination: Text("3rd screen"))
            }
        }
    }
}

struct BuildPrepositionPhraseScreen : View {
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        ZStack{
            Color.red.ignoresSafeArea(.all)
                .navigationTitle("Preposition Phrase")
            VStack{
                Button("Add article"){
                    
                }
                Button("Add noun"){
                    
                }
                Button("Add adjective"){
                    
                }
                
                Button("Back Button") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                Spacer()
                NavigationLink("Click here", destination: Text("3rd screen"))
            }
        }
    }
}

struct BuildAdjectivePhraseScreen : View {
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        ZStack{
            Color.red.ignoresSafeArea(.all)
                .navigationTitle("Adjective Phrase")
            VStack{
                Button("Back Button") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                Spacer()
                NavigationLink("Click here", destination: Text("3rd screen"))
            }
        }
    }
}

struct BuildSimpleClauseScreen : View {
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        ZStack{
            Color.red.ignoresSafeArea(.all)
                .navigationTitle("Simple Clause")
            VStack{
                Button("Back Button") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                Spacer()
                NavigationLink("Click here", destination: Text("3rd screen"))
            }
        }
    }
}


