//
//  HeaderView.swift
//  HeaderView
//
//  Created by Charles Diggins on 8/3/21.
//

import SwiftUI



struct HeaderView: View {
    
    var title : String
    var subtitle : String
    var desc: String
    var back : Color
    
    var body: some View {
        VStack(spacing: 20){
            Text(title).font(.largeTitle)
            Text(subtitle).font(.title).foregroundColor(.gray)
            Text(desc)
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundColor(Color.white)
                .padding()
                .background(back)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title here", subtitle: "Subtitle here", desc: "Describe something", back: Color.blue)
    }
}
