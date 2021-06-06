//
//  CFModelView.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/4/21.
//

import Foundation

class CFModelView: ObservableObject {
    private var cfModel : CFModel?
    
    init(){
    }
    
    func getParser()->WordStringParser{
        return cfModel!.getParser()
    }
    func createNewModel(language: LanguageType){
        cfModel = CFModel(language: language)
    }
    
    func getCurrentLanguage()->LanguageType{
        return cfModel!.m_currentLanguage
    }
    
    func getRandomSentence()->dIndependentClause{
        return cfModel!.getRandomSentence()
    }
    
    func getModifierList(wordType: WordType)->Array<Word>{
        return cfModel!.getModifierList(wordType: wordType)
    }
    
    func getNounList()->Array<NounComponent>{
        return cfModel!.getNounList()
    }
    
    func getVerbList()->Array<VerbComponent>{
        return cfModel!.getVerbList()
    }
    
    func getRandomPhraseForAdjectives(type: AdjectiveType)->dIndependentClause{
    return cfModel!.getRandomPhraseForAdjectives(type: type)
    }
    
    func getRandomSubjPronounSentence()->dIndependentClause{
        return cfModel!.getRandomSubjPronounSentence()
    }
    
    func getRandomTense()->Tense{
        return cfModel!.getRandomTense()
    }
    
    func getGrammarLibrary()->CFGrammarLibrary{
        return cfModel!.getGrammarLibrary()
    }
    
    func createIndependentClause(clauseString: String)->dIndependentClause{
        return cfModel!.createIndependentClause(clauseString: clauseString)
    }
    
    func getWorkingVerbList()->[BVerb]{
        return cfModel!.getWorkingVerbList()
    }
    
}
