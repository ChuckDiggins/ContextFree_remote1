//
//  SpanishWords.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/7/21.
//

import Foundation


struct SpanishWords {
    
    var adjectiveList = Array<Word>()
    var adverbList = Array<Word>()
    //var articleList = Array<Word>()
    var conjunctionList = Array<Word>()
    var determinerList = Array<Word>()
    var nounList = Array<Noun>()
    var prepositionList = Array<Word>()
    var verbList = Array<Word>()
    var pronounList = Array<Word>()
    var ambiguousList = Array<Word>()
    
    
    
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
    
    /*
    mutating func createSomeSpanishDeterminers(){
        createDeterminerAndAppend(word: "esto", def: "this", type: .definite, femWord: "esta", mascPlural: "estos", femPlural: "estas")
        createDeterminerAndAppend(word: "eso", def: "that", type: .definite, femWord: "esa", mascPlural: "esos", femPlural: "esas")
    }
    */
    
    /*
    mutating func createSomeAmbiguousWords(){
        createAmbiguousAndAppend(word: "", def: "", type: .general)
        createAmbiguousAndAppend(word: "", def: "", type: .pronoun)
    }
    */
    /*
    mutating func createSomeSpanishArticles(){
        createArticleAndAppend(word: "el", def: "the", type: .definite)
        createArticleAndAppend(word: "un", def: "a", type: .indefinite)
    }

    
    mutating func createSomeSpanishPronouns(){
        createPronounAndAppend(word: "yo", def: "I", type: .SUBJECT)
        createPronounAndAppend(word: "mí", def: "me", type: .PREPOSITIONAL)
        createPronounAndAppend(word: "me", def: "me", type: .REFLEXIVE)
        createPronounAndAppend(word: "me", def: "me", type: .DIRECT_OBJECT)
    }
    */

    /*
    mutating func createSomeAdverbs(){
        createAdverbAndAppend(word: "mas", def: "more", type: .comparing)
        createAdverbAndAppend(word: "menos", def: "less", type: .comparing)
    }
    */
    
