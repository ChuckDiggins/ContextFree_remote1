//
//  ContentView.swift
//  ContextFree
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sentence: String = ""
    
    var body: some View {
        NavigationView {

            List {
                
                NavigationLink(destination: SentenceParserView()){
                    Text("Sentence Parser")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.orange)
                .cornerRadius(10)
                
                NavigationLink(destination: ContextFreeGrammarSpecificationView()){
                    Text("CF Grammar Specification")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.blue)
                .cornerRadius(10)
                
                NavigationLink(destination: RandomSentenceGeneratorView()){
                    Text("Generate Random Sentences")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.yellow)
                .cornerRadius(10)
            }
        }
        
    }
    
    func processSentence(){
        let words = Utilities().getListOfWords(characterArray: sentence)
        for word in words {
            print ("\(word)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
