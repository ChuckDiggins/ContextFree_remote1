//
//  BRomanceVerb.swift
//  ContextFree
//
//  Created by Charles Diggins on 3/24/21.
//

import Foundation

class BRomanceVerb: BVerb {
    var verbEnding : VerbEnding
    var m_verbStem = ""
    var m_isReflexive : Bool
    var m_stemChanging = false
    var m_stemFrom = ""
    var m_stemTo = ""
    var m_preposition = ""
    
    var m_morphStruct = [MorphStruct]()
    var m_initialMorphObject = [MorphStruct]()
    
    init(verbPhrase: String, verbWord: String, verbEnding: VerbEnding, languageType: LanguageType, isReflexive: Bool, preposition : String){
        self.verbEnding = verbEnding
        self.m_isReflexive = isReflexive
        self.m_preposition = preposition
        super.init(verbPhrase: verbPhrase, verbWord: verbWord, languageType: languageType)
    }
    
    override init(){
        self.verbEnding = .none
        self.m_isReflexive = false
        self.m_preposition = ""
        super.init(verbPhrase: "", verbWord: "", languageType: LanguageType.Spanish)
    }

    func isReflexive()->Bool{
        return m_isReflexive
    }
    
    func isVerbPhrase()->Bool{
        return m_preposition.count>0
    }
 
    func hasPreposition()->Bool{
        return m_preposition.count>0
    }
    
    func getVerbStem(verbWord: String, verbEnding : VerbEnding )->String {
        var verbStem = verbWord
        verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        if verbEnding == .OIR {
            verbStem.remove(at: verbStem.index(before: verbStem.endIndex))
        }
        return verbStem
    }

    func isStemChanging()->Bool {
        return m_stemChanging
        //return bVerbModel.isStemChanging
    }

    func isPersonStem(person: Person)->Bool {
        if person == .P1 || person == .P2 {return false}
        return true
    }
    
    func initializeMorphStructs(){
        //create and initialize the morph struct
        
        for person in Person.allCases {
            //m_initialMorphObject.clear()
            m_initialMorphObject.append(MorphStruct(person: person))
            m_morphStruct.append(MorphStruct(person: person))
            var morphStep = MorphStep()
            var verbForm = m_verbWord
            if isReflexive() { verbForm = verbForm + "se" }
            morphStep.index = 0
            morphStep.morphType = .startWithInfinitive
            morphStep.verbForm = verbForm
            morphStep.part1 = verbForm
            morphStep.comment = "start with the infinitive ->" + morphStep.part1
            m_initialMorphObject[person.rawValue].clear()
            m_initialMorphObject[person.rawValue].append(morphStep : morphStep)
            m_morphStruct[person.rawValue].clear()
            m_morphStruct[person.rawValue].append(morphStep : morphStep)
            //if person == .S1 {
            //    print("initialize:  morphStepCount = \( m_morphStruct[person.rawValue].count())")
           // }
        }

    }
    
    /*
    func addReflexiveMorphing(){
        //create and initialize the morph structs
        
        let vrp = ViperRomancePronoun(language: .Spanish)
        
        for person in Person.allCases {
            var morphStep = MorphStep()
            morphStep.index = 0
            morphStep.morphType = .nada
            morphStep.verbForm = m_verbWord
            morphStep.part1 = m_verbWord
            morphStep.part2 = "se"
            morphStep.comment = "grab the reflexive pronoun -> se"
            m_initialMorphObject[person.rawValue].append(morphStep : morphStep)
            m_morphStruct[person.rawValue].append(morphStep : morphStep)
            
            morphStep = MorphStep()
            morphStep.index = 0
            morphStep.morphType = .nada
            //morphStep.verbForm = m_verbWord
            morphStep.part1 = ""
            morphStep.part2 = vrp.getReflexive(person: person) + " "
            morphStep.part3 = m_verbWord
            morphStep.verbForm = morphStep.part1 + morphStep.part2 + morphStep.part3
            morphStep.comment = "convert to person and move to front of the verb"
            m_initialMorphObject[person.rawValue].append(morphStep : morphStep)
            m_morphStruct[person.rawValue].append(morphStep : morphStep)
        }

    }
    */
    
    func setMorphStruct(person : Person, morphStruct : MorphStruct){
        m_morphStruct[person.rawValue].copyContents(input: morphStruct)
    }
 
    func resetMorphStructs() {
        for p in 0..<6 {
            m_morphStruct[p].clear()
        }
    }
    
    func resetMorphStructIndices() {
        for p in 0..<6 {
            m_morphStruct[p].resetMorphIndex()
        }
    }

    func restartMorphSteps(person : Person){
        m_morphStruct[person.rawValue].resetMorphIndex()
    }
    
    func isFinalMorphStep(person : Person)->Bool{
        return m_morphStruct[person.rawValue].isFinalMorphStep()
    }
    
    func incrementMorphStep(person : Person)->MorphStep {
        m_morphStruct[person.rawValue].incrementIndex()
        return getCurrentMorphStep(person : person)
    }
    
    func getCurrentMorphIndex(person : Person)-> Int {
        return m_morphStruct[person.rawValue].getMorphIndex()
    }
    
    func getFinalVerbForm(person: Person)->String{
        getMorphStruct(person : person).finalVerbForm()
    }
    
    func getCurrentMorphStep(person : Person)->MorphStep{
        return m_morphStruct[person.rawValue].getCurrentMorphStep()
    }
    
    func getMorphStepCount(person: Person)->Int{
        return getMorphStruct(person : person).count()
    }
    
    func getMorphStruct(person : Person)-> MorphStruct {
        return m_morphStruct[person.rawValue]
    }

  
}