    /*
    mutating func createSomeConjunctions(){
        createConjunctionAndAppend(word: "y", def: "and", type: .coordinating)
        createConjunctionAndAppend(word: "e", def: "and", type: .coordinating)
        createConjunctionAndAppend(word: "o", def: "or", type: .coordinating)
        createConjunctionAndAppend(word: "u", def: "or", type: .coordinating)
        
        createConjunctionAndAppend(word: "mas", def: "but", type: .contrasting)
        createConjunctionAndAppend(word: "pero", def: "but", type: .contrasting)
        createConjunctionAndAppend(word: "aunque", def: "however", type: .contrasting)
        createConjunctionAndAppend(word: "sin embargo", def: "however", type: .contrasting)
        createConjunctionAndAppend(word: "no obstante", def: "nevertheless", type: .contrasting)
        createConjunctionAndAppend(word: "por lo demás", def: "nevertheless", type: .contrasting)
        
        createConjunctionAndAppend(word: "es decir", def: "nevertheless", type: .explanatory)
        createConjunctionAndAppend(word: "esto es", def: "in other words", type: .explanatory)
        
        createConjunctionAndAppend(word: "porque", def: "because", type: .reason)
        createConjunctionAndAppend(word: "pues", def: "since", type: .reason)
        createConjunctionAndAppend(word: "puesto que", def: "because", type: .reason)
        
        createConjunctionAndAppend(word: "si", def: "if", type: .condition)
        createConjunctionAndAppend(word: "con tal de que", def: "as long as", type: .condition)
        createConjunctionAndAppend(word: "siempre que", def: "as long as", type: .condition)
        createConjunctionAndAppend(word: "ya que", def: "as long as", type: .condition)
        createConjunctionAndAppend(word: "para que", def: "as long as", type: .condition)
        createConjunctionAndAppend(word: "a fin de que", def: "as long as", type: .condition)
    }
    */
    /*
    mutating func createSomePrepositions(){
        createPrepositionAndAppend(word: "a", def: "to", type: .assignment)
        createPrepositionAndAppend(word: "con", def: "with", type: .assignment)
        createPrepositionAndAppend(word: "de", def: "of", type: .possessive)
        createPrepositionAndAppend(word: "para", def: "for", type: .assignment)
        createPrepositionAndAppend(word: "por", def: "for", type: .assignment)
        
        createPrepositionAndAppend(word: "sin", def: "without", type: .general)
        createPrepositionAndAppend(word: "contra", def: "against", type: .general)
        
        createPrepositionAndAppend(word: "en", def: "in", type: .spatial)
        createPrepositionAndAppend(word: "desde", def: "from", type: .spatial)
        createPrepositionAndAppend(word: "sobre", def: "over", type: .spatial)
        
        createPrepositionAndAppend(word: "durante", def: "during", type: .temporal)
        createPrepositionAndAppend(word: "antes", def: "before", type: .temporal)
        createPrepositionAndAppend(word: "después", def: "during", type: .temporal)
        
        //compound prepositions
        
        createPrepositionAndAppend(word: "por delante de", def: "opposite", type: .general)
        createPrepositionAndAppend(word: "delante de", def: "opposite", type: .general)
        //spatial
        createPrepositionAndAppend(word: "detrás de", def: "beneath", type: .spatial)
        createPrepositionAndAppend(word: "encima de", def: "on top", type: .spatial)
        createPrepositionAndAppend(word: "enfrente de", def: "in front of", type: .spatial)
        createPrepositionAndAppend(word: "a dentro de", def: "inside", type: .spatial)
        createPrepositionAndAppend(word: "dentro de", def: "inside", type: .spatial)
        createPrepositionAndAppend(word: "a fuera de", def: "outside", type: .spatial)
        createPrepositionAndAppend(word: "fuera de", def: "outside", type: .spatial)
        createPrepositionAndAppend(word: "alrededor de", def: "around", type: .spatial)
        createPrepositionAndAppend(word: "al lado de", def: "around", type: .spatial)
        createPrepositionAndAppend(word: "cerca de", def: "around", type: .spatial)
        createPrepositionAndAppend(word: "lejos de", def: "around", type: .spatial)
        //temporal
        createPrepositionAndAppend(word: "a principios de", def: "beginning", type: .temporal)
        createPrepositionAndAppend(word: "antes de", def: "before", type: .temporal)
        createPrepositionAndAppend(word: "después de", def: "after", type: .temporal)
        createPrepositionAndAppend(word: "a la hora de", def: "when it comes to", type: .temporal)
        createPrepositionAndAppend(word: "a eso de", def: "around", type: .temporal)
        createPrepositionAndAppend(word: "a punto de", def: "exactly", type: .temporal)
        createPrepositionAndAppend(word: "a partir de", def: "after", type: .temporal)
        createPrepositionAndAppend(word: "a lo largo de", def: "throughout the course of", type: .temporal)
        createPrepositionAndAppend(word: "luego de", def: "after", type: .temporal)
        //reason
        createPrepositionAndAppend(word: "a causa de", def: "because of", type: .general)
        createPrepositionAndAppend(word: "por causa de", def: "because of", type: .general)
        createPrepositionAndAppend(word: "debido a", def: "because of", type: .general)
        createPrepositionAndAppend(word: "a raíz a", def: "as a result of", type: .general)
        
        //general
        createPrepositionAndAppend(word: "de acuerdo con", def: "in accordance with", type: .general)
        createPrepositionAndAppend(word: "a causa de", def: "because of", type: .general)
        createPrepositionAndAppend(word: "a favor de", def: "in favor of", type: .general)
        createPrepositionAndAppend(word: "en contra de", def: "against", type: .general)
        createPrepositionAndAppend(word: "con respecto a", def: "regarding", type: .general)
        createPrepositionAndAppend(word: "en cuanto a", def: "as for", type: .general)
        createPrepositionAndAppend(word: "en busca de", def: "in search of", type: .general)
        createPrepositionAndAppend(word: "además de", def: "in addition to", type: .general)
        createPrepositionAndAppend(word: "a falta de", def: "in the absence of", type: .general)
        createPrepositionAndAppend(word: "a excepción de", def: "except for", type: .general)
        createPrepositionAndAppend(word: "en lugar de", def: "instead of", type: .general)
        createPrepositionAndAppend(word: "en vez de", def: "instead of", type: .general)
        createPrepositionAndAppend(word: "no obstante", def: "however", type: .general)
        createPrepositionAndAppend(word: "al pie de", def: "at the foot of", type: .general)
        
    }
    */
    /*
    mutating func createSomeAdjectives(){
        var adj : SpanishAdjective
        adj = SpanishAdjective(word: "rojo", def: "red", type: .color)
        adj.setPreferredPosition(position: .following)
        //var fem = adj.getForm(gender: .feminine, number: .plural)
        
        createAdjectiveAndAppend(word: "grande", def: "big", type: .size, position: .following)
        createAdjectiveAndAppend(word: "azul", def: "blue", type: .color, position: .following)
        createAdjectiveAndAppend(word: "negro", def: "black", type: .color, position: .following)
        
        createAdjectiveAndAppend(word: "pequeño", def: "small", type: .size, position: .following)
        createAdjectiveAndAppend(word: "quieto", def: "quiet", type: .size, position: .following)
        createAdjectiveAndAppend(word: "interesante", def: "small", type: .size, position: .following)
        createAdjectiveAndAppend(word: "divertido", def: "small", type: .size, position: .following)
        createAdjectiveAndAppend(word: "enojado", def: "small", type: .size, position: .following)
        createAdjectiveAndAppend(word: "cansado", def: "small", type: .size, position: .following)
        createAdjectiveAndAppend(word: "bonito", def: "pretty", type: .size, position: .following)
        createAdjectiveAndAppend(word: "encuerado", def: "naked", type: .size, position: .following)
        createAdjectiveAndAppend(word: "mojado", def: "wet", type: .size, position: .following)
        createAdjectiveAndAppend(word: "seco", def: "dry", type: .size, position: .following)
        createAdjectiveAndAppend(word: "frío", def: "cold", type: .size, position: .following) //4.5.4
        
        
        createAdjectiveAndAppend(word: "ambos", def: "both", type: .size, position: .preceding)
        createAdjectiveAndAppend(word: "llamado", def: "so-called", type: .condition, position: .preceding)
        createAdjectiveAndAppend(word: "mucho", def: "much", type: .size, position: .preceding)
        createAdjectiveAndAppend(word: "otro", def: "other", type: .size, position: .preceding)
        createAdjectiveAndAppend(word: "poco", def: "little", type: .size, position: .preceding)
        createAdjectiveAndAppend(word: "gran", def: "great", type: .size, position: .preceding)
        
        createAdjectiveAndAppend(word: "alguno", def: "some", type: .condition, position: .both)  //becomes "algún hombre" 4.1.5
        createAdjectiveAndAppend(word: "bueno", def: "good", type: .condition, position: .both)
        
    }
    */
    /*
    mutating func createSomeNouns(){
        createNounAndAppend(word: "agua", def: "water", type: .thing, gender: .feminine)
        createNounAndAppend(word: "casa", def: "house", type: .place, gender: .feminine)
        createNounAndAppend(word: "cerveza", def: "beer", type: .thing, gender: .feminine)
        createNounAndAppend(word: "computadora", def: "beer", type: .thing, gender: .feminine)
        createNounAndAppend(word: "puerta", def: "beer", type: .thing, gender: .feminine)
        createNounAndAppend(word: "ventana", def: "beer", type: .thing, gender: .feminine)
        createNounAndAppend(word: "universidad", def: "beer", type: .place, gender: .feminine)
        createNounAndAppend(word: "cerveza", def: "beer", type: .thing, gender: .feminine)
        createNounAndAppend(word: "hielo", def: "ice", type: .thing, gender: .masculine)
        createNounAndAppend(word: "hijo", def: "son", type: .person, gender: .masculine)
        createNounAndAppend(word: "hija", def: "daughter", type: .person, gender: .feminine)
        createNounAndAppend(word: "niño", def: "boy", type: .person, gender: .masculine)
        createNounAndAppend(word: "niña", def: "girl", type: .person, gender: .feminine)
        createNounAndAppend(word: "mujer", def: "woman", type: .person, gender: .feminine)
        createNounAndAppend(word: "profesora", def: "professor", type: .person, gender: .feminine)
        createNounAndAppend(word: "abuela", def: "grand mother", type: .person, gender: .feminine)
        createNounAndAppend(word: "vieja", def: "old person", type: .person, gender: .feminine)
        createNounAndAppend(word: "cientifica", def: "scientist", type: .person, gender: .feminine)
        createNounAndAppend(word: "madre", def: "mother", type: .person, gender: .feminine)
        createNounAndAppend(word: "padre", def: "father", type: .person, gender: .masculine)
        createNounAndAppend(word: "hombre", def: "man", type: .person, gender: .masculine)
        createNounAndAppend(word: "chico", def: "boy", type: .person, gender: .masculine)
        createNounAndAppend(word: "chica", def: "girl", type: .person, gender: .feminine)
        createNounAndAppend(word: "pollo", def: "chicken", type: .animal, gender: .masculine)
        createNounAndAppend(word: "gato", def: "cat", type: .animal, gender: .masculine)
        createNounAndAppend(word: "perro", def: "dog", type: .animal, gender: .masculine)
        createNounAndAppend(word: "lugar", def: "place", type: .place, gender: .masculine)
        createNounAndAppend(word: "cocina", def: "kitchen", type: .place, gender: .feminine)
        createNounAndAppend(word: "mesa", def: "table", type: .place, gender: .feminine)
        createNounAndAppend(word: "libro", def: "book", type: .thing, gender: .masculine)
        createNounAndAppend(word: "brazo", def: "arm", type: .any, gender: .masculine)
        createNounAndAppend(word: "ciudad", def: "city", type: .place, gender: .feminine)
        createNounAndAppend(word: "cama", def: "bed", type: .place, gender: .feminine)
        createNounAndAppend(word: "corazón", def: "heart", type: .any, gender: .feminine)
    }
*/
    /*
    mutating func createSomeVerbsA(){
        var verb : RomanceVerb
        verb = RomanceVerb(word: "vivir", def: "live", type: .normal)
        verb.setSimplePresentForms(s1:"vivo", s2:"vives", s3:"vive", p1:"vivimos", p2:"vivéis", p3:"viven")
        verbList.append(verb)
        verb = RomanceVerb(word: "estar", def: "to be", type: .normal)
        verb.setSimplePresentForms(s1:"estoy", s2:"estás", s3:"está", p1:"estamos", p2:"estáis", p3:"están")
        verbList.append(verb)
        verb = RomanceVerb(word: "ser", def: "to be", type: .normal)
        verb.setSimplePresentForms(s1:"soy", s2:"eres", s3:"es", p1:"somos", p2:"sois", p3:"son")
        verbList.append(verb)
        verb = RomanceVerb(word: "jugar",  def: "play", type: .normal)
        verb.setSimplePresentForms(s1:"juego", s2:"juegas", s3:"juega", p1:"jugamos", p2:"jugáis", p3:"juegan")
        verbList.append(verb)
        verb = RomanceVerb(word: "tener",  def: "have", type: .normal)
        verb.setSimplePresentForms(s1:"tengo", s2:"tienes", s3:"tiene", p1:"tenemos", p2:"tenéis", p3:"tienen")
        verbList.append(verb)
        verb = RomanceVerb(word: "acabar",  def: "begin", type: .normal)
        verb.setSimplePresentForms(s1:"acabo", s2:"acabas", s3:"acaba", p1:"acabamos", p2:"acabáis", p3:"acaban")
        verbList.append(verb)
        verb = RomanceVerb(word: "comprar",  def: "buy", type: .normal)
        verb.setSimplePresentForms(s1:"compro", s2:"compras", s3:"compra", p1:"compramos", p2:"compráis", p3:"compran")
        verbList.append(verb)
        verb = RomanceVerb(word: "bailar",  def: "dance", type: .normal)
        verb.setSimplePresentForms(s1:"bailo", s2:"bailas", s3:"baila", p1:"bailamos", p2:"bailáis", p3:"bailan")
        verbList.append(verb)
        verb = RomanceVerb(word: "creer",  def: "believe", type: .normal)
        verb.setSimplePresentForms(s1:"creo", s2:"crees", s3:"cree", p1:"creemos", p2:"creéis", p3:"creen")
        verbList.append(verb)
        
    }
    */
  
