//
//  RandomSentenceGeneratorView.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct SentenceGameView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    @State private var currentLanguageString = ""
    @State private var currentTense = Tense.present
    @State private var currentPerson = Person.S3
    @State private var sentenceString: String = ""
    @State private var m_clause = dIndependentClause(language: .Spanish)
    
    var body: some View {
        
        VStack{
        HStack {
            Spacer()
            Button(action: {
                currentLanguage = .Spanish
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                currentLanguageString = "Spanish"
            }){
                Text("Spanish")
            }
            Spacer()
            Button(action: {
                currentLanguage = .French
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                currentLanguageString = "French"
            }){
                Text("French")
            }

        }.background(Color.yellow)
        .padding()
            Text("Current language: \(currentLanguageString)")
                .background(currentLanguage == .Spanish ? Color.orange : Color.pink)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Random sentence:")
            
            Text(sentenceString).border(Color.green)
            
            HStack{
                Button(action: {processSentence1( )}) {
                    Text("Random sentence 1")
                        .background(Color.green)
                        .foregroundColor(Color.yellow)
                }
                Button(action: {processSentence2( )}) {
                    Text("Random sentence 2")
                        .background(Color.blue)
                        .foregroundColor(Color.yellow)
                }
            }
            .padding()
        }.onAppear{currentLanguage = .Spanish
            cfModelView.createNewModel(language: currentLanguage)
            sentenceString = ""
            currentLanguageString = "Spanish"}

        VStack{
            HStack{
                Button(action: {
                    generateRandomTense()
                }){
                    Text("Tense")
                }.background(Color.yellow)
                Text(": \(currentTense.rawValue)")
            }
            .padding()
            HStack{
                Button(action: {
                    generateRandomPerson()
                }){
                    Text("Person")
                }.background(Color.yellow)
                Text(": \(currentPerson.getEnumString())")
            }
        }
        Spacer()
    }
    
    func processSentence1(){
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            m_clause = cfModelView.getRandomSentence()
            sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
        }
    }
    
    func processSentence2(){
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            m_clause = cfModelView.getRandomSubjPronounSentence()
            sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
        }
    }
    
    func generateRandomTense(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
    }
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.createNewSentenceString(tense: currentTense, person: currentPerson)
    }
    
}

struct SentenceGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceGameView()
    }
}
