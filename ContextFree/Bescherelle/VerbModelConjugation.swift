//
//  VerbModelConjugation.swift
//  ContextFree
//
//  Created by Charles Diggins on 3/11/21.
//

import Foundation


struct VerbModelConjugation{
    
    var verbModels = [VerbModel]()
    
    mutating func test(){
        verbModels = createVerbModels()
        var vm = getVerbModel(verbWord: "recocer")
        let parseList = vm.parseVerbModel()
        print ("vm id = \(vm.id), modelVerb \(vm.modelVerb) ... exceptionListCount \(vm.exceptionList.count) ... parsedStruct pattern \(parseList[0].pattern)")
        for ps in parseList {
            print ("pattern = \(ps.pattern), from \(ps.from), to \(ps.to), tense = \(ps.tense) ... persons \(ps.personList)")
        }
    }

    mutating func getVerbModel(verbWord: String)->VerbModel{
        if verbModels.count == 0 {
            verbModels = createVerbModels()
        }
        
        let nullVerbModel = VerbModel(id: -1, modelVerb: "")
        for vm in verbModels {
            if vm.isModelFor(verbWord: verbWord){
                print("VerbWord \(verbWord) has verb model \(vm.id) - model verb \(vm.modelVerb)")
                return vm
            }
        }

        return nullVerbModel
    }
    
    mutating func listVerbModel(){
       
        if verbModels.count == 0 {
            verbModels = createVerbModels()
        }
        
        var vmIndex = 0
        for vm in verbModels {
            if ( vmIndex < 10 ){
                dumpModel(vm: vm)
            }
            else {
                break
            }
            vmIndex += 1
        }

    }
    
    func dumpModel(vm : VerbModel){
        var verbModel = vm
        //var idNum = vm.id
        //var modelVerb = vm.modelVerb
        
        let parseList = verbModel.parseVerbModel()
        print ("vm id = \(vm.id), modelVerb \(vm.modelVerb) ... exceptionListCount \(vm.exceptionList.count) ... parsedStruct pattern \(parseList[0].pattern)")
        for ps in parseList {
        //    print ("pattern = \(ps.pattern), from \(ps.from), to \(ps.to), tense = \(ps.tense) ... persons \(ps.personList)")
            print ("pattern = \(ps.pattern), from \(ps.from), to \(ps.to)")
        }
    }
    
}

