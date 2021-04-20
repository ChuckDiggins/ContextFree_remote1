//
//  SpanishWords.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation

struct SpanishWords{
    
    var spanishAdjectiveList = Array<Word>()
    var spanishAdverbList = Array<Word>()
    var spanishArticleList = Array<Word>()
    var spanishConjunctionList = Array<Word>()
    var spanishDeterminerList = Array<Word>()
    var spanishNounList = Array<Noun>()
    var spanishPrepositionList = Array<Word>()
    var spanishVerbList = Array<Word>()
    var spanishPronounList = Array<Word>()
    
    func isContraction(word: String)->(Bool, String, String){
        if word == "al" {return (true, "a", "el")}
        if word == "del" {return (true, "de", "el")}
        if word == "conmigo" {return (true, "con", "mí")}
        if word == "contigo" {return (true, "con", "tú")}
        if word == "consigo" {return (true, "con", "él")}
        return (false, "", "")
    }
    
    func createContraction(word1: String, word2: String)->String{
        if word1 == "a" && word2 == "el" {return "al"}
        if word1 == "de" && word2 == "el" {return "del"}
        if word1 == "con" && word2 == "mí" {return "conmigo"}
        if word1 == "con" && word2 == "tú" {return "contigo"}
        if word1 == "con" && word2 == "él" {return "consigo"}
        if word1 == "con" && word2 == "ella" {return "consigo"}
        if word1 == "con" && word2 == "ellos" {return "consigo"}
        if word1 == "con" && word2 == "ellas" {return "consigo"}
        return ""
    }
    
    mutating func createSomeSpanishDeterminers(){
        createRomanceDeterminerAndAppend(word: "esto", def: "this", type: .definite, femWord: "esta", mascPlural: "estos", femPlural: "estas")
        createRomanceDeterminerAndAppend(word: "eso", def: "that", type: .definite, femWord: "esa", mascPlural: "esos", femPlural: "esas")
    }
    
    mutating func createSomeSpanishArticles(){
        createRomanceArticleAndAppend(word: "el", def: "the", type: .definite)
        createRomanceArticleAndAppend(word: "un", def: "a", type: .indefinite)
    }
    
    mutating func createSomeSpanishPronouns(){
        createSpanishPronounAndAppend(word: "yo", def: "I", type: .SUBJECT)
        createSpanishPronounAndAppend(word: "mí", def: "me", type: .PREPOSITIONAL)
        createSpanishPronounAndAppend(word: "me", def: "me", type: .REFLEXIVE)
        createSpanishPronounAndAppend(word: "me", def: "me", type: .OBJECT)
    }
    
    
    /*
    enum PrepositionType
    {
        case spatial        //behind, around, between, inside, etc.
        case temporal      //after, before, until, during
        case possessive    //of
        case assignment   //to, for, with, from
        case general     //about, without
    }
*/
    
    mutating func createSomeSpanishAdverbs(){
        createSpanishAdverbAndAppend(word: "mas", def: "more", type: .comparing)
        createSpanishAdverbAndAppend(word: "menos", def: "less", type: .comparing)
    }
    
    mutating func createSomeSpanishConjunctions(){
        createSpanishConjunctionAndAppend(word: "y", def: "and", type: .coordinating)
        createSpanishConjunctionAndAppend(word: "e", def: "and", type: .coordinating)
        createSpanishConjunctionAndAppend(word: "o", def: "or", type: .coordinating)
        createSpanishConjunctionAndAppend(word: "u", def: "or", type: .coordinating)
        
        createSpanishConjunctionAndAppend(word: "mas", def: "but", type: .contrasting)
        createSpanishConjunctionAndAppend(word: "pero", def: "but", type: .contrasting)
        createSpanishConjunctionAndAppend(word: "aunque", def: "however", type: .contrasting)
        createSpanishConjunctionAndAppend(word: "sin embargo", def: "however", type: .contrasting)
        createSpanishConjunctionAndAppend(word: "no obstante", def: "nevertheless", type: .contrasting)
        createSpanishConjunctionAndAppend(word: "por lo demás", def: "nevertheless", type: .contrasting)
        
        createSpanishConjunctionAndAppend(word: "es decir", def: "nevertheless", type: .explanatory)
        createSpanishConjunctionAndAppend(word: "esto es", def: "in other words", type: .explanatory)
        
        createSpanishConjunctionAndAppend(word: "porque", def: "because", type: .reason)
        createSpanishConjunctionAndAppend(word: "pues", def: "since", type: .reason)
        createSpanishConjunctionAndAppend(word: "puesto que", def: "because", type: .reason)
        
        createSpanishConjunctionAndAppend(word: "si", def: "if", type: .condition)
        createSpanishConjunctionAndAppend(word: "con tal de que", def: "as long as", type: .condition)
        createSpanishConjunctionAndAppend(word: "siempre que", def: "as long as", type: .condition)
        createSpanishConjunctionAndAppend(word: "ya que", def: "as long as", type: .condition)
        createSpanishConjunctionAndAppend(word: "para que", def: "as long as", type: .condition)
        createSpanishConjunctionAndAppend(word: "a fin de que", def: "as long as", type: .condition)
    }
    
