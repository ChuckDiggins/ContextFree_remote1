//
//  ExpandedListView.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/7/21.
//

import SwiftUI
import JumpLinguaHelpers

struct ExpandedAdjectiveView: View {
    @State var words : Array<ModifierComponent>
    @State var wordType : WordType
    
    var body: some View {
        List(words, id: \.self){word in
            Text(word.word)
            Text(word.plural)
            Text(word.femWord)
            Text(word.femPlural)
        }
    }
        
}

