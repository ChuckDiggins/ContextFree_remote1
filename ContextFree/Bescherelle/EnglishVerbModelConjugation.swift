//
//  EnglishVerbModelConjugation.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/17/21.
//

import Foundation

public class EnglishVerbModelConjugation : VerbModelConjugation{
    
    public init(){
        super.init(currentLanguage: .English)
    }
    
    var verbModels = [EnglishVerbModel]()
    
    public func createVerbModels(){
        if verbModels.count == 0 {
            verbModels = createEnglishVerbModels()
            test()
        }
    }
    
    public func loadVerbModels(){
        if verbModels.count == 0 {
            createVerbModels()
        }
    }
    
    
    public  func test(){
        loadVerbModels()
        let vm = getVerbModel(verbWord: "bleed")
        dumpModel(index: vm.id, vm: vm)
    }
    
    
    public func getVerbModel(verbWord: String)->EnglishVerbModel{
        loadVerbModels()
        let nullVerbModel = EnglishVerbModel()
        let vmCount = verbModels.count
        for i in 0 ..< vmCount {
            let vm = verbModels[i]
            if vm.isModelFor(verbWord: verbWord){
                //print("VerbWord \(verbWord) has verb model \(vm.id) - model verb \(vm.infinitive)")
                return vm
            }
        }
        return nullVerbModel
    }
    
    public func listVerbModels(){
        var vmIndex = 0
        print("Start of model dump\n\n")
        for vm in verbModels {
            if ( vmIndex < 1000 ){
                dumpModel(index: vmIndex, vm: vm)
            }
            else {
                break
            }
            vmIndex += 1
        }
        print("End of model dump\n\n")
        
    }
    
    public func dumpModel(index: Int, vm : EnglishVerbModel){
        print ("vm id = \(vm.id), forms = \(vm.infinitive) : \(vm.preterite) : \(vm.pastPart)")
    }
}
