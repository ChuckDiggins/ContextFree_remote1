//
//  FilledPhraseView.swift
//  FilledPhraseView
//
//  Created by Charles Diggins on 1/9/22.
//

import SwiftUI

struct FilledPhraseView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    
    
    @State  var phrases = ["Placeholder 1",
                          "Placeholder 2"]
    
    var body: some View {
//        NavigationView{
            VStack{
                NavigationLink("Build noun single", destination: BuildSingletonPhraseView())
                NavigationLink("Build noun phrase", destination: BuildNounPhraseView())
                NavigationLink("Build verb phrase", destination: BuildNounPhraseView())
                NavigationLink("Build preposition phrase", destination: BuildNounPhraseView())
                NavigationLink("Build adjective phrase", destination: BuildNounPhraseView())
                NavigationLink("Build simple clause", destination: BuildNounPhraseView())
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

func dumpNamedPhrase(namedPhrase: NamedPhrase){
    print("\n dumpNamedPhrase")
    for c in namedPhrase.getClusterList() {
        print("clusterType: \(c.getClusterType().rawValue) clusterWord: \(c.getClusterWord().spanish).. associatedWordCount = \(c.getAssociatedWordListCount())")
    }
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


