//
//  SentenceWordList.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation


struct SentenceWordList{
    var m_wordStringList = Array<String>()
    func getCount()->Int{return m_wordStringList.count}
    func getWordStringAt(index: Int)->String{
        if ( index < getCount() ){
        return m_wordStringList[index]
        }
        return ""
    }
    
    mutating func clear(){m_wordStringList.removeAll()}
    mutating func append(wordString: String){m_wordStringList.append(wordString)}
    mutating func delete(index: Int){m_wordStringList.remove(at: index)}
    mutating func getString()->String{
        var str = ""
        for wordString in m_wordStringList {
            str += wordString + " "
        }
        str.removeLast()
        str.capitalizeFirstLetter()  //see string extension above
        return str
    }

    
}
