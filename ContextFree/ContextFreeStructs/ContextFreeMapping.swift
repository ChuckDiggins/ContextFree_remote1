//
//  ContextFreeMapping.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/16/21.
//

import Foundation

enum Mapping {
    case OneToOne
    case ManyToOne
    case OneToMany
    case Question
    case Negative
    case Subjunctive
}

struct MappingPair {
    let cfs1 : ContextFreeSymbol
    let cfs2 : ContextFreeSymbol
}

struct ContextFreeMapping {
    let cfs = ContextFreeSymbol.AMB
    
    func createMappingRomanceToEnglishNP1()->[MappingPair]{
        var pairList = [MappingPair]()
        pairList.append( MappingPair(cfs1: .Art, cfs2:.Art) )
        pairList.append( MappingPair(cfs1: .N, cfs2:.Adj) )
        pairList.append( MappingPair(cfs1: .Adj, cfs2:.N) )
        return pairList
    }
    
    func createMappingSpanishQuestion()->[MappingPair]{
        var pairList = [MappingPair]()
        pairList.append( MappingPair(cfs1: .Art, cfs2:.Art) )
        pairList.append( MappingPair(cfs1: .NP, cfs2:.Adj) )
        pairList.append( MappingPair(cfs1: .Adj, cfs2:.NP) )
        return pairList
    }
}