    mutating func createSomeSpanishPrepositions(){
        createRomancePrepositionAndAppend(word: "a", def: "to", type: .assignment)
        createRomancePrepositionAndAppend(word: "con", def: "with", type: .assignment)
        createRomancePrepositionAndAppend(word: "de", def: "of", type: .possessive)
        createRomancePrepositionAndAppend(word: "para", def: "for", type: .assignment)
        createRomancePrepositionAndAppend(word: "por", def: "for", type: .assignment)
        
        createRomancePrepositionAndAppend(word: "sin", def: "without", type: .general)
        createRomancePrepositionAndAppend(word: "contra", def: "against", type: .general)
        
        createRomancePrepositionAndAppend(word: "en", def: "in", type: .spatial)
        createRomancePrepositionAndAppend(word: "desde", def: "from", type: .spatial)
        createRomancePrepositionAndAppend(word: "sobre", def: "over", type: .spatial)
        
        createRomancePrepositionAndAppend(word: "durante", def: "during", type: .temporal)
        createRomancePrepositionAndAppend(word: "antes", def: "before", type: .temporal)
        createRomancePrepositionAndAppend(word: "después", def: "during", type: .temporal)
        
        //compound prepositions
        
        createRomancePrepositionAndAppend(word: "por delante de", def: "opposite", type: .general)
        createRomancePrepositionAndAppend(word: "delante de", def: "opposite", type: .general)
        //spatial
        createRomancePrepositionAndAppend(word: "detrás de", def: "beneath", type: .spatial)
        createRomancePrepositionAndAppend(word: "encima de", def: "on top", type: .spatial)
        createRomancePrepositionAndAppend(word: "enfrente de", def: "in front of", type: .spatial)
        createRomancePrepositionAndAppend(word: "a dentro de", def: "inside", type: .spatial)
        createRomancePrepositionAndAppend(word: "dentro de", def: "inside", type: .spatial)
        createRomancePrepositionAndAppend(word: "a fuera de", def: "outside", type: .spatial)
        createRomancePrepositionAndAppend(word: "fuera de", def: "outside", type: .spatial)
        createRomancePrepositionAndAppend(word: "alrededor de", def: "around", type: .spatial)
        createRomancePrepositionAndAppend(word: "al lado de", def: "around", type: .spatial)
        createRomancePrepositionAndAppend(word: "cerca de", def: "around", type: .spatial)
        createRomancePrepositionAndAppend(word: "lejos de", def: "around", type: .spatial)
        //temporal
        createRomancePrepositionAndAppend(word: "a principios de", def: "beginning", type: .temporal)
        createRomancePrepositionAndAppend(word: "antes de", def: "before", type: .temporal)
        createRomancePrepositionAndAppend(word: "después de", def: "after", type: .temporal)
        createRomancePrepositionAndAppend(word: "a la hora de", def: "when it comes to", type: .temporal)
        createRomancePrepositionAndAppend(word: "a eso de", def: "around", type: .temporal)
        createRomancePrepositionAndAppend(word: "a punto de", def: "exactly", type: .temporal)
        createRomancePrepositionAndAppend(word: "a partir de", def: "after", type: .temporal)
        createRomancePrepositionAndAppend(word: "a lo largo de", def: "throughout the course of", type: .temporal)
        createRomancePrepositionAndAppend(word: "luego de", def: "after", type: .temporal)
        //reason
        createRomancePrepositionAndAppend(word: "a causa de", def: "because of", type: .general)
        createRomancePrepositionAndAppend(word: "por causa de", def: "because of", type: .general)
        createRomancePrepositionAndAppend(word: "debido a", def: "because of", type: .general)
        createRomancePrepositionAndAppend(word: "a raíz a", def: "as a result of", type: .general)
        
        //general
        createRomancePrepositionAndAppend(word: "de acuerdo con", def: "in accordance with", type: .general)
        createRomancePrepositionAndAppend(word: "a causa de", def: "because of", type: .general)
        createRomancePrepositionAndAppend(word: "a favor de", def: "in favor of", type: .general)
        createRomancePrepositionAndAppend(word: "en contra de", def: "against", type: .general)
        createRomancePrepositionAndAppend(word: "con respecto a", def: "regarding", type: .general)
        createRomancePrepositionAndAppend(word: "en cuanto a", def: "as for", type: .general)
        createRomancePrepositionAndAppend(word: "en busca de", def: "in search of", type: .general)
        createRomancePrepositionAndAppend(word: "además de", def: "in addition to", type: .general)
        createRomancePrepositionAndAppend(word: "a falta de", def: "in the absence of", type: .general)
        createRomancePrepositionAndAppend(word: "a excepción de", def: "except for", type: .general)
        createRomancePrepositionAndAppend(word: "en lugar de", def: "instead of", type: .general)
        createRomancePrepositionAndAppend(word: "en vez de", def: "instead of", type: .general)
        createRomancePrepositionAndAppend(word: "no obstante", def: "however", type: .general)
        createRomancePrepositionAndAppend(word: "al pie de", def: "at the foot of", type: .general)
        
    }
    
