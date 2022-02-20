//
//  AdjectiveGames.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/6/21.
//

import SwiftUI

struct GamesTemplate: View {
    
    @State private var adjective = ""
    @State private var adjectiveTypeIndex = 0
    @State private var showPhrases = false
    @State private var numberOfLikes = 1
    let adjectiveTypeList = ["Regular", "Possessive", "Interrogative", "Demonstrative"]
    let games = ["Vocabulary", "Singular-Plural", "Male-Female", "Colors", "People", "Tricky", "Mix"]
    let following = ["Preceding", "Following", "Both"]
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Adjectives ")){
                    TextField("Adjective: ", text: $adjective)
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
    
    func saveUser(){
        print("User data saved")
    }
}

struct GamesTemplate_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GamesTemplate()
            GamesTemplate()
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
