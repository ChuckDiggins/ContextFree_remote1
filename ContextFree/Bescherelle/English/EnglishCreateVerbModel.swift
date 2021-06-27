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
    let gerund: String
    
    init(id: Int, infinitive: String, preterite: String, pastPart: String, gerund: String){
        self.id = id
        self.infinitive = infinitive
        self.preterite = preterite
        self.pastPart = pastPart
        self.gerund = gerund
    }
    
    init(){
        id = 0
        infinitive = ""
        preterite = ""
        pastPart = ""
        gerund = ""
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
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "be", preterite: "was", pastPart: "been", gerund : "being")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "arise", preterite: "arose", pastPart: "arisen", gerund : "arising")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "awake", preterite: "awoke", pastPart: "awoken", gerund : "awaking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "awake", preterite: "awaked", pastPart: "awaked", gerund : "awaking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "beat",  preterite: "beat", pastPart: "beaten", gerund : "beating")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "become", preterite: "became", pastPart: "become", gerund : "becoming")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "begin", preterite: "began", pastPart: "begun", gerund : "beginning")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bend", preterite: "bent", pastPart: "bent", gerund : "bending")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bet", preterite: "bet", pastPart: "bet", gerund : "betting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bet", preterite: "betted", pastPart: "betted", gerund : "betting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bid", preterite: "bid", pastPart: "bid", gerund : "bidding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bleed", preterite: "bled", pastPart: "bled", gerund : "bleeding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "blow", preterite: "blew", pastPart: "blown", gerund : "blowing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "break", preterite: "broke", pastPart: "broken", gerund : "breaking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "breed", preterite: "bred", pastPart: "bred", gerund : "breeding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "bring", preterite: "brought", pastPart: "brought", gerund : "bringing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "build", preterite: "built", pastPart: "built", gerund : "building")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "burn", preterite: "burned", pastPart: "burned", gerund : "burning")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "burst", preterite: "burst", pastPart: "burst", gerund : "bursting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "buy", preterite: "bought", pastPart: "bought", gerund : "buying")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "can", preterite: "could", pastPart: "no PP", gerund : "...")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "cast", preterite: "cast", pastPart: "cast", gerund : "casting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "catch", preterite: "caught", pastPart: "caught", gerund : "catching")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "chide", preterite: "chided", pastPart: "chided", gerund : "chiding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "choose", preterite: "chose", pastPart: "chosen", gerund : "choosing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "come", preterite: "came", pastPart: "come", gerund : "coming")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "cost", preterite: "cost", pastPart: "cost", gerund : "costing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "cut", preterite: "cut", pastPart: "cut", gerund : "cutting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "do", preterite: "did", pastPart: "done", gerund : "doing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "draw", preterite: "drew", pastPart: "drawn", gerund : "drawing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "dream", preterite: "dreamt", pastPart: "dreamt", gerund : "dreaming")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "drink", preterite: "drank", pastPart: "drunk", gerund : "drinking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "drive", preterite: "drove", pastPart: "driven", gerund : "driving")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "eat", preterite: "ate", pastPart: "eaten", gerund : "eating")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "fall", preterite: "fell", pastPart: "fallen", gerund : "falling")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "feel", preterite: "felt", pastPart: "felt", gerund : "feeling")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "fight", preterite: "fought", pastPart: "fought", gerund : "fighting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "find", preterite: "found", pastPart: "found", gerund : "finding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "fly", preterite: "flew", pastPart: "flown", gerund : "flying")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "forbid", preterite: "forbade", pastPart: "forbidden", gerund : "forbidding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "forget", preterite: "forgot", pastPart: "forgotten", gerund : "forgetting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "forgive", preterite: "forgave", pastPart: "forgiven", gerund : "forgiving")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "get", preterite: "got", pastPart: "got", gerund : "getting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "give", preterite: "gave", pastPart: "given", gerund : "giving")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "go", preterite: "went", pastPart: "gone", gerund : "going")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "grow", preterite: "grew", pastPart: "grown", gerund : "growing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "have", preterite: "had", pastPart: "had", gerund : "having")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hear", preterite: "heard", pastPart: "heard", gerund : "hearing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hide", preterite: "hid", pastPart: "hidden", gerund : "hiding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hold", preterite: "held", pastPart: "held", gerund : "holding")); id += 1
    
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "hurt", preterite: "hurt", pastPart: "hurt", gerund : "hurting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "keep", preterite: "kept", pastPart: "kept", gerund : "keeping")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "know", preterite: "knew", pastPart: "known", gerund : "knowing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "learn", preterite: "learned", pastPart: "learned", gerund : "learning")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "leave", preterite: "left", pastPart: "left", gerund : "leaving")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "lie", preterite: "lay", pastPart: "lain", gerund : "lying")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "lose", preterite: "lost", pastPart: "lost", gerund : "losing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "make", preterite: "made", pastPart: "made", gerund : "making")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "mean", preterite: "meant", pastPart: "meant", gerund : "meaning")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "meet", preterite: "met", pastPart: "met", gerund : "meeting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "pay", preterite: "paid", pastPart: "paid", gerund : "paying")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "put", preterite: "put", pastPart: "put", gerund : "putting")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "read", preterite: "read", pastPart: "read", gerund : "reading")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "ride", preterite: "rode", pastPart: "ridden", gerund : "riding")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "run", preterite: "ran", pastPart: "run", gerund : "running")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "say", preterite: "said", pastPart: "said", gerund : "saying")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "see", preterite: "saw", pastPart: "seen", gerund : "seeing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "sell", preterite: "sold", pastPart: "sold", gerund : "selling")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "send", preterite: "sent", pastPart: "sent", gerund : "sending")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "show", preterite: "showed", pastPart: "shown", gerund : "showing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "sing", preterite: "sang", pastPart: "sung", gerund : "singing")); id += 1
    
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "sleep", preterite: "slept", pastPart: "slept", gerund : "sleeping")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "speak", preterite: "spoke", pastPart: "spoken", gerund : "speaking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "spell", preterite: "spelled", pastPart: "spelled", gerund : "spelling")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "stand", preterite: "stood", pastPart: "stood", gerund : "standing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "steal", preterite: "stole", pastPart: "stolen", gerund : "stealing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "swim", preterite: "swam", pastPart: "swum", gerund : "swimming")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "take", preterite: "took", pastPart: "taken", gerund : "taking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "teach", preterite: "taught", pastPart: "taught", gerund : "teaching")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "think", preterite: "thought", pastPart: "thought", gerund : "thinking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "throw", preterite: "threw", pastPart: "thrown", gerund : "throwing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "wake", preterite: "woke", pastPart: "waked", gerund : "waking")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "wear", preterite: "wore", pastPart: "worn", gerund : "wearing")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "win", preterite: "won", pastPart: "won", gerund : "winning")); id += 1
    verbModelList.append( EnglishVerbModel(id: id, infinitive: "write", preterite: "wrote", pastPart: "wrote", gerund : "writing")); id += 1
    
    print("English verb model count = \(verbModelList.count)")
    
    return verbModelList
}


