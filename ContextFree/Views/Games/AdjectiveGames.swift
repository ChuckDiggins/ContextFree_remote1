//
//  AdjectiveGames.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/6/21.
//

import SwiftUI

struct AdjectiveGames: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    @State private var currentLanguageString = "Spanish"
    @State private var currentTense = Tense.present
    @State private var currentPerson = Person.S3
    @State private var m_clause = dIndependentClause(language: .Spanish)
    @State private var spanishFont : Font?
    @State private var frenchFont : Font?
    @State private var adjective = ""
    @State private var adjectiveTypeIndex = 0
    @State private var showPhrases = false
    @State private var numberOfLikes = 1
    @State private var sentenceString = ""
    
    let adjectiveTypeList = ["Regular", "Possessive", "Interrogative", "Demonstrative"]
    let games = ["Vocabulary", "Singular-Plural", "Male-Female", "Colors", "People", "Tricky", "Mix"]
    let following = ["Preceding", "Following", "Both"]
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Adjectives ")){
                    VStack{
                        HStack {
                            Spacer()
                            Button(action: {
                                currentLanguage = .Spanish
                                cfModelView.createNewModel(language: currentLanguage)
                                sentenceString = ""
                            }){
                                Text("Spanish")
                            }.buttonStyle(PlainButtonStyle())
                            .font(currentLanguage == .Spanish ? .title : .system(size: 20) )
                            .foregroundColor(currentLanguage == .Spanish ? Color.red : Color.black)
                            padding()
                            
                            Button(action: {
                                currentLanguage = .French
                                cfModelView.createNewModel(language: currentLanguage)
                                sentenceString = ""
                            }){
                                Text("French")
                            }.buttonStyle(PlainButtonStyle())
                            .font(currentLanguage == .Spanish ? .system(size: 20) : .title)
                            .foregroundColor(currentLanguage == .Spanish ? Color.black : Color.red)
  
                        }
                    }
                    
                    TextField("Adjective: ", text: $sentenceString).font(.title)
                    
                    Button(action: {generateRandomPhrase( )}) {
                        Text("Create Random Phrase")
                    }
                    .background(Color.yellow)
                    .buttonStyle(PlainButtonStyle())
                    
                    Picker(selection: $adjectiveTypeIndex, label: Text("Adjective type")){
                        ForEach(0 ..< adjectiveTypeList.count){
                            Text(self.adjectiveTypeList[$0]).tag($0)
                        }
                    }
                }
                Section(header: Text("Practice")){
                    Toggle("Show phrases", isOn: $showPhrases)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    Stepper("Number of likes", value: $numberOfLikes, in: 1 ... 100)
                    Text("Number of likes: \(numberOfLikes)")
                }
                
            }
            .onAppear{
                currentLanguage = .Spanish
                cfModelView.createNewModel(language: currentLanguage)
                sentenceString = ""
                currentLanguageString = "Spanish"
            }
            .navigationTitle("Adjective games")
            //.onTapGesture{hideKeyboard()}  //or any other action
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    Button("Save", action: saveUser)
                }
            }
        }.accentColor(.red)
    }
    
    func generateRandomPhrase(){
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            let adjType = AdjectiveType.any
            //m_clause = cfModelView.getRandomPhraseForAdjectives(type: adjType.getPrimaryType(index: adjectiveTypeIndex))
            sentenceString = m_clause.createNewSentenceString()
            print(sentenceString)
        }
    }
    
    func saveUser(){
        print("User data saved")
    }
}

struct AdjectiveGames_Previews: PreviewProvider {
    static var previews: some View {
        AdjectiveGames()
    }
}

