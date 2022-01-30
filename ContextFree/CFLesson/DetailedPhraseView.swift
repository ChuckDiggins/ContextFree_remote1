////
////  DetailedPhraseView.swift
////  ContextFree
////
////  Created by Charles Diggins on 7/20/21.
////
//
//import SwiftUI
//
//struct DetailedPhraseView: View {
//    
//    var namedPhrase : NamedPhrase
//    var language : LanguageType
//    
//    static let colors: [String: Color] = [  "stm": .purple,  //stem changing
//                                          "ort": .gray, //ortho changing
//                                          "irr": .red,  //irregular
//                                          "spc": .yellow,  //special
//                                          "psv": .blue, //passive
//                                          "rfl": .orange, //Reflexive
//                                          "cls": .green  //phrasal
//                                        ]
//
//    var properties = [Bool] ()
//    @State private var singleList = [dSingle]()
//    @State private var currentSingleIndex = 0
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 40) {
//                    Text(namedPhrase.getPhrase().getStringAtLanguage(language: language))
//                        .font(.title)
//                    Divider() // Creates a thin line (Push-out view)
//                    Image(systemName: "arrow.left")
//                }
//                .padding()
//                .foregroundColor(Color.white)
//                .background(RoundedRectangle(cornerRadius: 10)
//                .foregroundColor(.blue))
//                .padding()
//            
//            Spacer()
//            /*HStack{
//            ForEach(namedPhrase.restrictions, id: \.self){
//                restriction in Text(restriction)
//                    //.font(.caption)
//                    .font(.system(size:6.0))
//                    .fontWeight(.black)
//                    .padding(3)
//                    .background(Self.colors[restriction, default: .black])
//                    .clipShape(Circle())
//                    .foregroundColor(.black)
//            }
// */
//            }
//
//        .font(.caption)
//        .onAppear {
//
//        }
//    }
//    
//    /*
//    func changeWord(){
//        let single = singleList[currentSingleIndex]
//        var wsd = single.getSentenceData()
//        
//        switch wsd.wordType {
//        case .V:
//            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .none)
//            single.copyGuts(newSingle: newSingle)
//        case .Adj, .Det, .Adv, .C:
//            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .none)
//            single.copyGuts(newSingle: newSingle)
//        case .N:
//            let nounSingle = single as! dNounSingle
//            var newFunctionType = PPFunctionType.none
//            if nounSingle.isSubject() { newFunctionType = .subject }
//            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType : newFunctionType)
//            nounSingle.copyGuts(newSingle: newSingle)
//            if nounSingle.isSubject() {
//                m_clause.setPerson(value: nounSingle.getPerson())
//            }
//        case .Pronoun:
//            let ppSingle = single as! dPersonalPronounSingle
//            var newFunctionType = PPFunctionType.none
//            if ppSingle.isSubject() { newFunctionType = .subject }
//            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType : newFunctionType)
//            ppSingle.copyGuts(newSingle: newSingle)
//            if ppSingle.isSubject() {
//                m_clause.setPerson(value: ppSingle.getPerson())
//            }
//        case .P:
//            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .none)
//            single.copyGuts(newSingle: newSingle)
//        default: break
//        }
//        wsd = single.getSentenceData()
//        m_clause.processInfo()
//        currentPerson = m_clause.getPerson()
//        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
//        updateCurrentSentenceViewStuff()
//    }
//     */
//}
//
//
//struct DetailedPhraseView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedPhraseView(namedPhrase: NamedPhrase(), language: .Agnostic)
//    }
//}
