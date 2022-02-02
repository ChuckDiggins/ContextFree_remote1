//
//  ConciseListView.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/7/21.
//

import SwiftUI
import JumpLinguaHelpers


struct ConciseListView: View {
    
    @State var words : Array<WordComponent>
    @State var wordType : WordType
    
    var body: some View {
   
        List(words){ word in
            Text(word.word)
        }
        
    }
}


struct ConciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ConciseListView(words: Array<WordComponent>(), wordType: .adjective )
    }
}


