//
//  SentenceParser.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct SentenceParserView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var sentenceString: String = ""
    @State private var wordList = Array<Word>()
    @State private var ruleList = Array<ContextFreeRule>()
    
    
    var body: some View {
        VStack(alignment: .leading){
            TextField("New verb phrase", text: $sentenceString)
                .frame(width: 300, height: 30, alignment: .center)
                .border(Color.green)
                .disableAutocorrection(true)
            
            Button(action: {processSentence( )}) {
                Text("Process")
            }
            List{
                ForEach(wordList, id: \.self){ word in
                    Text ("word \(word.word): \(word.getWordType().rawValue)")
                }
            }
        }
    }
    
    func processSentence(){
        sentenceString = getFakeSentence()  //to speed things up for now
        
        let clause = cfModelView.createIndependentClause(clauseString: sentenceString)
        //var sentence = cfModelView.parseSentence(sentenceString: sentenceString)
        let sentenceString = clause.getReconstructedSentenceString()
        print("reconstructed sentence = \(sentenceString)")
      
        wordList = clause.getWordList()
        print ("In SentenceParserView:")
        for word in wordList {
            print("word \(word.word) - wordType = \(word.wordType)")
        }

        clause.setGrammarLibrary(cfLib : cfModelView.getGrammarLibrary())
        clause.createClustersFromWordList()
        clause.analyze()
    }

    
    func getFakeSentence()->String {
        //return "el hombre encima de una mesa azul tiene un perro en casa negra"
        //return "un perros encima de una casas negro tiene un hombre en un lugares bueno"
        //return "nosotros"
        return "nosotros en un casas negra por lo demás tiene un perro en casa pequeños"
        //return  "en casa azul en casa negra"
    }
}

struct SentenceParser_Previews: PreviewProvider {
    static var previews: some View {
        SentenceParserView()
    }
}
