//
//  AddBVerbView.swift
//  WordGamesSPIFE
//
//  Created by Charles Diggins on 5/9/21.
//

import SwiftUI

struct AddBVerbView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentLanguage = LanguageType.Spanish
    @State private var currentLanguageString = ""
    @State private var newVerbPhrase = ""
    @State private var englishPhrase = ""
    @State private var patternString = ""
    @State private var newVerb = ""
    @State private var bNewVerb = false
    @State private var verbCount = 0
    @State private var alertIsPresented = false
    @State var selected = ""
    @State var show = false
    
    var body: some View {
        //NavigationView{
            VStack{
                HStack{
                    Button(action: {
                        currentLanguage = .Spanish
                        cfModelView.createNewModel(language: currentLanguage)
                        currentLanguageString = "Spanish"
                    }){
                        Text("Spanish")
                    }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
                    .foregroundColor(currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
                    Button(action: {
                        currentLanguage = .French
                        cfModelView.createNewModel(language: currentLanguage)
                        currentLanguageString = "French"
                    }){
                        Text("French")
                    }.font(currentLanguage == .Spanish ? .system(size: 20) : .title)
                    .foregroundColor(currentLanguage == .Spanish ? Color(UIColor(named: "SurgeryBackground")!) : Color.red)
                }.onAppear{
                    currentLanguage = cfModelView.getCurrentLanguage()
                }.padding()
                VStack{
                    Text("New verb phrase: \(newVerbPhrase)")
                    Text("Active verb: \(newVerb)")
                    Text("Pattern: \(patternString)")
                        .font(.body)
                        .foregroundColor(.white)
                    Text("Total verb count: \(verbCount)")
                    TextField("New verb (phrase):", text: $newVerbPhrase)
                        .frame(width: 400, height: 40, alignment: .leading)
                        .border(Color.black)
                        .background(Color.yellow)
                        .disableAutocorrection(true)
                }.onAppear{
                    verbCount = cfModelView.getVerbCount()
                }
                .background(Color.gray)
                .padding()
                VStack{
                    Button(action: {
                        let result = cfModelView.analyzeAndCreateNewBVerb(verbPhrase: newVerbPhrase)
                        if result.0 {
                            let verb = result.1  //BVerb
                            newVerb = verb.m_verbWord
                            newVerbPhrase = verb.m_verbPhrase
                            switch currentLanguage {
                            case .Spanish:
                                let bSpanishVerb = verb as! BSpanishVerb
                                patternString = bSpanishVerb.getBescherelleInfo()
                                let spanishVerb = SpanishVerb(word: bSpanishVerb.m_verbWord, def: "", type: VerbType.normal)
                                spanishVerb.setBVerb(bVerb: bSpanishVerb)
                                //verbCount = cfModelView.append(language: currentLanguage, romanceVerb: spanishVerb )
                            case .French:
                                let bFrenchVerb = verb as! BFrenchVerb
                                patternString = bFrenchVerb.getBescherelleInfo()
                                let frenchVerb = FrenchVerb(word: bFrenchVerb.m_verbWord, def: "", type: VerbType.normal)
                                frenchVerb.setBVerb(bVerb: bFrenchVerb)
                                //verbCount = cfModelView.append(language: currentLanguage, romanceVerb: frenchVerb )
                            default: break
                            }
                        }
                        else {
                            self.alertIsPresented = true
                        }
                    }){
                        Text("Analyze")
                            .padding(10)
                            .background(Color.orange)
                            .cornerRadius(8)
                            .font(.system(size: 24))
                            
                            //add alert for verb is not legal
                            
                            .alert(isPresented: $alertIsPresented, content: {
                                Alert(title: Text("Verb Not Added!"), message: Text("This verb already exists or is illegal"),
                                      dismissButton: .default(Text("OK!")))
                            })
                    }
                    //.padding(5)
                }
            }
            VStack {
                NavigationLink(destination: AddVerbToDictionary()){
                    Text("Add new multilingual verb")
                }.frame(width: 200, height: 50)
                .foregroundColor(.white)
                .padding(.leading, 10)
                .background(Color.red)
                .cornerRadius(10)
                
                Spacer()
            //}.navigationTitle("Add Verbs and Phrases")
        }
    }
    
}

struct AddBVerbView_Previews: PreviewProvider {
    static var previews: some View {
        AddBVerbView()
    }
}

