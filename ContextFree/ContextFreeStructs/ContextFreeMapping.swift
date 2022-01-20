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
    case ManyToMany
    case Question
    case Negative
    case Subjunctive
}

struct MappingPair {
    let cfs1 : ContextFreeSymbol
    let cfs2 : ContextFreeSymbol
}

struct ContextFreeMapping {
    //let cfs = ContextFreeSymbol.AMB
  
    func getMapping(languageFrom: LanguageType, languageTo: LanguageType, phraseType: ContextFreeSymbol)->Mapping{
        return Mapping.OneToOne
    }
    
    //assumes that RomanceVP maps one-to-one with EnglishVP at the verb phrase level
    //composite phrases such as NP and PP will have their own mapping
    //does not address adjective phrases or adverbial phrases, etc.
    
    func fromRomanceVPToEnglishVP(fromVP: dVerbPhrase)->dVerbPhrase{
        let toVP = dVerbPhrase()
        
        for index  in 0 ..< fromVP.getClusterList().count {
            let cluster = fromVP.m_clusterList[index]
            let clusterType = cluster.getClusterType()
            switch clusterType {
            case .NP:
                let c = cluster as! dNounPhrase
                toVP.appendCluster(cluster: fromRomanceNPToEnglishNP(fromNP: c))
            case .PP:
                let c = cluster as! dPrepositionPhrase
                toVP.appendCluster(cluster: fromRomancePPToEnglishPP(fromPP: c))
            default:
                toVP.appendCluster(cluster: cluster)
            }
        }
        return toVP
    }
    
    func fromRomancePPToEnglishPP(fromPP: dPrepositionPhrase)->dPrepositionPhrase{
        let toPP = dPrepositionPhrase()
        
        for index  in 0 ..< fromPP.getClusterList().count {
            let cluster = fromPP.m_clusterList[index]
            let clusterType = cluster.getClusterType()
            switch clusterType {
            case .NP:
                let c = cluster as! dNounPhrase
                toPP.appendCluster(cluster: fromRomanceNPToEnglishNP(fromNP: c))
            case .PP:
                let c = cluster as! dPrepositionPhrase
                toPP.appendCluster(cluster: fromRomancePPToEnglishPP(fromPP: c))
            default:
                toPP.appendCluster(cluster: cluster)
            }
        }
        return toPP
    }
    
    func fromRomanceNPToEnglishNP(fromNP: dNounPhrase)->dNounPhrase{
        let toNP = dNounPhrase()
        
        var npCount = 0
        var ppCount = 0
        var detCount = 0
        var adjCount = 0
        var numCount = 0
        var nounCount = 0
        var subjPronounCount = 0
        
        for index  in 0 ..< fromNP.getClusterList().count {
            let cluster = fromNP.m_clusterList[index]
            let clusterType = cluster.getClusterType()
            switch clusterType {
            case .NP: npCount += 1
            case .PP: ppCount += 1
            case .Det: detCount += 1
            case .Adj: adjCount += 1
            case .Num: numCount += 1
            case .PersPro: subjPronounCount += 1
            case .N: nounCount += 1
            default:
                break
            }
        }
        
        // if subjPronoun, attach it and return it

        if ( subjPronounCount > 0 ){
            for index  in 0 ..< fromNP.getClusterList().count {
                let cluster = fromNP.m_clusterList[index]
                if  cluster.getClusterType() == .PersPro {
                    toNP.appendCluster(cluster: cluster)
                }
            }
            return toNP
        }
        
        //this should resolve nested preposition phrases - in the old nest of all the red birds in the beautiful park
        
        if ( ppCount > 0 ){
            for index  in 0 ..< fromNP.getClusterList().count {
                let cluster = fromNP.m_clusterList[index]
                if  cluster.getClusterType() == .PP {
                    let c = cluster as! dPrepositionPhrase
                    toNP.appendCluster(cluster: fromRomancePPToEnglishPP(fromPP: c))
                }
            }
        }
    
        //otherwise,
        //  1.  process the determiner(s)
        if ( detCount > 0 ){
            var clusterAdded = 0
            for index  in 0 ..< fromNP.getClusterList().count {
                let cluster = fromNP.m_clusterList[index]
                if  cluster.getClusterType() == .Det {
                    toNP.appendCluster(cluster: cluster)
                    clusterAdded += 1
                    if clusterAdded == detCount {
                        break
                    }
                }
            }
        }
        
        
        //  2.  process the number(s)
        if ( numCount > 0 ){
            var clusterAdded = 0
            for index  in 0 ..< fromNP.getClusterList().count {
                let cluster = fromNP.m_clusterList[index]
                if  cluster.getClusterType() == .Adj {
                    toNP.appendCluster(cluster: cluster)
                    clusterAdded += 1
                    if clusterAdded == numCount {
                        break
                    }
                }
            }
        }
        
        //  3.  process the adjective(s)
        if ( adjCount > 0 ){
            var clusterAdded = 0
            for index  in 0 ..< fromNP.getClusterList().count {
                let cluster = fromNP.m_clusterList[index]
                if  cluster.getClusterType() == .Adj {
                    toNP.appendCluster(cluster: cluster)
                    clusterAdded += 1
                    if clusterAdded == adjCount {
                        break
                    }
                }
            }
        }
        
        //finally, process the noun(s)
        if ( nounCount > 0 ){
            var clusterAdded = 0
            for index  in 0 ..< fromNP.getClusterList().count {
                let cluster = fromNP.m_clusterList[index]
                if  cluster.getClusterType() == .N {
                    toNP.appendCluster(cluster: cluster)
                    clusterAdded += 1
                    if clusterAdded == nounCount {
                        break
                    }
                }
            }
        }
        return toNP
    }
    
    func createMappingSubjectToSubjectPronoun(){
        
    }
    
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

