//
//  BundleManager.swift
//  BundleManager
//
//  Created by Charles Diggins on 1/28/22.
//

import Foundation

struct dBundleManager{
    var m_bundleList = [dBundle]()
    
    mutating func appendBundle(bundle: dBundle){
        m_bundleList.append(bundle)
    }
    
    func getBundle(index: Int)->dBundle{
        if index >= 0 && index < m_bundleList.count { return m_bundleList[index] }
        return dBundle()
    }
    
    func getBundleCount()->Int{
        return m_bundleList.count
    }
    
    mutating func clear(){
        m_bundleList.removeAll()
    }
}
