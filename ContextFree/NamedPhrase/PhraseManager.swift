//
// PhraseManager.swift
//  NamedPhraseManager
//
//  Created by Charles Diggins on 1/11/22.
//

import Foundation

struct dPhraseManager{
    private var m_clusterList = Array<dCluster>()

    mutating func appendCluster(cluster: dCluster){
        m_clusterList.append(cluster)
    }
    
    func getCluster(index: Int)->dCluster{
        if index >= 0 && index < m_clusterList.count { return m_clusterList[index] }
        return dCluster()
    }
    
    func getClusterCount()->Int{
        return m_clusterList.count
    }
    
    mutating func clear(){
        m_clusterList.removeAll()
    }
    
    func getClusterByName(clusterName: String)->dCluster{
        for cluster in m_clusterList{
            if cluster.getClusterName() == clusterName {return cluster}
        }
        return dCluster()
    }
    
}
