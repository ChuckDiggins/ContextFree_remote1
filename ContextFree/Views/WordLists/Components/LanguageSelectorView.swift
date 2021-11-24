//
//  LanguageSelectorView.swift
//  LanguageSelectorView
//
//  Created by Charles Diggins on 11/24/21.
//

import SwiftUI

class  LanguageSelection : ObservableObject{
    @Published var selectedLanguage: LanguageType
    
    init(language: LanguageType){
        selectedLanguage = language
    }
}

struct LanguageSelectorView: View {
    @State var currentLanguage : LanguageType
    @ObservedObject var languageSelection : LanguageSelection
    var newLanguageSelected: () -> Void
    
    var body: some View {
        HStack{
            Button(action: {
                languageSelection.selectedLanguage = .Spanish
                self.newLanguageSelected()
            }){
                Text("Spanish")
            }.font(currentLanguage == .Spanish ? .title : .system(size: 10) )
            .foregroundColor(currentLanguage == .Spanish ? Color.black : Color.blue)
            
            Button(action: {
                languageSelection.selectedLanguage = .French
                self.newLanguageSelected()
            }){
                Text("French")
            }.font(currentLanguage == .French ? .title : .system(size: 10) )
            .foregroundColor(currentLanguage == .French ? Color.black : Color.blue)
            
            Button(action: {
                languageSelection.selectedLanguage = .English
                self.newLanguageSelected()
            }){
                Text("English")
            }.font(currentLanguage == .English ? .title : .system(size: 10) )
                .foregroundColor(currentLanguage == .English ? Color.black : Color.blue)
        }.onAppear{
            currentLanguage = languageSelection.selectedLanguage
        }.padding()
    }
}
