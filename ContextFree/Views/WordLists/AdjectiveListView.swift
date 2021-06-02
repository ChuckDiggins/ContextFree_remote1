//
//  WordListView.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/7/21.
//

import SwiftUI

enum DisplayType {
    case concise
    case expanded
}



struct AdjectiveListView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    @State private var wordType = WordType.adjective

    @State private var displayType: DisplayType = .concise
    @State var m_words = Array<Word>()
    @State var m_romanceWords = Array<RomanceAdjective>()
    @State var adjWord = ""
    @State var femWord = ""
    @State var plural = ""
    @State var femPlural = ""
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    currentLanguage = .Spanish
                    cfModelView.createNewModel(language: currentLanguage)
                    m_romanceWords = copyWordsToRomanceAdjectives()
                }){
                    Text("Spanish")
                }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
                .foregroundColor(currentLanguage == .Spanish ? Color.red : Color.black)
                Button(action: {
                    currentLanguage = .French
                    cfModelView.createNewModel(language: currentLanguage)
                    m_romanceWords = copyWordsToRomanceAdjectives()
                }){
                    Text("French")
                }.font(currentLanguage == .Spanish ? .system(size: 20) : .title)
                .foregroundColor(currentLanguage == .Spanish ? Color.black : Color.red)
            }
            
            CategoryView(onSelectedCategory: { _ in })
            HStack{
                List(m_romanceWords, id: \.self){word in
                    Text(word.word)
                }
                List(m_romanceWords, id: \.self){word in
                    Text(word.femWord)
                }
                List(m_romanceWords, id: \.self){word in
                    Text(word.mascPlural)
                }
                List(m_romanceWords, id: \.self){word in
                    Text(word.femPlural)
                }
            }.font(.caption)
            Spacer()
        }.onAppear{
            cfModelView.createNewModel(language: currentLanguage)
            m_romanceWords = copyWordsToRomanceAdjectives()
        }
        
        
    }
    
    func copyWordsToRomanceAdjectives()->Array<RomanceAdjective>{
        m_words = cfModelView.getModifierList(wordType: wordType)
        var romanceList = Array<RomanceAdjective>()
        for word in m_words {
            var adj = word as! RomanceAdjective
            romanceList.append(adj)
        }
        return romanceList
    }
    
    
}