    mutating func createSomeSpanishAdjectives(){
        var adj : SpanishAdjective
        adj = SpanishAdjective(word: "rojo", def: "red", type: .color)
        adj.setPreferredPosition(position: .following)
        //var fem = adj.getForm(gender: .feminine, number: .plural)
        
        createSpanishAdjectiveAndAppend(word: "grande", def: "big", type: .size, position: .following)
        createSpanishAdjectiveAndAppend(word: "azul", def: "blue", type: .color, position: .following)
        createSpanishAdjectiveAndAppend(word: "negro", def: "black", type: .color, position: .following)
        
        createSpanishAdjectiveAndAppend(word: "pequeño", def: "small", type: .size, position: .following)
        createSpanishAdjectiveAndAppend(word: "pequeño", def: "slight", type: .size, position: .preceding) //4.5.4
        createSpanishAdjectiveAndAppend(word: "ambos", def: "both", type: .size, position: .preceding)
        createSpanishAdjectiveAndAppend(word: "llamado", def: "so-called", type: .condition, position: .preceding)
        createSpanishAdjectiveAndAppend(word: "mucho", def: "much", type: .size, position: .preceding)
        createSpanishAdjectiveAndAppend(word: "otro", def: "other", type: .size, position: .preceding)
        createSpanishAdjectiveAndAppend(word: "poco", def: "little", type: .size, position: .preceding)
        createSpanishAdjectiveAndAppend(word: "gran", def: "great", type: .size, position: .preceding)
        
        createSpanishAdjectiveAndAppend(word: "alguno", def: "some", type: .condition, position: .precedingMasc)  //becomes "algún hombre" 4.1.5
        createSpanishAdjectiveAndAppend(word: "bueno", def: "good", type: .condition, position: .precedingMasc)
        
    }
    
    mutating func createSomeSpanishNouns(){
        createRomanceNounAndAppend(word: "agua", def: "water", type: .thing, gender: .feminine)
        createRomanceNounAndAppend(word: "casa", def: "house", type: .place, gender: .feminine)
        createRomanceNounAndAppend(word: "cerveza", def: "beer", type: .thing, gender: .feminine)
        createRomanceNounAndAppend(word: "hielo", def: "ice", type: .thing, gender: .feminine)
        createRomanceNounAndAppend(word: "hijo", def: "son", type: .person, gender: .masculine)
        createRomanceNounAndAppend(word: "hija", def: "daughter", type: .person, gender: .feminine)
        createRomanceNounAndAppend(word: "niño", def: "boy", type: .person, gender: .masculine)
        createRomanceNounAndAppend(word: "niño", def: "boy", type: .person, gender: .masculine)
        createRomanceNounAndAppend(word: "niña", def: "girl", type: .person, gender: .masculine)
        createRomanceNounAndAppend(word: "mujer", def: "woman", type: .person, gender: .feminine)
        createRomanceNounAndAppend(word: "madre", def: "mother", type: .person, gender: .feminine)
        createRomanceNounAndAppend(word: "padre", def: "father", type: .person, gender: .feminine)
        createRomanceNounAndAppend(word: "hombre", def: "man", type: .person, gender: .masculine)
        createRomanceNounAndAppend(word: "chico", def: "boy", type: .person, gender: .masculine)
        createRomanceNounAndAppend(word: "chica", def: "girl", type: .person, gender: .masculine)
        
        createRomanceNounAndAppend(word: "pollo", def: "chicken", type: .animal, gender: .masculine)
        createRomanceNounAndAppend(word: "gato", def: "cat", type: .animal, gender: .masculine)
        createRomanceNounAndAppend(word: "perro", def: "dog", type: .animal, gender: .masculine)
        createRomanceNounAndAppend(word: "lugar", def: "place", type: .place, gender: .masculine)
        createRomanceNounAndAppend(word: "cocina", def: "kitchen", type: .place, gender: .feminine)
        createRomanceNounAndAppend(word: "mesa", def: "table", type: .place, gender: .feminine)
        createRomanceNounAndAppend(word: "libro", def: "book", type: .thing, gender: .masculine)
        createRomanceNounAndAppend(word: "brazo", def: "arm", type: .bodyPart, gender: .masculine)
        createRomanceNounAndAppend(word: "ciudad", def: "city", type: .place, gender: .feminine)
        createRomanceNounAndAppend(word: "cama", def: "bed", type: .place, gender: .feminine)
        createRomanceNounAndAppend(word: "corazón", def: "heart", type: .bodyPart, gender: .feminine)
    }
    
