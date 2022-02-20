//
//  WordViewModel.swift
//  WordViewModel
//
//  Created by Charles Diggins on 1/15/22.
//

import Foundation
import SwiftUI

//struct  WordModel : Identifiable {
//    var id: String = UUID().uuidString
//    var word: Word
//    var isSelected = false
//}

//class  WordViewModel : ObservableObject{
//    @EnvironmentObject var cfModelView : CFModelView
//    @Published var wordModelList : [WordModel] = []
//    @Published var isLoading: Bool = false
//    var namedPhrase = NamedPhrase()
//    var activeClusterIndex = 0
//    
//    func setNamedPhrase(namedPhrase: NamedPhrase){
//        self.namedPhrase = namedPhrase
//    }
//    
//    func getNamedPhrase()->NamedPhrase{
//        return namedPhrase
//    }
//    
//    func setClusterIndex(index: Int){
//        activeClusterIndex = index
//    }
//    
//    func getClusterCount()->Int{
//        return namedPhrase.getClusterCount()
//    }
//    
//    func getCluster(index: Int)->dCluster{
//        activeClusterIndex = index
//        return namedPhrase.getCluster(index: index)
//    }
//    
//    func getClusterList()->[dCluster]{
//        return namedPhrase.getClusterList()
//    }
//    
//    func getWordType(index: Int)->WordType{
//        let _ = ContextFree.getWordType(clusterType: namedPhrase.getCluster(index:index).getClusterType())
//        return ContextFree.getWordType(clusterType: namedPhrase.getCluster(index:index).getClusterType())
//    }
//    
//    func getClusterType(index: Int)->ContextFreeSymbol{
//        return namedPhrase.getCluster(index:index).getClusterType()
//    }
//    
//    
//    func getWordTypeString(index: Int)->String{
//        return getWordType(index: index).rawValue
//    }
//    
//    func fillWordModelList(wordList : Array<Word>)->Int{
//        wordModelList.removeAll()
//        for word in wordList {
//            let w = WordModel(word: word)
//            self.wordModelList.append(w)
//        }
//        return wordModelList.count
//    }
//    
//    func getWordModelCount()->Int{
//        return wordModelList.count
//    }
//    
//    func getSelectedWordCount()->Int{
//        var count = 0
//        for wordModel in wordModelList {
//            if wordModel.isSelected {count += 1}
//        }
//        return count
//    }
//    
//    func fillAssociatedWords(index: Int)->Int{
//        getCluster(index: index).clearAssociatedWordList()
//        var wordList = [Word]()
//        for wordModel in wordModelList {
//            if wordModel.isSelected {wordList.append(wordModel.word)}
//        }
//        getCluster(index: index).putAssociatedWordList(wordList: wordList)
//        print("named phrase cluster assoc word count: \(namedPhrase.getCluster(index:activeClusterIndex).getAssociatedWordList().count)")
//        return getCluster(index: index).getAssociatedWordList().count
//    }
//    
//    func getAssociatedWords(index: Int)->[Word]{
//        return getCluster(index: index).getAssociatedWordList()
//    }
//}
