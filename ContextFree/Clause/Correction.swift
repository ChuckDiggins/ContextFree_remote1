//
//  Correction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

struct dCorrection {
    var m_error = false
    var m_inputInfo : WordStateData
    var m_outputInfo = WordStateData()
    
    func getInputInfo()->WordStateData{
        return m_inputInfo
    }
    
    func getOutputInfo()->WordStateData{
        return m_outputInfo
    }
    
    mutating func setOutputInfo(outputInfo: WordStateData){
        m_outputInfo = outputInfo
    }
    
    func hasError()->Bool {
        return m_error
    }
    
}