    mutating func createSomeSpanishVerbs(){
        var verb : RomanceVerb
        verb = RomanceVerb(word: "vivir", def: "live", type: .intransitive)
        verb.setSimplePresentForms(s1:"vivo", s2:"vives", s3:"vive", p1:"vivimos", p2:"vivéis", p3:"viven")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "estar", def: "to be", type: .intransitive)
        verb.setSimplePresentForms(s1:"estoy", s2:"estás", s3:"está", p1:"estamos", p2:"estáis", p3:"están")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "ser", def: "to be", type: .intransitive)
        verb.setSimplePresentForms(s1:"soy", s2:"eres", s3:"es", p1:"somos", p2:"sois", p3:"son")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "jugar",  def: "play", type: .transitive)
        verb.setSimplePresentForms(s1:"juego", s2:"juegas", s3:"juega", p1:"jugamos", p2:"jugáis", p3:"juegan")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "tener",  def: "have", type: .transitive)
        verb.setSimplePresentForms(s1:"tengo", s2:"tienes", s3:"tiene", p1:"tenemos", p2:"tenéis", p3:"tienen")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "acabar",  def: "begin", type: .transitive)
        verb.setSimplePresentForms(s1:"acabo", s2:"acabas", s3:"acaba", p1:"acabamos", p2:"acabáis", p3:"acaban")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "comprar",  def: "buy", type: .transitive)
        verb.setSimplePresentForms(s1:"compro", s2:"compras", s3:"compra", p1:"compramos", p2:"compráis", p3:"compran")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "bailar",  def: "dance", type: .intransitive)
        verb.setSimplePresentForms(s1:"bailo", s2:"bailas", s3:"baila", p1:"bailamos", p2:"bailáis", p3:"bailan")
        spanishVerbList.append(verb)
        verb = RomanceVerb(word: "creer",  def: "believe", type: .transitive)
        verb.setSimplePresentForms(s1:"creo", s2:"crees", s3:"cree", p1:"creemos", p2:"creéis", p3:"creen")
        spanishVerbList.append(verb)
        
    }
    
  
      
    mutating func createSpanishAdjectiveAndAppend (word : String, def: String, type : AdjectiveType, position: AdjectivePositionType){
        let pos = SpanishAdjective(word: word, def: def, type: type)
        pos.setPreferredPosition(position: position)
        spanishAdjectiveList.append(pos)
    }
    
    mutating func createSpanishAdverbAndAppend (word : String, def: String, type : AdverbType){
        let pos = SpanishAdverb(word: word, def: def, type: type)
        spanishAdverbList.append(pos)
    }
    
    mutating func createRomanceArticleAndAppend (word : String, def: String, type : ArticleType){
        let pos = RomanceArticle(word: word, def: def, type: type)
        spanishArticleList.append(pos)
    }
    
  
    mutating func createSpanishConjunctionAndAppend (word : String, def: String, type : ConjunctionType){
        let pos = SpanishConjunction(word: word, def: def, type: type)
        spanishConjunctionList.append(pos)
    }
    
    
   mutating func createRomanceDeterminerAndAppend (word : String, def: String, type : DeterminerType, femWord:String, mascPlural:String, femPlural:String){
        let pos = RomanceDeterminer(word: word, def: def, type: type, femWord: femWord, mascPlural : mascPlural, femPlural : femPlural)
        spanishDeterminerList.append(pos)
    }
    
    mutating func createSpanishPronounAndAppend (word : String, def: String, type : PronounType){
        let pos = SpanishPronoun(word: word, def: def, type: type)
        spanishPronounList.append(pos)
    }
    
    mutating func createRomanceNounAndAppend (word : String, def: String, type : NounType, gender: Gender){
        let pos = RomanceNoun(word: word, def: def, type: type, gender: gender )
        spanishNounList.append(pos)
    }
    
    mutating func createRomancePrepositionAndAppend (word : String, def: String, type : PrepositionType){
        let pos = RomancePreposition(word: word, def: def, type: type)
        spanishPrepositionList.append(pos)
    }
    
    mutating func createRomanceVerbAndAppend (word : String, def: String, type : VerbType){
        let pos = RomanceVerb(word: word, def: def, type: type)
        spanishVerbList.append(pos)
    }
    
   

    
}
