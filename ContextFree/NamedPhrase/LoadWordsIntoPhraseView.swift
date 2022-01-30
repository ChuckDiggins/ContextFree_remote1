//
//  LoadWordsIntoPhraseView.swift
//  LoadWordsIntoPhraseView
//
//  Created by Charles Diggins on 1/10/22.
//

import SwiftUI

//see How to use @ObservableObject and @StateObject in SwiftUI - Bootcamp#50

struct WordTypeButton: View {
    var wordText : String
    var backgroundColor: Color
    var foregroundColor: Color
    var fontSize : Font
    var wordType: WordType
    var function: (_ wordType: WordType) -> Void
    
    var body: some View {
        Button(action: {
            self.function(wordType)
        }){
            Text(wordText)
        }
        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 30)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(8)
        .font(fontSize)
        
    }
}


//struct LoadWordsIntoPhraseView: View {
//    @EnvironmentObject var cfModelView : CFModelView
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State var selection = "Word types"
//    
//    public init(wordViewModel: WordViewModel){
//        self.wordViewModel = wordViewModel
//    }
//    
//    @ObservedObject var wordViewModel: WordViewModel  //use this for subviews
//    
//    var wordType = WordType.ambiguous
//    var clusterIndex = 0
//    
//    @State var posList : [String] = []
//    @State var pickerList : [String] = []
//    private var defaultBackgroundColor = Color.yellow
//    private var selectedBackgroundColor = Color.green
//    
//    private var gridItems = [GridItem(.flexible()),
//                             GridItem(.flexible()),
//                             GridItem(.flexible())]
//    
//    var body: some View {
//        ScrollView{
//            LazyVGrid(columns: gridItems, spacing: 5){
//                ForEach ((0..<posList.count), id: \.self){ index in
//                    NavigationLink(destination:LoadWordsView(index:index, wordViewModel: wordViewModel)){
//                        VStack{
//                            Text(posList[index])
//                            Text("\(wordViewModel.getAssociatedWords(index:index).count)").background(Color.white)
//                        }
//                    }.frame(width: 50, height: 50)
//                        .padding(5)
//                        .background(Color.orange)
//                        .cornerRadius(10)
//                }
//            }
//            .onAppear{
//                posList.removeAll()
//                for index in 0..<wordViewModel.getClusterCount() {
//                    let clusterType = wordViewModel.getClusterType(index: index)
//                    posList.append( clusterType.rawValue )
//                }
//            }
//            HStack{
//                Button(action: {
//                    //NewNameAlert(isShown: .constant(true), text: .constant("Enter phrase name"))
//                    presentationMode.wrappedValue.dismiss()
//                }){
//                    Text("Save as")
//                }
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }){
//                    Text("Cancel")
//                }
//            }
//            Spacer()
//        }
//        
//        
//    }
//    
//}

struct LoadWordsIntoRegularPhraseView: View {
    @EnvironmentObject var cfModelView : CFModelView
    @Environment(\.presentationMode) var presentationMode
    
    @State var selection = "Word types"
    
//    public init(wordViewModel: WordViewModel){
//        self.wordViewModel = wordViewModel
//    }
//
    public init(wordViewModel: RegularWordViewModel){
        self.wordViewModel = wordViewModel
    }
    
//    @ObservedObject var wordViewModel: WordViewModel  //use this for subviews
    @ObservedObject var wordViewModel: RegularWordViewModel  //use this for subviews
    
    var wordType = WordType.ambiguous
    var clusterIndex = 0
    
    @State var posList : [String] = []
    @State var pickerList : [String] = []
    private var defaultBackgroundColor = Color.yellow
    private var selectedBackgroundColor = Color.green
    
    private var gridItems = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItems, spacing: 5){
                ForEach ((0..<posList.count), id: \.self){ index in
                    NavigationLink(destination:RegularLoadWordsView(index:index, wordViewModel: wordViewModel)){
                        VStack{
                            Text(posList[index])
                            Text("\(wordViewModel.getAssociatedWords(index:index).count)").background(Color.white)
                        }
                    }.frame(width: 50, height: 50)
                        .padding(5)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .onAppear{
                posList.removeAll()
                for index in 0..<wordViewModel.getClusterCount() {
                    let clusterType = wordViewModel.getClusterType(index: index)
                    posList.append( clusterType.rawValue )
                }
            }
            HStack{
                Button(action: {
                    //NewNameAlert(isShown: .constant(true), text: .constant("Enter phrase name"))
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Save as")
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Cancel")
                }
            }
            Spacer()
        }
        
        
    }
    
}

struct RegularLoadWordsView : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cfModelView : CFModelView
    @ObservedObject var wordViewModel: RegularWordViewModel  //use this for subviews
    
    public init(index: Int, wordViewModel: RegularWordViewModel){
        self.wordViewModel = wordViewModel
        clusterIndex = index
    }
    
    @State var currentWordTypeString = ""
    private var defaultBackgroundColor = Color.yellow
    private var selectedBackgroundColor = Color.green
    private var clusterIndex = 0
    private var currentWordType = WordType.ambiguous
    private var gridItems = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]
    var body: some View {
        ScrollView{
            HStack{
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.red)
                    .foregroundColor(.white)
                
                Button("Save") {
                    _ = wordViewModel.fillAssociatedWords(index: clusterIndex)
                    presentationMode.wrappedValue.dismiss()
                }.background(Color.green)
                    .foregroundColor(.white)
                    .padding()
            }.padding(10)
            Text("Selected word count: \(wordViewModel.getSelectedWordCount())")
                .foregroundColor(.red).font(.subheadline)
                .background(Color.white)
                .padding(10)
            
            LazyVGrid(columns: gridItems, spacing: 5){
                ForEach ((0..<wordViewModel.wordModelList.count), id: \.self){ index in
                    Button(wordViewModel.wordModelList[index].word.word)
                    {
                        wordViewModel.wordModelList[index].isSelected.toggle()
                    }
                    .frame(minWidth: 50, maxWidth: .infinity, minHeight: 30)
                    .background(wordViewModel.wordModelList[index].isSelected ? selectedBackgroundColor : defaultBackgroundColor)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .font(.subheadline)
                }
            }
        }.onAppear{
            fillWordList(wordType: wordViewModel.getWordType(index: clusterIndex))
        }
    }
    func fillWordList(wordType: WordType){
        _ = wordViewModel.fillWordModelList(wordList: cfModelView.getAgnosticWordList(wordType: wordType))
        setCurrentWordType(wordType: wordType)
    }
    
    func setCurrentWordType(wordType: WordType){
        currentWordTypeString = "List:  " + wordType.rawValue + "s"
    }
    
}

