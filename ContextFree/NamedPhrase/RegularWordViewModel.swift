//
//  RegularWordViewModel.swift
//  RegularWordViewModel
//
//  Created by Charles Diggins on 1/20/22.
//

import Foundation

//
//  WordViewModel.swift
//  WordViewModel
//
//  Created by Charles Diggins on 1/15/22.
//

import Foundation
import SwiftUI

struct  WordModel : Identifiable {
    var id: String = UUID().uuidString
    var word: Word
    var isSelected = false
}

class  RegularWordViewModel : ObservableObject {
    @EnvironmentObject var cfModelView : CFModelView
    @Published var wordModelList : [WordModel] = []
    @Published var isLoading: Bool = false
//    var regularPhrase = dPhrase()
    var regularPhrase = dCluster()
    var activeClusterIndex = 0
    
    func hasPhrase()->Bool{
        return regularPhrase.getClusterCount()>0
    }
    
//    func setPhrase(phrase: dPhrase){
//        self.regularPhrase = phrase
//    }
//
//    func getPhrase()->dPhrase{
//        return regularPhrase
//    }
//
    func setPhrase(phrase: dCluster){
        self.regularPhrase = phrase
    }
    
    func getCluster()->dCluster{
        return regularPhrase
    }
    
    func getPhrase()->dPhrase{
        let phrase = regularPhrase as! dPhrase
        return phrase
    }
    
    func setClusterIndex(index: Int){
        activeClusterIndex = index
    }
    
    func getClusterCount()->Int{
        return regularPhrase.getClusterCount()
    }
    
    func getCluster(index: Int)->dCluster{
        activeClusterIndex = index
        return regularPhrase.getCluster(index: index)
    }
    
    func getClusterList()->[dCluster]{
        return regularPhrase.getClusterList()
    }
    
    func getWordType(index: Int)->WordType{
        return ContextFree.getWordType(clusterType: regularPhrase.getCluster(index:index).getClusterType())
    }
    
    func getClusterType(index: Int)->ContextFreeSymbol{
        return regularPhrase.getCluster(index:index).getClusterType()
    }
    
    
    func getWordTypeString(index: Int)->String{
        return getWordType(index: index).rawValue
    }
    
    func fillWordModelList(wordList : Array<Word>)->Int{
        wordModelList.removeAll()
        for word in wordList {
            let w = WordModel(word: word)
            self.wordModelList.append(w)
        }
        return wordModelList.count
    }
    
    func getWordModelCount()->Int{
        return wordModelList.count
    }
    
    func getSelectedWordCount()->Int{
        var count = 0
        for wordModel in wordModelList {
            if wordModel.isSelected {count += 1}
        }
        return count
    }
    
    func fillAssociatedWords(index: Int)->Int{
        getCluster(index: index).clearAssociatedWordList()
        var wordList = [Word]()
        for wordModel in wordModelList {
            if wordModel.isSelected {wordList.append(wordModel.word)}
        }
        getCluster(index: index).putAssociatedWordList(wordList: wordList)
        print("named phrase cluster assoc word count: \(regularPhrase.getCluster(index:activeClusterIndex).getAssociatedWordList().count)")
        return getCluster(index: index).getAssociatedWordList().count
    }
    
    func getAssociatedWords(index: Int)->[Word]{
        return getCluster(index: index).getAssociatedWordList()
    }
}

