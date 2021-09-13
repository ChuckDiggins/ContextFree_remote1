//
//  UtilityViews.swift
//  ContextFree
//
//  Created by Charles Diggins on 9/1/21.
//

import SwiftUI

struct ThreeWordEnterViewOld: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State var spanishPhrase: String
    @State var frenchPhrase: String
    @State var englishPhrase: String
    
    @State var output: String = ""
    @State var input: String = ""
    @State var typing = false
    
    @State private var all3WordsAreFilled = false
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Spanish:")
                TextField("Spanish phrase:", text: $spanishPhrase, onEditingChanged: {
                    self.typing = $0
                    monitorTextEditFields()
                }, onCommit: {
                    self.output = self.input
                    monitorTextEditFields()
                }
                )
                    .background(Color.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }.padding(2)
            HStack{
                Text("French :")
                TextField("French phrase:", text: $frenchPhrase, onEditingChanged: {
                    self.typing = $0
                    monitorTextEditFields()
                }, onCommit: {
                    self.output = self.input
                    monitorTextEditFields()
                })
                    .background(Color.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }.padding(2)
            HStack{
                Text("English:")
                TextField("English phrase:", text: $englishPhrase, onEditingChanged: {
                    self.typing = $0
                    monitorTextEditFields()
                }, onCommit: {
                    self.output = self.input
                    monitorTextEditFields()
                })
                    .background(Color.white)
                    .padding(.trailing,5 )
                    //.disableAutocorrection(true)
                    .autocapitalization(.none)
            }.padding(3)

            //activate button when all three fields have text in them
            Button(action: {
                evaluateWords()
            }){
                Text("   Evaluate   ")
                    .padding(10)
                    .background(Color.orange)
                    .cornerRadius(8)
                    .font(.system(size: 16))
            }.disabled(all3WordsAreFilled==false)
        }
    }
    
    func monitorTextEditFields(){
        all3WordsAreFilled = true
        if spanishPhrase.isEmpty || frenchPhrase.isEmpty || englishPhrase.isEmpty {
            all3WordsAreFilled = false
        }
    }
    
    func evaluateWords(){
        print("Spanish phrase: \(spanishPhrase)")
        print("French phrase: \(frenchPhrase)")
        print("English phrase: \(englishPhrase)")
    }
    
}

