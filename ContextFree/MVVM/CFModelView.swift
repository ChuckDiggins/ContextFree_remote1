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
    
    /*
    func setCurrentLanguage(language: LanguageType){
        cfModel!.m_currentLanguage = language
    }
    */
    
    func getParser()->WordStringParser{
        return cfModel!.getParser()
    }
    func createNewModel(language: LanguageType){
        cfModel = CFModel(language: language)
    }
    
    func getVerbModel(language: LanguageType)->VerbModelConjugation{
        return (cfModel?.getVerbModel(language: language))!
    }
    
    func getRandomWordList()->RandomWordLists{
        return (cfModel?.getRandomWordLists())!
    }
    
    func getWordStringParser()->WordStringParser{
        return (cfModel?.getWordStringParser())!
    }
    
    func getRandomAgnosticSentence(rft: RandomPhraseType)->dIndependentAgnosticClause{
        return (cfModel?.getRandomAgnosticSentence(rft: rft))!
    }

    func getRandomAgnosticPronounPhrase(rft: RandomPhraseType)->dIndependentAgnosticClause{
        return (cfModel?.getRandomAgnosticSentence(rft: rft))!
    }

    func getRandomSentenceObject()->RandomSentence{
        return (cfModel?.getRandomSentenceObject())!
    }
    
    /*
    func appendAgnosticWord(wordType: WordType, spanishWord : String, frenchWord : String, englishWord: String){
        return cfModel!.appendAgnosticWord(wordType: wordType, spanishWord : spanishWord, frenchWord : frenchWord, englishWord: englishWord)
    }
    

    func analyzeAgnosticWord(wordType: WordType, spanishWord : String, frenchWord : String, englishWord: String)->Bool {
        return cfModel!.analyzeAgnosticWord(wordType: wordType, spanishWord : spanishWord, frenchWord : frenchWord, englishWord: englishWord)
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
        return 5
    }
 
    func append(spanishVerb : RomanceVerb, frenchVerb: RomanceVerb ){
       cfModel!.append(spanishVerb: spanishVerb, frenchVerb : frenchVerb)
    }

    func getCurrentLanguage()->LanguageType{
        return cfModel!.m_currentLanguage
    }

    /*
    func getRandomSentence()->dIndependentClause{
        return cfModel!.getRandomSentence()
    }
    */
    func getRandomAgnosticSentence()->dIndependentAgnosticClause{
        return cfModel!.getRandomAgnosticSentence()
    }
    
    func getAgnosticRandomSubjPronounSentence()->dIndependentAgnosticClause{
        return cfModel!.getAgnosticRandomSubjPronounSentence()
    }
    
    func getModifierList(wordType: WordType)->Array<Word>{
        return cfModel!.getModifierList(wordType: wordType)
    }
    
    func getNounList()->Array<Word>{
        return cfModel!.getNounList()
    }
    
    func getVerbList()->Array<Word>{
        return cfModel!.getVerbList()
    }
    
    func getVerbCount()->Int{
        return cfModel!.getVerbCount()
    }
    
    /*
    func getRandomSubjPronounSentence()->dIndependentClause{
        return cfModel!.getRandomSubjPronounSentence()
    }
    */
    
    func getRandomTense()->Tense{
        return cfModel!.getRandomTense()
    }
    
    func getNextTense()->Tense{
        return cfModel!.getNextTense()
    }
    
    func getPreviousTense()->Tense{
        return cfModel!.getPreviousTense()
    }
    
    func getGrammarLibrary()->CFGrammarLibrary{
        return cfModel!.getGrammarLibrary()
    }
    
    func createIndependentClause(clauseString: String)->dIndependentClause{
        return cfModel!.createIndependentClause(clauseString: clauseString)
    }
    
}
