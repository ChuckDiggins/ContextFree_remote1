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
                NavigationLink(destination: MultiVerbConjugation()){
                    Text("Multi Verbs")
                }.frame(width: 200, height: 50)
                .foregroundColor(.black)
                .padding(.leading, 10)
                .background(Color(UIColor(named: "Color1")!))
                .cornerRadius(25)
                
                NavigationLink(destination: FilledPhraseView()){
                    Text("Construct filled phrases")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.orange)
                .cornerRadius(10)
                
                NavigationLink(destination: PersonalPronounGames(colors: [Color.red, Color.blue, Color.green, Color.yellow])){
                    Text("Personal Pronouns Play")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.purple)
                .cornerRadius(10)
                
                NavigationLink(destination: ContextFreeLessonView()){
                    Text("Context free lessons")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                NavigationLink(destination: NewPhrasesIn3LanguagesView()){
                    Text("Phrases in 3 Languages")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(10)
                
                NavigationLink(destination: PhraseInSingleLanguageView()){
                    Text("Phrases in 1 Language")
                }.frame(width: 200, height: 50)
                .padding(.leading, 10)
                .background(Color.yellow)
                .cornerRadius(10)
            }
        }
        
    }
    
    func processSentence(){
        let words = VerbUtilities().getListOfWords(characterArray: sentence)
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
