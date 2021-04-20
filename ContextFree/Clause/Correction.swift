//
//  Correction.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/13/21.
//

import Foundation

struct dCorrection {
    var m_error = false
    var m_inputInfo : SentenceWordData
    var m_outputInfo = SentenceWordData()
    
    func getInputInfo()->SentenceWordData{
        return m_inputInfo
    }
    
    func getOutputInfo()->SentenceWordData{
        return m_outputInfo
    }
    
    mutating func setOutputInfo(outputInfo: SentenceWordData){
        m_outputInfo = outputInfo
    }
    
    func hasError()->Bool {
        return m_error
    }
    
}