//struct LoadWordsView : View {
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var cfModelView : CFModelView
//    @ObservedObject var wordViewModel: WordViewModel  //use this for subviews
//    
//    public init(index: Int, wordViewModel: WordViewModel){
//        self.wordViewModel = wordViewModel
//        clusterIndex = index
//    }
//    
//    @State var currentWordTypeString = ""
//    private var defaultBackgroundColor = Color.yellow
//    private var selectedBackgroundColor = Color.green
//    private var clusterIndex = 0
//    private var currentWordType = WordType.ambiguous
//    private var gridItems = [GridItem(.flexible()),
//                             GridItem(.flexible()),
//                             GridItem(.flexible())]
//    var body: some View {
//        ScrollView{
//            HStack{
//                Button("Cancel") {
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .padding()
//                .background(Color.red)
//                    .foregroundColor(.white)
//                
//                Button("Save") {
//                    _ = wordViewModel.fillAssociatedWords(index: clusterIndex)
//                    presentationMode.wrappedValue.dismiss()
//                }.background(Color.green)
//                    .foregroundColor(.white)
//                    .padding()
//            }.padding(10)
//            Text("Selected word count: \(wordViewModel.getSelectedWordCount())")
//                .foregroundColor(.red).font(.subheadline)
//                .background(Color.white)
//                .padding(10)
//            
//            LazyVGrid(columns: gridItems, spacing: 5){
//                ForEach ((0..<wordViewModel.wordModelList.count), id: \.self){ index in
//                    Button(wordViewModel.wordModelList[index].word.word)
//                    {
//                        wordViewModel.wordModelList[index].isSelected.toggle()
//                    }
//                    .frame(minWidth: 50, maxWidth: .infinity, minHeight: 30)
//                    .background(wordViewModel.wordModelList[index].isSelected ? selectedBackgroundColor : defaultBackgroundColor)
//                    .foregroundColor(.black)
//                    .cornerRadius(8)
//                    .font(.subheadline)
//                }
//            }
//        }.onAppear{
//            fillWordList(wordType: wordViewModel.getWordType(index: clusterIndex))
//        }
//    }
//    
//    func fillWordList(wordType: WordType){
//        _ = wordViewModel.fillWordModelList(wordList: cfModelView.getAgnosticWordList(wordType: wordType))
//        setCurrentWordType(wordType: wordType)
//    }
//    
//    func setCurrentWordType(wordType: WordType){
//        currentWordTypeString = "List:  " + wordType.rawValue + "s"
//    }
//    
//    
//}

struct SelectedWordListView : View {
    @Environment(\.presentationMode) var or
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Button(action: {
                
            }, label: {
                Text("Go back")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            })
        }
    }
    
}

//struct LoadWordsIntoPhraseView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadWordsIntoPhraseView(wordViewModel: WordViewModel())
//    }
//}

