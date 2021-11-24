//
//  SentenceView.swift
//  SentenceView
//
//  Created by Charles Diggins on 11/23/21.
//

import SwiftUI

class  ClauseModel: ObservableObject {
    @Published var currentSingleIndex: Int
    @Published var singleIndexList : [[Int]]
    @Published var singleList : [dSingle]
    @Published var englishSingleList : [dSingle]
    @Published var newWordSelected : [Bool]
    @Published var backgroundColor : [Color]
    
    init(currentSingleIndex: Int, singleIndexList: [[Int]], singleList : [dSingle], englishSingleList : [dSingle], newWordSelected : [Bool], backGroundColor : [Color]){
        self.currentSingleIndex = currentSingleIndex
        self.singleIndexList = singleIndexList
        self.singleList = singleList
        self.englishSingleList = englishSingleList
        self.newWordSelected = newWordSelected
        self.backgroundColor = backGroundColor
    }
    
    init(){
        self.currentSingleIndex = 1
        self.singleIndexList = [[Int]]()
        self.singleList = [dSingle]()
        self.englishSingleList = [dSingle]()
        self.newWordSelected = [Bool]()
        self.backgroundColor = [Color]()
    }
}

struct SentenceView: View {
    var language: LanguageType
    var changeWord: () -> Void
    @ObservedObject var clauseModel: ClauseModel
    var highlightColor = Color.white
    var normalColor = Color.black
     
    var body: some View {
//        GeometryReader{ geometry in
            VStack {
                ForEach((0..<2), id:\.self ){ line in
                    HStack{
                        ForEach(clauseModel.singleIndexList[line], id: \.self){index in
                            Button(action: {
                                clauseModel.currentSingleIndex = index
                                clauseModel.newWordSelected[clauseModel.currentSingleIndex].toggle()
                                self.changeWord()
                            }){
                                //Text("\(index)")
                                switch language {
                                case .English:
                                    Text(clauseModel.englishSingleList[index].getProcessWordInWordStateData(language: language))
                                        .font(.subheadline)
                                        .foregroundColor(index == clauseModel.currentSingleIndex ? highlightColor : normalColor)
                                        .background(clauseModel.backgroundColor[index])
                                default:
                                    Text(clauseModel.singleList[index].getProcessWordInWordStateData(language: language))
                                        .font(.subheadline)
                                        .foregroundColor(index == clauseModel.currentSingleIndex  ? highlightColor : normalColor)
                                        .background(clauseModel.backgroundColor[index])
                                }
                            }
                        }
                    }.onAppear{
                        self.changeWord()
                    }
               }
            }
            .padding(10)
            .border(Color.green)
            .background(Color.yellow)
//        }
        
    }
}

