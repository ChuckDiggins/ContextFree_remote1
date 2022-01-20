//
//  NamedSingleton.swift
//  NamedSingleton
//
//  Created by Charles Diggins on 1/19/22.
//

import Foundation

//single valued phrase containing only words of a single type

class dNamedSingle : dSingle {
    
    private var singleName: String
    
    override init(){
        self.singleName = "No name"
        super.init(word: Word(), clusterType: .AdvP, data: WordStateData() )
    }
    
    init(singleName: String, clusterType: ContextFreeSymbol){
        self.singleName = singleName
        super.init(word: Word(), clusterType: clusterType, data: WordStateData())
    }
    
//    func createSingle(clusterType: ContextFreeSymbol){
//        switch clusterType{
//        case .N: m_phrase = dNounSingle()
//        case .V: m_phrase = dVerbSingle()
//        case .Adj: m_phrase = dAdjectiveSingle()
//        case .Det: m_phrase = dDeterminerSingle()
//        case .Adv: m_phrase = dAdverbSingle()
//        case .P: m_phrase = dPrepositionSingle()
//        case .C: m_phrase = dConjunctionSingle()
//        }
            
    
}
