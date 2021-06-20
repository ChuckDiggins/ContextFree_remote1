//
//  FrenchWords.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/22/21.
//

import Foundation

struct FrenchWords{
    var adjectiveList = Array<Word>()
    var demonstrativeAdjectiveList = Array<Word>()
    var interrogativeAdjectiveList = Array<Word>()
    var possessiveAdjectiveList = Array<Word>()
    var adverbList = Array<Word>()
    var ambiguousList = Array<Word>()
    var articleList = Array<Word>()
    var conjunctionList = Array<Word>()
    var determinerList = Array<Word>()
    var nounList = Array<Noun>()
    var prepositionList = Array<Word>()
    var verbList = Array<Word>()
    var pronounList = Array<Word>()
    
    //  ç  è
    
    mutating func createSomeDeterminers(){
        createDeterminerAndAppend(word: "ce", def: "this", type: .definite, femWord: "cette", mascPlural: "ces", femPlural: "ces")
        createDeterminerAndAppend(word: "cet", def: "that", type: .definite, femWord: "cet", mascPlural: "ces", femPlural: "ces")
    }
    
    mutating func createSomePossessiveAdjectives(){
        createPossessiveAdjectiveAndAppend(word: "mon", def: "my", type: .possessive)
    }
    
    mutating func createSomeInterrogativeAdjectives(){
        createInterrogativeAdjectiveAndAppend(word: "quel", def: "what", type: .interrogative)
    }
    
    mutating func createSomeDemonstrativeAdjectives(){
        createDemonstrativeAdjectiveAndAppend(word: "ce", def: "what", type: .demonstrative)
    }
    
    /*
    mutating func createSomeAdjectives(){
        createAdjectiveAndAppend(word: "ce", def: "this", type: .demonstrative, position: .preceding)
        createAdjectiveAndAppend(word: "mon", def: "my", type: .possessive, position: .preceding)
        createAdjectiveAndAppend(word: "amical", def: "friendly", type: .any, position: .following)
        createAdjectiveAndAppend(word: "ancien", def: "old", type: .any, position: .following)
        createAdjectiveAndAppend(word: "belle", def: "beautiful", type: .any, position: .following)
        createAdjectiveAndAppend(word: "blanc", def: "white", type: .any, position: .following)
        createAdjectiveAndAppend(word: "cher", def: "beloved", type: .any, position: .following)
        createAdjectiveAndAppend(word: "différent", def: "different", type: .any, position: .following)
        createAdjectiveAndAppend(word: "drôle", def: "funny", type: .any, position: .following)
        createAdjectiveAndAppend(word: "effrayé", def: "afraid", type: .any, position: .following)
        createAdjectiveAndAppend(word: "ennuyé", def: "annoyed", type: .any, position: .following)
        createAdjectiveAndAppend(word: "fâché", def: "angry", type: .any, position: .following)
    }
    */
    
    mutating func createSomeAmbiguousWords(){
        createAmbiguousAndAppend(word: "", def: "", type: .general)
        createAmbiguousAndAppend(word: "", def: "", type: .pronoun)
    }
    
    mutating func createSomeAdverbs(){
    }
    
    mutating func createSomeArticles(){
        createArticleAndAppend(word: "le", def: "the", type: .definite)
        createArticleAndAppend(word: "un", def: "a", type: .indefinite)
        createArticleAndAppend(word: "du", def: "some", type: .partative)
    }
    
    mutating func createSomeConjunctions(){
        createConjunctionAndAppend(word: "et", def: "and", type: .coordinating)
        createConjunctionAndAppend(word: "ou", def: "or", type: .coordinating)
        createConjunctionAndAppend(word: "mais", def: "but", type: .coordinating)
        createConjunctionAndAppend(word: "donc", def: "therefore", type: .coordinating)
        createConjunctionAndAppend(word: "or", def: "yet", type: .coordinating)
        createConjunctionAndAppend(word: "ni", def: "nor", type: .coordinating)
        createConjunctionAndAppend(word: "car", def: "because", type: .coordinating)
    }
    
    
    mutating func createSomePrepositions(){
        createPrepositionAndAppend(word: "à", def: "to", type: .assignment)
        createPrepositionAndAppend(word: "de", def: "from", type: .assignment)
        createPrepositionAndAppend(word: "pour", def: "for", type: .assignment)
        createPrepositionAndAppend(word: "à côté de", def: "from", type: .assignment)
        createPrepositionAndAppend(word: "après", def: "after", type: .assignment)
        createPrepositionAndAppend(word: "avec", def: "with", type: .assignment)
        createPrepositionAndAppend(word: "dans", def: "in", type: .assignment)
        createPrepositionAndAppend(word: "depuis", def: "after", type: .assignment)
        createPrepositionAndAppend(word: "entre", def: "between", type: .assignment)
        createPrepositionAndAppend(word: "pendant", def: "during", type: .assignment)
        createPrepositionAndAppend(word: "sans", def: "without", type: .assignment)
        createPrepositionAndAppend(word: "sur", def: "on", type: .assignment)
    }
    