    /*
      
    mutating func createAdjectiveAndAppend (word : String, def: String, type : AdjectiveType, position: AdjectivePositionType){
        let pos = SpanishAdjective(word: word, type: type)
        pos.setPreferredPosition(position: position)
        adjectiveList.append(pos)
    }
    
    mutating func createAdverbAndAppend (word : String, def: String, type : AdverbType){
        let pos = SpanishAdverb(word: word, type: type)
        adverbList.append(pos)
    }
    
    mutating func createAmbiguousAndAppend (word : String, def: String, type : AmbiguousType){
        let pos = Ambiguous(word: word, type: type)
        ambiguousList.append(pos)
    }
    
    /*
    mutating func createArticleAndAppend (word : String, def: String, type : ArticleType){
        let pos = SpanishArticle()
        //articleList.append(pos)
    }
    */
    
  
    mutating func createConjunctionAndAppend (word : String, type : ConjunctionType){
        let pos = SpanishConjunction(word: word, type: type)
        conjunctionList.append(pos)
    }
    
    
   mutating func createDeterminerAndAppend (word : String,  type : DeterminerType, femWord:String, mascPlural:String, femPlural:String){
        let pos = RomanceDeterminer(word: word, type: type, femWord: femWord, mascPlural : mascPlural, femPlural : femPlural)
        determinerList.append(pos)
    }
    
    mutating func createPronounAndAppend (word : String, type : PronounType){
        let pos = SpanishPronoun(word: word, type: type)
        pronounList.append(pos)
    }
    
    mutating func createNounAndAppend (word : String, type : NounType, gender: Gender){
        let pos = RomanceNoun(word: word, type: type, gender: gender )
        nounList.append(pos)
    }
    
    mutating func createPrepositionAndAppend (word : String,  type : PrepositionType){
        let pos = RomancePreposition(word: word, type: type)
        prepositionList.append(pos)
    }
    /*
    mutating func createVerbAndAppend (word : String, def: String, type : VerbType){
        let pos = RomanceVerb(word: word, def: def, type: type)
        verbList.append(pos)
    }
    */
   
*/
    
}
