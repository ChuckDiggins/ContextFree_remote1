//
//  Correction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

public struct dCorrection {
    var m_error = false
    var m_inputInfo : WordStateData
    var m_outputInfo = WordStateData()
    
    public func getInputInfo()->WordStateData{
        return m_inputInfo
    }
    
    public  func getOutputInfo()->WordStateData{
        return m_outputInfo
    }
    
    public mutating func setOutputInfo(outputInfo: WordStateData){
        m_outputInfo = outputInfo
    }
    
    public func hasError()->Bool {
        return m_error
    }
    
}