        mutating func createSomePronouns(){
        createPronounAndAppend(word: "je", def: "I", type: .SUBJECT)
        createPronounAndAppend(word: "moi", def: "me", type: .PREPOSITIONAL)
        createPronounAndAppend(word: "me", def: "me", type: .REFLEXIVE)
        createPronounAndAppend(word: "me", def: "me", type : .DIRECT_OBJECT)
    }
    
    /*
    mutating func createSomeNouns(){
        createNounAndAppend(word: "homme", def: "man", type: .person, gender: .masculine)
        createNounAndAppend(word: "femme", def: "woman", type: .person, gender: .feminine)
        createNounAndAppend(word: "marido", def: "husband", type: .person, gender: .masculine)
        createNounAndAppend(word: "esposa", def: "wife", type: .person, gender: .feminine)
        createNounAndAppend(word: "garçon", def: "boy", type: .person, gender: .masculine)
        createNounAndAppend(word: "fille", def: "girl", type: .person, gender: .feminine)
        createNounAndAppend(word: "père", def: "father", type: .person, gender: .masculine)
        createNounAndAppend(word: "mère", def: "mother", type: .person, gender: .feminine)
        createNounAndAppend(word: "ami", def: "friend", type: .person, gender: .masculine)
        
        createNounAndAppend(word: "livre", def: "book", type: .thing, gender: .masculine)
        createNounAndAppend(word: "page", def: "page", type: .thing, gender: .feminine)
        createNounAndAppend(word: "argent", def: "money", type: .thing, gender: .masculine)
        createNounAndAppend(word: "bateau", def: "boat", type: .thing, gender: .masculine)
        createNounAndAppend(word: "avion", def: "plane", type: .thing, gender: .masculine)
        createNounAndAppend(word: "pan", def: "bread", type: .thing, gender: .masculine)
        createNounAndAppend(word: "tableau", def: "table", type: .thing, gender: .masculine)
        createNounAndAppend(word: "table", def: "table", type: .thing, gender: .feminine)
        
        
        createNounAndAppend(word: "voiture", def: "car", type: .thing, gender: .masculine)
        createNounAndAppend(word: "téléphone", def: "money", type: .thing, gender: .masculine)
        createNounAndAppend(word: "carte de débit", def: "money", type: .thing, gender: .masculine)
        createNounAndAppend(word: "carte de crédit", def: "money", type: .thing, gender: .masculine)
    }
    */
    
