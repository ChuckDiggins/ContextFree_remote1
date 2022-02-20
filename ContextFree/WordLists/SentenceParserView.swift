//
//  SentenceParser.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct SentenceParserView: View {
    @EnvironmentObject var spModelView : SPModelView
    @State private var sentenceString: String = ""
    @State private var newSentenceString: String = ""
    @State private var wordList = Array<Word>()
    @State private var ruleList = Array<ContextFreeRule>()
    @State private var currentLanguage: LanguageType?
    @State private var currentLanguageString = ""
    
    var body: some View {
        
        VStack{
        HStack {
            Spacer()
            Button(action: {
                currentLanguage = .Spanish
                spModelView.createNewModel(language: currentLanguage!)
                sentenceString = ""
                newSentenceString = ""
                currentLanguageString = "Spanish"
            }){
                Text("Spanish")
            }
            Spacer()
            Button(action: {
                currentLanguage = .French
                spModelView.createNewModel(language: currentLanguage!)
                sentenceString = ""
                newSentenceString = ""
                currentLanguageString = "French"
            }){
                Text("French")
            }
            
            Spacer()
        }.background(Color.yellow)
        .padding()
            Text("Current language: \(currentLanguageString)")
                .background(currentLanguage == .Spanish ? Color.orange : Color.blue)
        }
        
        .padding()
        
        VStack(alignment: .leading){
            Text("Input sentence:")
            TextField("New verb phrase",
                      text: $sentenceString,
                      onCommit: {processSentence()}
            ).border(Color.green)
            .disableAutocorrection(true)
            Button(action: {processSentence( )}) {
                Text("Process").background(Color.green)
            }
            Text("Processed sentence: \(newSentenceString)").font(.footnote)
            Spacer()
        }.onAppear{currentLanguage = .Spanish
            spModelView.createNewModel(language: currentLanguage!)
                   sentenceString = ""
                   newSentenceString = ""
            currentLanguageString = "Spanish"}
    }
    
    func processSentence(){
        if ( currentLanguage == .French || currentLanguage == .Spanish ){
            
            if sentenceString.isEmpty {
                sentenceString = getFakeSentence(currentLanguage: currentLanguage!)  //to speed things up for now
            }
            
            print("\n\nSentenceParseView: Starting")
            let clause = spModelView.createIndependentClause(clauseString: sentenceString)
            //var sentence = cfModelView.parseSentence(sentenceString: sentenceString)
            let sentenceString = clause.getReconstructedSentenceString()
            print("reconstructed sentence = \(sentenceString)")
            
            wordList = clause.getWordList()
            print ("In SentenceParserView:")
            for word in wordList {
                let wordString = word.word
                print("word \(wordString) - wordType = \(word.wordType)")
            }
            
            
            
            clause.setGrammarLibrary(cfLib : spModelView.getGrammarLibrary())
            clause.createSinglesFromWordList()
            clause.analyze()
            
            newSentenceString = clause.getProcessedSentenceString()
            print("1. \(newSentenceString)")
            newSentenceString = clause.setTenseAndPersonAndCreateNewSentenceString(tense: .preterite, person: .S3)
            print("2. \(newSentenceString)")
            newSentenceString = clause.setTenseAndPersonAndCreateNewSentenceString(tense: .future, person: .S3)
            print("3. \(newSentenceString)")
            newSentenceString = clause.setTenseAndPersonAndCreateNewSentenceString(tense: .pastPerfectSubjunctiveRA, person: .S3)
            print("3. \(newSentenceString)")
        }
    }

    func getFakeSentence(currentLanguage: LanguageType)->String {
        switch currentLanguage {
        case .Spanish:
            return "nosotros has hablado de ella"
            //return "ella me la está dando el libro"  //ella me lo está dando el libro
            //return "ellos hayamos hablado con ellas"
        //return "nosotros en un casas negra tiene un perro en los casa de nosotros"
        //return "el hombre encima de una mesa azul tiene un perro en casa negra"
        //return "nosotros en un casas negra tiene un perro por lo demás los casa pequeños"
        //return "en la casa de Ustedes"
        case .French:
            return "nous places la livre sur la tables"
        default:
            return "Hello world"
        }
    }
}

struct SentenceParser_Previews: PreviewProvider {
    static var previews: some View {
        SentenceParserView()
    }
}
