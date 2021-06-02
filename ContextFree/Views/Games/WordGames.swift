//
//  ContextFreeGrammarSpecificationView.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

struct WordGames: View {
    var body: some View {
        NavigationLink(destination: ArticleGames()){
            Text("Article Games")
        }.frame(width: 200, height: 50)
        .padding(.leading, 10)
        .background(Color.yellow)
        .foregroundColor(.white)
        .cornerRadius(10)
        
        NavigationLink(destination: AdjectiveGames()){
            Text("Adjective Games")
        }.frame(width: 200, height: 50)
        .padding(.leading, 10)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        
        NavigationLink(destination: NounGames()){
            Text("Noun Games")
        }.frame(width: 200, height: 50)
        .padding(.leading, 10)
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(10)
        
        NavigationLink(destination: VerbGames()){
            Text("Verb Games")
        }.frame(width: 200, height: 50)
        .padding(.leading, 10)
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
        
    }
}

struct ContextFreeGrammarSpecificationView_Previews: PreviewProvider {
    static var previews: some View {
        WordGames()
    }
}
