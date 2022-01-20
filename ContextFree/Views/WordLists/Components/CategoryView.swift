//
//  AdjectiveListView.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/7/21.
//

import SwiftUI

let categories = ["Regular", "Irregular", "Demonst!", "Inter?", "Poss"]


struct CategoryView: View {
    let onSelectedCategory:(String) -> ()  //closure
    @State private var selectedCategory: String = ""
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self){ category in
                Button(action: {
                    selectedCategory = category
                    onSelectedCategory(category)
                }, label: {
                    Text(category)
                }).padding(10)
                .foregroundColor(selectedCategory  == category ? Color.gray : Color.white)
                .background(selectedCategory == category ? Color.blue:Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                .font(.system(size: 12
                ) )
            }
        }
    }
}
