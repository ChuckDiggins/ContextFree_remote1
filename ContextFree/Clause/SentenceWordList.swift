//
//  SentenceWordList.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation


public struct SentenceWordList{
    var m_wordStringList = Array<String>()
    public func getCount()->Int{return m_wordStringList.count}
    public func getWordStringAt(index: Int)->String{
        if ( index < getCount() ){
        return m_wordStringList[index]
        }
        return ""
    }
    
    public mutating func clear(){m_wordStringList.removeAll()}
    public mutating func append(wordString: String){m_wordStringList.append(wordString)}
    public mutating func delete(index: Int){m_wordStringList.remove(at: index)}
    public mutating func getString()->String{
        var str = ""
        for wordString in m_wordStringList {
            str += wordString + " "
        }
        str.removeLast()
        str.capitalizeFirstLetter()  //see string extension above
        return str
    }

    
}
