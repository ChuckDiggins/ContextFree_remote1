//
//  NewNameAlert.swift
//  NewNameAlert
//
//  Created by Charles Diggins on 1/19/22.
//

import SwiftUI

struct NewNameAlert: View {
    
    let screenSize = UIScreen.main.bounds
    
    var title: String = ""
    @Binding var isShown: Bool
    @Binding var text: String
    
    
    var body: some View {
        VStack{
            Text(title)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button("OK"){
                    
                }.padding()
                    .background(Color.green.opacity(0.9))
                    .foregroundColor(.black)
                Button("Cancel"){
                    
                }.padding()
                    .background(Color.red.opacity(0.2))
            }
        }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.2)
        .background(Color.red.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.red.opacity(0.7), radius: 6, x: -9, y: -9)
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
    }
}

struct NewNameAlert_Previews: PreviewProvider {
    static var previews: some View {
        NewNameAlert(isShown: .constant(true), text: .constant(""))
    }
}
