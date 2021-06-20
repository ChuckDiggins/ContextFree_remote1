//
//  EnglishCreateVerbModel.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/16/21.
//

import Foundation

struct EnglishVerbModel : Identifiable{
    let id : Int
    let infinitive: String
    let preterite: String
    let pastPart: String
    
    init(id: Int, infinitive: String, preterite: String, pastPart: String){
        self.id = id
        self.infinitive = infinitive
        self.preterite = preterite
        self.pastPart = pastPart
    }
    
    init(){
        id = 0
        infinitive = ""
        preterite = ""
        pastPart = ""
    }
    
    func isModelFor(verbWord: String)->Bool{
        if verbWord == infinitive { return true}
        return false
    }
}

func createEnglishVerbModels()->[EnglishVerbModel]{
    
//    //setVerbModelList(verbModelList: verbModels)
    
    var verbModelList = [EnglishVerbModel]()
    
    //this first because it's standalone
    
    // id = 0 is reserved for the verb "to be"
    var id = 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "be", preterite: "was", pastPart: "been")); id += 1  
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "arise", preterite: "arose", pastPart: "arisen")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "awake", preterite: "awoke", pastPart: "awoken")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "awake", preterite: "awaked", pastPart: "awaked")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "beat",  preterite: "beat", pastPart: "beaten")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "become", preterite: "became", pastPart: "become")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "begin", preterite: "began", pastPart: "begun")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bend", preterite: "bent", pastPart: "bent")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bet", preterite: "bet", pastPart: "bet")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bet", preterite: "betted", pastPart: "betted")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bid", preterite: "bid", pastPart: "bid")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bleed", preterite: "bled", pastPart: "bled")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "blow", preterite: "blew", pastPart: "blown")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "break", preterite: "broke", pastPart: "broken")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "breed", preterite: "bred", pastPart: "bred")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bring", preterite: "brought", pastPart: "brought")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "build", preterite: "built", pastPart: "built")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "burn", preterite: "burned", pastPart: "burned")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "burst", preterite: "burst", pastPart: "burst")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "buy", preterite: "bought", pastPart: "bought")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "can", preterite: "could", pastPart: "no PP")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "cast", preterite: "cast", pastPart: "cast")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "catch", preterite: "caught", pastPart: "caught")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "chide", preterite: "chided", pastPart: "chided")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "choose", preterite: "chose", pastPart: "chosen")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "come", preterite: "came", pastPart: "come")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "cost", preterite: "cost", pastPart: "cost")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "cut", preterite: "cut", pastPart: "cut")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "do", preterite: "did", pastPart: "done")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "draw", preterite: "drew", pastPart: "drawn")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "dream", preterite: "dreamt", pastPart: "dreamt")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "drink", preterite: "drank", pastPart: "drunk")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "drive", preterite: "drove", pastPart: "driven")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "eat", preterite: "ate", pastPart: "eaten")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "drink", preterite: "drank", pastPart: "drunk")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "drive", preterite: "drove", pastPart: "driven")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "eat", preterite: "ate", pastPart: "eaten")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "fall", preterite: "fell", pastPart: "fallen")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "feel", preterite: "felt", pastPart: "felt")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "fight", preterite: "fought", pastPart: "fought")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "find", preterite: "found", pastPart: "found")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "fly", preterite: "flew", pastPart: "flown")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "forbid", preterite: "forbade", pastPart: "forbidden")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "forget", preterite: "forgot", pastPart: "forgotten")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "forgive", preterite: "forgave", pastPart: "forgiven")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "get", preterite: "got", pastPart: "got")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "give", preterite: "gave", pastPart: "given")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "go", preterite: "went", pastPart: "gone")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "grow", preterite: "grew", pastPart: "grown")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "have", preterite: "had", pastPart: "had")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hear", preterite: "heard", pastPart: "heard")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hide", preterite: "hid", pastPart: "hidden")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hold", preterite: "held", pastPart: "held")); id += 1
    
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hurt", preterite: "hurt", pastPart: "hurt")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "keep", preterite: "kept", pastPart: "kept")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "know", preterite: "knew", pastPart: "known")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "learn", preterite: "learned", pastPart: "learned")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "leave", preterite: "left", pastPart: "left")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "lie", preterite: "lay", pastPart: "lain")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "lose", preterite: "lost", pastPart: "lost")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "make", preterite: "made", pastPart: "made")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "mean", preterite: "meant", pastPart: "meant")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "meet", preterite: "met", pastPart: "met")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "pay", preterite: "paid", pastPart: "paid")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "put", preterite: "put", pastPart: "put")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "read", preterite: "read", pastPart: "read")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "ride", preterite: "rode", pastPart: "ridden")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "run", preterite: "ran", pastPart: "run")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "say", preterite: "said", pastPart: "said")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "see", preterite: "saw", pastPart: "seen")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "sell", preterite: "sold", pastPart: "sold")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "send", preterite: "sent", pastPart: "sent")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "show", preterite: "showed", pastPart: "shown")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "sing", preterite: "sang", pastPart: "sung")); id += 1
    
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "sleep", preterite: "slept", pastPart: "slept")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "speak", preterite: "spoke", pastPart: "spoken")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "spell", preterite: "spelled", pastPart: "spelled")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "stand", preterite: "stood", pastPart: "stood")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "steal", preterite: "stole", pastPart: "stolen")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "swim", preterite: "swam", pastPart: "swum")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "take", preterite: "took", pastPart: "taken")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "teach", preterite: "taught", pastPart: "taught")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "think", preterite: "thought", pastPart: "thought")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "throw", preterite: "threw", pastPart: "thrown")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "wake", preterite: "woke", pastPart: "waked")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "wear", preterite: "wore", pastPart: "worn")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "win", preterite: "won", pastPart: "won")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "write", preterite: "wrote", pastPart: "wrote")); id += 1
    
    print("English verb model count = \(verbModelList.count)")
    
    return verbModelList
}


