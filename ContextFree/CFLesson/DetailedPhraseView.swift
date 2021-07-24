//
//  DetailedPhraseView.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/20/21.
//

import SwiftUI

struct DetailedPhraseView: View {
    
    var namedPhrase : NamedPhrase
    var language : LanguageType
    
    static let colors: [String: Color] = [  "stm": .purple,  //stem changing
                                          "ort": .gray, //ortho changing
                                          "irr": .red,  //irregular
                                          "spc": .yellow,  //special
                                          "psv": .blue, //passive
                                          "rfl": .orange, //Reflexive
                                          "cls": .green  //phrasal
                                        ]

    var properties = [Bool] ()
    
    var body: some View {
        HStack {
            Text(namedPhrase.getPhrase().getStringAtLanguage(language: language))
            Spacer()
            /*HStack{
            ForEach(namedPhrase.restrictions, id: \.self){
                restriction in Text(restriction)
                    //.font(.caption)
                    .font(.system(size:6.0))
                    .fontWeight(.black)
                    .padding(3)
                    .background(Self.colors[restriction, default: .black])
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
 */
            }

        .font(.caption)
        .onAppear {

        }
    }
}


struct DetailedPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedPhraseView(namedPhrase: NamedPhrase(), language: .Agnostic)
    }
}
