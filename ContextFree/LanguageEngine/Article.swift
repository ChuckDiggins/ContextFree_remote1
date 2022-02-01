//
//  ViperArticle.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 3/30/21.
//

import Foundation

public class Article : Word {
    var type: ArticleType
    
    public init(word: String, def: String, type : ArticleType){
        self.type = type
        super.init(word: word, wordType: .article)
    }
}

public class EnglishArticle : Article {
    let indefinitePreConsonsant = "a"
    let indefinitePreVowel = "an"
    let indefinitePlural = "some"
    let definite = "the"
    
    public func getIndefinite(number:Number, startingLetterIsVowelSound:Bool)->String{
        switch number{
        case .singular:
            if startingLetterIsVowelSound {return indefinitePreVowel}
            else { return indefinitePreVowel }
        case .plural:
            return indefinitePlural
        }
    }
    
    public func getDefinite()->String{
        return definite
    }
    
    public func isArticle(word: String)->(Bool, ArticleType, Number){
        
        //check for indefinite

        if word == getIndefinite(number: .singular, startingLetterIsVowelSound: false){return (true, .indefinite, .singular)}
        if word == indefinitePlural {return (true, .indefinite, .plural)}
        
        //check for definite
        
        if word == getDefinite() {return (true, .definite, .singular)}
        
        //else not an article
        return (false, .definite, .singular)
    }
}


public class RomanceArticle : Article {
    var indefiniteSingularMasc = ""
    var indefiniteSingularFem = ""
    var indefinitePluralMasc = ""
    var indefinitePluralFem = ""
        
    var definiteSingularMasc = ""
    var definiteSingularFem = ""
    var definitePluralMasc = ""
    var definitePluralFem = ""
       
    public func getArticle(type: ArticleType, gender: Gender, number: Number)->String{
        switch type {
        case .indefinite:
            return getIndefiniteForm(gender: gender, number: number)
        case .definite:
            return getDefiniteForm(gender: gender, number: number)
        case .unknown:
            return "unknown article type"
        case .partative:
            return ""
        }
    }
    
    public func getIndefiniteForm(gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return indefiniteSingularFem
            case .plural:
                return indefinitePluralFem
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return indefiniteSingularMasc
            case .plural:
                return indefinitePluralMasc
            }
        }
    }

    public func getDefiniteForm(gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return definiteSingularFem
            case .plural:
                return definitePluralFem
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return definiteSingularMasc
            case .plural:
                return definitePluralMasc
            }
        }
    }

    public func isArticle(word: String)->(Bool, ArticleType, gender : Gender, number : Number){

        if word == definiteSingularFem {return (true, .definite, .feminine, .singular)}
        if word == definitePluralFem {return (true, .definite, .feminine, .plural)}
        if word == definiteSingularMasc {return (true, .definite, .masculine, .singular)}
        if word == definitePluralMasc {return (true, .definite,.masculine, .plural)}
        
        if word == indefiniteSingularFem {return (true, .indefinite, .feminine, .singular)}
        if word == indefinitePluralFem {return (true, .indefinite,.feminine, .plural)}
        if word == indefiniteSingularMasc {return (true, .indefinite, .masculine, .singular)}
        if word == indefinitePluralMasc {return (true, .indefinite, .masculine, .plural)}

        return (false, .indefinite, .feminine, .plural)
    }
}


public class SpanishArticle : RomanceArticle {
    
    public init(){
        super.init(word: "", def: "", type: .unknown)
        
        indefiniteSingularMasc = "un"
        indefiniteSingularFem = "una"
        indefinitePluralMasc = "unos"
        indefinitePluralFem = "unas"
        
        definiteSingularMasc = "el"
        definiteSingularFem = "la"
        definitePluralMasc = "los"
        definitePluralFem = "las"
    }
}

public class FrenchArticle : RomanceArticle {
    var partativeSingularMasc = ""
    var partativeSingularFem = ""
    var partativePluralMasc = ""
    var partativePluralFem = ""
    
    public init(){
        super.init(word: "", def: "", type: .unknown)
        
        indefiniteSingularMasc = "un"
        indefiniteSingularFem = "une"
        indefinitePluralMasc = "des"
        indefinitePluralFem = "des"
        
        definiteSingularMasc = "le"
        definiteSingularFem = "la"
        definitePluralMasc = "les"
        definitePluralFem = "les"
        
        partativeSingularMasc = "du"
        partativeSingularFem = "de la"
        partativePluralMasc = "de l'"
        partativePluralFem = "des"
    }
    
    public func getPartativeForm(gender: Gender, number: Number)->String{
        switch gender {
        case .feminine:
            switch number {
            case .singular:
                return partativeSingularFem
            case .plural:
                return partativePluralFem
            }
        case .masculine, .either:
            switch number {
            case .singular:
                return partativeSingularMasc
            case .plural:
                return partativePluralMasc
            }
        }
    }
    
}
