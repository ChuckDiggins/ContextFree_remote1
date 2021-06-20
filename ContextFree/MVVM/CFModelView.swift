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
    
    func getVerbModel(language: LanguageType)->VerbModelConjugation{
        return (cfModel?.getVerbModel(language: language))!
    }
    
    /*
    func analyzeAndCreateNewBVerb(verbPhrase: String)->(isValid: Bool, verb: BVerb){
        return cfModel!.analyzeAndCreateNewBVerb(verbPhrase: verbPhrase)
    }
    */
    
    func analyzeAndCreateBVerb_SPIFE(language: LanguageType, verbPhrase: String)->(isValid: Bool, verb: BVerb){
        return cfModel!.analyzeAndCreateBVerb_SPIFE(language: language, verbPhrase: verbPhrase)
    }
    
    func  getWordCount(wordType: WordType)->Int{
        return cfModel!.getWordCount(wordType: wordType)
    }
    
    func getListWord(index: Int, wordType: WordType)->Word{
        return  cfModel!.getListWord(index: index, wordType: wordType)
    }
    
    func appendJsonVerb(jsonVerb: JsonVerb)->Int{
        return cfModel!.appendJsonVerb(jsonVerb: jsonVerb)
    }
 
    func append(spanishVerb : RomanceVerb, frenchVerb: RomanceVerb )->Int{
        return cfModel!.append(spanishVerb: spanishVerb, frenchVerb : frenchVerb)
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
    
    func getVerbList()->Array<Word>{
        return cfModel!.getVerbList()
    }
    
    func getVerbCount()->Int{
        return cfModel!.getVerbCount()
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
