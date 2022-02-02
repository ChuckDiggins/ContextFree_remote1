//
//  Add3Words.swift
//  ContextFree
//
//  Created by Charles Diggins on 9/1/21.
//

import SwiftUI
import JumpLinguaHelpers

struct ShowNounStuffView: View {
    @EnvironmentObject var awmModelView : AWMModelView
    @State var spanishPhrase: String
    @State var frenchPhrase: String
    @State var englishPhrase: String
    
    var body: some View {
        VStack{
            Text("Noun plurals:")
            Text("Spanish: \(spanishPhrase)")
            Text("French: \(frenchPhrase)")
            Text("English: \(englishPhrase)")
        }
        Spacer()
    }
    

}

struct ShowVerbStuffView: View {
    @EnvironmentObject var awmModelView : AWMModelView
    @State var spanishPhrase: String
    @State var frenchPhrase: String
    @State var englishPhrase: String
    
    var body: some View {
        Text("Verb phrases:")
        Text("Spanish verb: \(spanishPhrase)")
        Text("French verb: \(frenchPhrase)")
        Text("English verb: \(englishPhrase)")
        Spacer()
    }
}

struct ShowGenericWordStuffView: View {
    @EnvironmentObject var awmModelView : AWMModelView
    @State var spanishPhrase: String
    @State var frenchPhrase: String
    @State var englishPhrase: String
    
    var body: some View {
        Text("Word phrases:")
        Text("Spanish verb: \(spanishPhrase)")
        Text("French verb: \(frenchPhrase)")
        Text("English verb: \(englishPhrase)")
        Spacer()
    }
}



struct AddAgnosticWord: View {
    @EnvironmentObject var awmModelView : AWMModelView
    
    var wordType : WordType
    @State var output: String = ""
    @State var input: String = ""
    @State var typing = false
    
    @State private var all3WordsAreFilled = false
    
    @State private var spanishPhrase = ""
    @State private var frenchPhrase = ""
    @State private var englishPhrase = ""
    
    var body: some View {
        Text("Fill \(wordType.rawValue)")
        Text("Current \(wordType.rawValue) count")
        
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
                ).foregroundColor(.black)
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
                    .foregroundColor(.black)
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
                    .foregroundColor(.black)
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
            
            switch(wordType){
            case .noun:
                //print("WordType = \(wordType.rawValue)")
                ShowNounStuffView(spanishPhrase: spanishPhrase, frenchPhrase: frenchPhrase, englishPhrase: englishPhrase)
            case .verb:
                ShowVerbStuffView(spanishPhrase: spanishPhrase, frenchPhrase: frenchPhrase, englishPhrase: englishPhrase)
            default:
                ShowGenericWordStuffView(spanishPhrase: spanishPhrase, frenchPhrase: frenchPhrase, englishPhrase: englishPhrase)
            }
            
        }.onAppear{
//            awmModelView.getWordCount(wordType: wordType)
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
       
        switch(wordType){
        case .noun:
            print("WordType = \(wordType.rawValue)")
            //compute plural forms
            //determineNounPlurals()
        case .verb:
            print("WordType = \(wordType.rawValue)")
            //computeVerbPatterns()
        default:
            break
        }
    }
    
    /*
    func determineNounPlurals(){
        var analyzeAgnosticWords = AnalyzeAgnosticWords(cfModelView: cfModelView, spanishPhrase: spanishPhrase, frenchPhrase: frenchPhrase, englishPhrase: englishPhrase)
        
    }
    
    func computeVerbPatterns(){
        let analyzeAgnosticWords = AnalyzeAgnosticWords(cfModelView: cfModelView, spanishPhrase: spanishPhrase, frenchPhrase: frenchPhrase, englishPhrase: englishPhrase)
        let result = analyzeAgnosticWords.analyzeVerbs()
        if result.0 && result.1 && result.2 {
            var currentVerb = Verb(spanish: spanishPhrase, french: frenchPhrase, english: englishPhrase)
            let jsonVerb = currentVerb.createJsonVerb()
            print(jsonVerb)
            let verbCount = cfModelView.appendJsonVerb(jsonVerb: jsonVerb)
            let currentIndex = cfModelView.getVerbCount()-1
            let currentVerbNumber = currentIndex
            let word = cfModelView.getListWord(index: currentIndex, wordType: .verb)
            currentVerb = word as! Verb
            let wordCount = cfModelView.getWordCount(wordType:  WordType.verb)
        }
        //showCurrentWordInfo()
    }
*/
    
}


struct AddAgnosticWord_Previews: PreviewProvider {
    static var previews: some View {
        AddAgnosticWord(wordType: WordType.verb)
    }
}
