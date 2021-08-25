//
//  LanguageChooserView.swift
//  LanguageChooserView
//
//  Created by Charles Diggins on 8/3/21.
//

import SwiftUI

struct LanguageChooserView: View {
    //@EnvironmentObject var cfModelView : CFModelView
    @State var currentLanguage : LanguageType
    
    var body: some View {
        HStack{
            Button(action: {
                currentLanguage = .Spanish
            }){
                Text("Spanish")
            }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
            
            Button(action: {
                currentLanguage = .French
                
            }){
                Text("French")
            }.font(currentLanguage == .French ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .French ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
            
            Button(action: {
                currentLanguage = .English
                
            }){
                Text("English")
            }.font(currentLanguage == .English ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .English ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
        }.padding()
    }
}

struct LanguageChooserView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageChooserView(currentLanguage: LanguageType.Spanish)
    }
}