    mutating func createSomeVerbsA(){
        /*
        var verb : RomanceVerb
        verb = FrenchVerb(bVerb: <#BFrenchVerb#>, word: "être", def: "be", type: .normal)
        verb.setSimplePresentForms(s1:"suis", s2:"es", s3:"est", p1:"sommes", p2:"êtes", p3:"sont")
        verbList.append(verb)
        verb = FrenchVerb(word: "avoir", def: "be", type: .normal)
        verb.setSimplePresentForms(s1:"ai", s2:"as", s3:"a", p1:"avons", p2:"avez", p3:"ont")
        verbList.append(verb)
        verb = FrenchVerb(word: "aimer", def: "love", type: .normal)
        verb.setSimplePresentForms(s1:"aime", s2:"aimes", s3:"aime", p1:"aimons", p2:"aimez", p3:"aiment")
        verbList.append(verb)
        verb = FrenchVerb(word: "placer", def: "put", type: .normal)
        verb.setSimplePresentForms(s1:"place", s2:"places", s3:"place", p1:"plaçons", p2:"placez", p3:"placent")
        verbList.append(verb)
        verb = FrenchVerb(word: "manger", def: "eat", type: .normal)
        verb.setSimplePresentForms(s1:"mange", s2:"manges", s3:"mange", p1:"mangeons", p2:"mangez", p3:"mangent")
        verbList.append(verb)
        verb = FrenchVerb(word: "peser", def: "weigh", type: .normal)
        verb.setSimplePresentForms(s1:"pèse", s2:"pèses", s3:"pèse", p1:"pesons", p2:"pesez", p3:"pèsent")
        verbList.append(verb)
        verb = FrenchVerb(word: "céder", def: "cede", type: .normal)
        verb.setSimplePresentForms(s1:"cède", s2:"cèdes", s3:"cède", p1:"cédons", p2:"cédez", p3:"cèdent")
        verbList.append(verb)
        verb = FrenchVerb(word: "jeter", def: "throw", type: .normal)
        verb.setSimplePresentForms(s1:"jette", s2:"jettes", s3:"jette", p1:"jetons", p2:"jetez", p3:"jettent")
        verbList.append(verb)
        verb = FrenchVerb(word: "mettre", def: "put", type: .normal)
        verb.setSimplePresentForms(s1:"mets", s2:"mets", s3:"met", p1:"mettons", p2:"mettez", p3:"mettent")
        verbList.append(verb)
 */
    }
    
    //  ç  è
    
    
   
    
    mutating func createAdjectiveAndAppend (word : String, def: String, type : AdjectiveType, position: AdjectivePositionType){
        let pos = FrenchAdjective(word: word, def: def, type: type)
        pos.setPreferredPosition(position: position)
        adjectiveList.append(pos)
    }
    
    mutating func createAdverbAndAppend (word : String, def: String, type : AdverbType){
        let pos = FrenchAdverb(word: word, def: def, type: type)
        adverbList.append(pos)
    }
    
    mutating func createAmbiguousAndAppend (word : String, def: String, type : AmbiguousType){
        let pos = Ambiguous(word: word, def: def, type: type)
        ambiguousList.append(pos)
    }
    
    mutating func createArticleAndAppend (word : String, def: String, type : ArticleType){
        let pos = FrenchArticle()
        articleList.append(pos)
    }
    
  
    mutating func createConjunctionAndAppend (word : String, def: String, type : ConjunctionType){
        let pos = FrenchConjunction(word: word, def: def, type: type)
        conjunctionList.append(pos)
    }
    
    
   mutating func createDeterminerAndAppend (word : String, def: String, type : DeterminerType, femWord:String, mascPlural:String, femPlural:String){
        let pos = RomanceDeterminer(word: word, def: def, type: type, femWord: femWord, mascPlural : mascPlural, femPlural : femPlural)
        determinerList.append(pos)
    }
    
    mutating func createPossessiveAdjectiveAndAppend(word: String, def: String, type: AdjectiveType){
        let pos = FrenchPossessiveAdjective(word: word, def: def, type: type)
        possessiveAdjectiveList.append(pos)
    }
    
    mutating func createDemonstrativeAdjectiveAndAppend(word: String, def: String, type: AdjectiveType){
        let pos = FrenchDemonstrativeAdjective(word: word, def: def, type: type)
        demonstrativeAdjectiveList.append(pos)
    }
    
    mutating func createInterrogativeAdjectiveAndAppend(word: String, def: String, type: AdjectiveType){
        let pos = FrenchInterrogativeAdjective(word: word, def: def, type: type)
        interrogativeAdjectiveList.append(pos)
    }
    
    mutating func createPronounAndAppend (word : String, def: String, type : PronounType){
        let pos = FrenchPronoun(word: word, def: def, type: type)
        pronounList.append(pos)
    }
    
    /*
    mutating func createNounAndAppend (word : String, def: String, type : NounType, gender: Gender){
        let pos = FrenchNoun(word: word, def: def, type: type, gender: gender )
        nounList.append(pos)
    }
    */
    mutating func createPrepositionAndAppend (word : String, def: String, type : PrepositionType){
        let pos = RomancePreposition(word: word, def: def, type: type)
        prepositionList.append(pos)
    }
    
    /*
    mutating func createVerbAndAppend (word : String, def: String, type : VerbType){
        let pos = RomanceVerb(word: word, def: def, type: type)
        verbList.append(pos)
    }
*/
    
}
