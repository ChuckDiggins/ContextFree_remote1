//
//  VerbModel.swift
//  ContextFree
//
//  Created by Charles Diggins on 3/11/21.
//

import Foundation

func createVerbModels()->[VerbModel]{
    
    //setVerbModelList(verbModelList: verbModels)
    
    var verbModels = [VerbModel]()
    
    //this first because it's standalone
    
    var thisVerb : VerbModel
    
    var idNum = 1
    thisVerb = VerbModel(id: idNum, modelVerb: "ser")
    
    thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "ser", to: "ser")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "ser", to: "ser")  //not used
    thisVerb.appendSuffix(suffix: "ser")
    verbModels.append(thisVerb)
    
    idNum = 1
    thisVerb = VerbModel(id: idNum, modelVerb: "estar")
    
    thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "estar", to: "estar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "estar", to: "estar")  //not used
    thisVerb.appendSuffix(suffix: "estar")
    verbModels.append(thisVerb)
    
    idNum = 3
    thisVerb = VerbModel(id: idNum, modelVerb: "haber")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "haber", to: "haber")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "haber", to: "haber")  //not used
    thisVerb.appendSuffix(suffix: "haber")
    verbModels.append(thisVerb)
    
    idNum = 4
    thisVerb = VerbModel(id: idNum, modelVerb: "tener")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "en", to: "eng")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "en", to: "uv")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "er", to: "gamos")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "er", to: "gáis")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.FUTURE,
                           person: ExceptionPerson.S1toP3All,
                           from: "tener", to: "tendr")
    thisVerb.appendSuffix(suffix: "tener")
    verbModels.append(thisVerb)
    
 
    
    idNum = 27
    thisVerb = VerbModel(id: idNum, modelVerb: "dar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "xxx", to: "doy")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "di", to: "d")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "xxx", to: "di")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S3,
                           from: "xxx", to: "dio")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.S1,
                           from: "xxx", to: "dé")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.S3,
                           from: "xxx", to: "dé")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "xxx", to: "deis")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "dar", to: "dar")  //not used
    thisVerb.appendSuffix(suffix: "dar")
    verbModels.append(thisVerb)
    
    idNum = 46
    thisVerb = VerbModel(id: idNum, modelVerb: "ir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "ir", to: "ir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "ido", to: "yendo")  //not used
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "iendo", to: "yendo")  //from is past participle, to is gerund
    thisVerb.appendSuffix(suffix: "ir")
    verbModels.append(thisVerb)
    
    
    idNum = 51
    thisVerb = VerbModel(id: idNum, modelVerb: "oir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "oir", to: "oir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "oído", to: "oyendo")  //not used
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "iendo", to: "yendo")  //gerund
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "oido", to: "oído")
    thisVerb.appendSuffix(suffix: "oír")
    verbModels.append(thisVerb)

    idNum = 52
    thisVerb = VerbModel(id: idNum, modelVerb: "oler")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "hue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "oler", to: "oler")  //not used
    thisVerb.appendSuffix(suffix: "oler")
    verbModels.append(thisVerb)
    
    idNum = 28
    thisVerb = VerbModel(id: idNum, modelVerb: "decir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "ec", to: "ig")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "ec", to: "ij")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.P3,
                           from: "ieron", to: "eron")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S1toP3All,
                           from: "decir", to: "dir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "decir", to: "decir")  //not used
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,  //not used
                           person: ExceptionPerson.S3P3,   //not used
                           from: "e", to: "i")  //not used
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "decido", to: "dicho")  //not used
    thisVerb.appendSuffix(suffix: "decir")
    verbModels.append(thisVerb)
    
    idNum = 56
    thisVerb = VerbModel(id: idNum, modelVerb: "pensar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")

    //thisVerb.appendSuffix(suffix: "ebar")
    //thisVerb.appendSuffix(suffix: "ecar")
    thisVerb.appendSuffix(suffix: "edar")  //depredar
    //thisVerb.appendSuffix(suffix: "efar")
    thisVerb.appendSuffix(suffix: "elar")
    thisVerb.appendSuffix(suffix: "esar")  //last vowel in stem is e - special rule??
    thisVerb.appendSuffix(suffix: "etar")
    thisVerb.appendSuffix(suffix: "ebrar")
    thisVerb.appendSuffix(suffix: "eldar")
    thisVerb.appendSuffix(suffix: "endar")
    thisVerb.appendSuffix(suffix: "entar")
    thisVerb.appendSuffix(suffix: "erbar")
    thisVerb.appendSuffix(suffix: "ensar")
    thisVerb.appendSuffix(suffix: "erdar")
    thisVerb.appendSuffix(suffix: "ednar")
    thisVerb.appendSuffix(suffix: "berrar")
    thisVerb.appendSuffix(suffix: "cerrar")
    thisVerb.appendSuffix(suffix: "derrar")
    thisVerb.appendSuffix(suffix: "ferrar")
    thisVerb.appendSuffix(suffix: "gerrar")
    thisVerb.appendSuffix(suffix: "herrar")
    thisVerb.appendSuffix(suffix: "jerrar")
    thisVerb.appendSuffix(suffix: "lerrar")
    thisVerb.appendSuffix(suffix: "merrar")
    thisVerb.appendSuffix(suffix: "nerrar")
    thisVerb.appendSuffix(suffix: "perrar")
    thisVerb.appendSuffix(suffix: "rerrar")
    thisVerb.appendSuffix(suffix: "serrar")
    thisVerb.appendSuffix(suffix: "terrar")
    thisVerb.appendSuffix(suffix: "ertar")
    thisVerb.appendSuffix(suffix: "emblar")
    thisVerb.appendSuffix(suffix: "embrar")
    thisVerb.appendSuffix(suffix: "estrar")
    thisVerb.appendExcludeSuffix(suffix: "ejar")  //desaconsejar
    thisVerb.appendExcludeSuffix(suffix: "aberrar")
    verbModels.append(thisVerb)
    idNum = 9
    thisVerb = VerbModel(id: idNum, modelVerb: "actuar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "u", to: "ú")
    thisVerb.appendSuffix(suffix: "uar")
    thisVerb.appendExcludeSuffix(suffix: "guar")
    verbModels.append(thisVerb)
    
    idNum = 10
    thisVerb = VerbModel(id: idNum, modelVerb: "adquirir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "i", to: "ie")
    thisVerb.appendSuffix(suffix: "quirir")
    verbModels.append(thisVerb)
    
    idNum = 11
    thisVerb = VerbModel(id: idNum, modelVerb: "ahincar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "i", to: "í")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "c", to: "qu")
    thisVerb.appendSuffix(suffix: "hincar")
    verbModels.append(thisVerb)
    
    idNum = 12
    thisVerb = VerbModel(id: idNum, modelVerb: "airar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "i", to: "í")
    thisVerb.appendSuffix(suffix: "airar")
    thisVerb.appendSuffix(suffix: "ainar")
    thisVerb.appendSuffix(suffix: "einar")
    thisVerb.appendSuffix(suffix: "hijar")
    thisVerb.appendSuffix(suffix: "hilar")
    thisVerb.appendSuffix(suffix: "hinar")
    thisVerb.appendSuffix(suffix: "hitar")
    thisVerb.appendSuffix(suffix: "islar")
    thisVerb.appendSuffix(suffix: "irmar")
    thisVerb.appendSuffix(suffix: "illar")
    //print("airar has consistent verb ending \(thisVerb.getConsistentVerbEnding())")
    verbModels.append(thisVerb)
    
    idNum = 13
    thisVerb = VerbModel(id: idNum, modelVerb: "andar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "d", to: "duv")
    thisVerb.appendWord(word: "andar")
    thisVerb.appendSuffix(suffix: "desandar")
    //print("andar has consistent verb ending \(thisVerb.getConsistentVerbEnding())")
    verbModels.append(thisVerb)
    
    idNum = 14
    thisVerb = VerbModel(id: idNum, modelVerb: "asir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "s", to: "sg")
    thisVerb.appendSuffix(suffix: "asir")
    verbModels.append(thisVerb)
    
    idNum = 15
    thisVerb = VerbModel(id: idNum, modelVerb: "aullar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "u", to: "ú")
    thisVerb.appendSuffix(suffix: "ullar")
    thisVerb.appendSuffix(suffix: "aular")
    thisVerb.appendSuffix(suffix: "cuar")
    thisVerb.appendSuffix(suffix: "uchar")
    thisVerb.appendSuffix(suffix: "umar")
    thisVerb.appendSuffix(suffix: "usar")  //13.2.4
    thisVerb.appendSuffix(suffix: "upar")
    thisVerb.appendSuffix(suffix: "unar")
    print("aullar has consistent verb ending \(thisVerb.getConsistentVerbEnding())")
    verbModels.append(thisVerb)
    
    idNum = 16
    thisVerb = VerbModel(id: idNum, modelVerb: "avergonzar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "üe")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "z", to: "c")
    thisVerb.appendSuffix(suffix: "gonzar")
    verbModels.append(thisVerb)
    
    idNum = 17
    thisVerb = VerbModel(id: idNum, modelVerb: "averiguar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "gu", to: "gü")
    thisVerb.appendSuffix(suffix: "guar")
    verbModels.append(thisVerb)
    
    idNum = 18
    thisVerb = VerbModel(id: idNum, modelVerb: "bruñir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "", to: "")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                            tense: ExceptionTense.GERUND,  //not used
                            person: ExceptionPerson.S3,   //not used
                            from: "iendo", to: "endo")  //not used
    thisVerb.appendSuffix(suffix: "ñir")
    thisVerb.appendSuffix(suffix: "llir")
    thisVerb.appendExcludeSuffix(suffix: "eñir")
    verbModels.append(thisVerb)
    
    
    idNum = 19
    thisVerb = VerbModel(id: idNum, modelVerb: "caber")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "cab", to: "quep")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "ab", to: "up")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S1toP3All,
                           from: "caber", to: "cabr")
    
    thisVerb.appendSuffix(suffix: "caber")
    verbModels.append(thisVerb)
    
    idNum = 20
    thisVerb = VerbModel(id: idNum, modelVerb: "caer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "a", to: "aig")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM3,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "ca", to: "")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "ido", to: "ído")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "yendo")
    thisVerb.appendSuffix(suffix: "caer")
    verbModels.append(thisVerb)
    
    
    idNum = 21
    thisVerb = VerbModel(id: idNum, modelVerb: "cazar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "z", to: "c")
    thisVerb.appendSuffix(suffix: "zar")
    thisVerb.appendExcludeSuffix(suffix: "onzar")
    thisVerb.appendExcludeSuffix(suffix: "orzar")
    thisVerb.appendExcludeSuffix(suffix: "pezar")  //empezar, tropezar
    thisVerb.appendExcludeSuffix(suffix: "enzar")  //enlenzar
    thisVerb.appendExcludeSuffix(suffix: "aizar")
    verbModels.append(thisVerb)
    
    idNum = 22
    thisVerb = VerbModel(id: idNum, modelVerb: "cocer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")

    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.S1toP3All,
                           from: "c", to: "z")
    thisVerb.appendSuffix(suffix: "cocer")
    thisVerb.appendSuffix(suffix: "socer")
    thisVerb.appendSuffix(suffix: "torcer")
    verbModels.append(thisVerb)
    
    idNum = 23
    thisVerb = VerbModel(id: idNum, modelVerb: "coger")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "g", to: "j")
    thisVerb.appendSuffix(suffix: "oger")
    thisVerb.appendSuffix(suffix: "eger")
    thisVerb.appendSuffix(suffix: "erger")
    verbModels.append(thisVerb)
    
    idNum = 24
    thisVerb = VerbModel(id: idNum, modelVerb: "colgar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.S1toP3All,
                           from: "g", to: "gu")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "g", to: "gu")
    thisVerb.appendSuffix(suffix: "olgar")
    thisVerb.appendSuffix(suffix: "rogar")
    thisVerb.appendSuffix(suffix: "ongar")
    verbModels.append(thisVerb)
    
    idNum = 25
    thisVerb = VerbModel(id: idNum, modelVerb: "conocer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "zc")   //ortho should propogate to all Present subj
    thisVerb.appendSuffix(suffix: "conocer")
    verbModels.append(thisVerb)
    
    idNum = 26
    thisVerb = VerbModel(id: idNum, modelVerb: "creer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM3,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "cre", to: "")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "ido", to: "ído")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "yendo")
    thisVerb.appendSuffix(suffix: "eer")
    verbModels.append(thisVerb)

    
   
    idNum = 29
    thisVerb = VerbModel(id: idNum, modelVerb: "defender")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendSuffix(suffix: "ender")
    thisVerb.appendSuffix(suffix: "erner")
    thisVerb.appendSuffix(suffix: "ender")
    thisVerb.appendSuffix(suffix: "eder")
    thisVerb.appendSuffix(suffix: "erder")
    thisVerb.appendSuffix(suffix: "erter")
    verbModels.append(thisVerb)
  
    idNum = 30
    thisVerb = VerbModel(id: idNum, modelVerb: "delinquir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "qu", to: "c")
    thisVerb.appendSuffix(suffix: "linquir")
    verbModels.append(thisVerb)
    
    idNum = 31
    thisVerb = VerbModel(id: idNum, modelVerb: "desosar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "hue")
    thisVerb.appendSuffix(suffix: "sosar")
    verbModels.append(thisVerb)
  
    idNum = 32
    thisVerb = VerbModel(id: idNum, modelVerb: "dirigir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "g", to: "j")    //plus all the pres subj
    thisVerb.appendSuffix(suffix: "igir")
    thisVerb.appendSuffix(suffix: "ingir")
    thisVerb.appendSuffix(suffix: "ergir")
    thisVerb.appendSuffix(suffix: "ulgir")
    thisVerb.appendSuffix(suffix: "ugir")
    thisVerb.appendSuffix(suffix: "ungir")
    thisVerb.appendSuffix(suffix: "urgir")
    verbModels.append(thisVerb)
  
    idNum = 33
    thisVerb = VerbModel(id: idNum, modelVerb: "discernir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendSuffix(suffix: "cernir")
    thisVerb.appendSuffix(suffix: "hendir")
    verbModels.append(thisVerb)
  
    idNum = 34
    thisVerb = VerbModel(id: idNum, modelVerb: "distinguir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "gu", to: "g")    //plus all the pres subj
    thisVerb.appendSuffix(suffix: "inguir")
    verbModels.append(thisVerb)
  
    idNum = 35
    thisVerb = VerbModel(id: idNum, modelVerb: "dormir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S3P3,
                           from: "o", to: "u")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "o", to: "u")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "o", to: "u")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S3P3,
                           from: "o", to: "u")
    thisVerb.appendSuffix(suffix: "morir")
    thisVerb.appendSuffix(suffix: "ormir")
    verbModels.append(thisVerb)
  
    idNum = 36
    thisVerb = VerbModel(id: idNum, modelVerb: "elegir")
    
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "g", to: "j")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S3P3,
                           from: "egiendo", to: "igiendo")
    thisVerb.appendSuffix(suffix: "legir")
    thisVerb.appendSuffix(suffix: "regir")
    verbModels.append(thisVerb)
  
    idNum = 37
    thisVerb = VerbModel(id: idNum, modelVerb: "empezar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "z", to: "c")
    thisVerb.appendSuffix(suffix: "ezar")
    thisVerb.appendSuffix(suffix: "enzar")
    verbModels.append(thisVerb)
    
    idNum = 38
    thisVerb = VerbModel(id: idNum, modelVerb: "encontrar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendSuffix(suffix: "obar")
    thisVerb.appendSuffix(suffix: "oblar")
    thisVerb.appendSuffix(suffix: "olar")
    thisVerb.appendSuffix(suffix: "oltar")
    //thisVerb.appendSuffix(suffix: "onar")
    thisVerb.appendSuffix(suffix: "oñar")
    thisVerb.appendSuffix(suffix: "ontar")
    thisVerb.appendSuffix(suffix: "ontrar")
    thisVerb.appendSuffix(suffix: "ordar")
    thisVerb.appendSuffix(suffix: "ornar")
    thisVerb.appendSuffix(suffix: "ostar")
    thisVerb.appendSuffix(suffix: "ostrar")
    thisVerb.appendSuffix(suffix: "ovar")
    
    //thisVerb.appendSuffix(suffix: "ozar")  ??
    verbModels.append(thisVerb)
    
    idNum = 39
    thisVerb = VerbModel(id: idNum, modelVerb: "enraizar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "i", to: "í")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "z", to: "c")
    thisVerb.appendSuffix(suffix: "aizar")
    thisVerb.appendSuffix(suffix: "eizar")
    verbModels.append(thisVerb)
    
    idNum = 40
    thisVerb = VerbModel(id: idNum, modelVerb: "erguir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ye")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "gu", to: "g")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "ye")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "ye")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "e", to: "i")
    thisVerb.appendSuffix(suffix: "erguir")
    verbModels.append(thisVerb)
    
    
    idNum = 41
    thisVerb = VerbModel(id: idNum, modelVerb: "errar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ye")
    thisVerb.appendSuffix(suffix: "errar")
    thisVerb.appendSuffix(suffix: "aberrar")
    verbModels.append(thisVerb)
    
    idNum = 42
    thisVerb = VerbModel(id: idNum, modelVerb: "forzar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "z", to: "c")
    thisVerb.appendSuffix(suffix: "orzar")
    verbModels.append(thisVerb)
    
    idNum = 43
    thisVerb = VerbModel(id: idNum, modelVerb: "guiar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "i", to: "í")
    thisVerb.appendSuffix(suffix: "uiar")
    thisVerb.appendSuffix(suffix: "liar")
    thisVerb.appendSuffix(suffix: "diar")
    thisVerb.appendSuffix(suffix: "stiar")
    thisVerb.appendSuffix(suffix: "spiar")
    thisVerb.appendSuffix(suffix: "fiar")
    thisVerb.appendSuffix(suffix: "viar")
    thisVerb.appendSuffix(suffix: "riar")
    thisVerb.appendSuffix(suffix: "siar")
    thisVerb.appendSuffix(suffix: "ociar")
    thisVerb.appendSuffix(suffix: "squiar")  //esquiar, but not acequiar

    verbModels.append(thisVerb)
    
    idNum = 44
    thisVerb = VerbModel(id: idNum, modelVerb: "hacer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "c", to: "g")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "a", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S1toP3All,
                           from: "hacer", to: "har")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S1toP3All,
                           from: "ido", to: "echo")
    thisVerb.appendSuffix(suffix: "hacer")
    verbModels.append(thisVerb)
    
    idNum = 45
    thisVerb = VerbModel(id: idNum, modelVerb: "influir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "u", to: "uy")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "u", to: "uy")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "u", to: "uy")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "u", to: "uy")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "u", to: "uy")
    thisVerb.appendSuffix(suffix: "uir")
    thisVerb.appendSuffix(suffix: "üir")
    thisVerb.appendExcludeSuffix(suffix: "seguir")
    verbModels.append(thisVerb)
    
    
    
    idNum = 47
    thisVerb = VerbModel(id: idNum, modelVerb: "jugar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "u", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "g", to: "gu")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "jugar", to: "jugar")
    thisVerb.appendSuffix(suffix: "jugar")
    verbModels.append(thisVerb)
    

    idNum = 48
    thisVerb = VerbModel(id: idNum, modelVerb: "lucir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "cz")
    thisVerb.appendSuffix(suffix: "lucir")
    verbModels.append(thisVerb)
    
    idNum = 49
    thisVerb = VerbModel(id: idNum, modelVerb: "mecer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "z")
    thisVerb.appendSuffix(suffix: "mecer")
    thisVerb.appendSuffix(suffix: "encer")
    thisVerb.appendSuffix(suffix: "ercer")
    verbModels.append(thisVerb)
    
    idNum = 50
    thisVerb = VerbModel(id: idNum, modelVerb: "mover")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendSuffix(suffix: "over")
    thisVerb.appendSuffix(suffix: "oler")
    thisVerb.appendSuffix(suffix: "order")
    thisVerb.appendExcludeSuffix(suffix: "soler")
    verbModels.append(thisVerb)
    
    idNum = 53
    thisVerb = VerbModel(id: idNum, modelVerb: "pagar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "g", to: "gu")
    thisVerb.appendExcludeSuffix(suffix: "ongar")
    thisVerb.appendExcludeSuffix(suffix: "olgar")
    thisVerb.appendExcludeSuffix(suffix: "regar")
    thisVerb.appendSuffix(suffix: "gar")
    verbModels.append(thisVerb)
    
    idNum = 54
    thisVerb = VerbModel(id: idNum, modelVerb: "parecer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "z", to: "zc")
    thisVerb.appendExcludeSuffix(suffix: "ercer")
    thisVerb.appendExcludeSuffix(suffix: "mecer")
    thisVerb.appendExcludeSuffix(suffix: "encer")
    thisVerb.appendExcludeSuffix(suffix: "facer")
    thisVerb.appendExcludeSuffix(suffix: "lacer")
    thisVerb.appendExcludeSuffix(suffix: "yacer")
    thisVerb.appendSuffix(suffix: "ecer")
    thisVerb.appendSuffix(suffix: "acer")
    verbModels.append(thisVerb)
    
    idNum = 55
    thisVerb = VerbModel(id: idNum, modelVerb: "pedir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "e", to: "i")
    thisVerb.appendSuffix(suffix: "edir")
    thisVerb.appendSuffix(suffix: "ebir")
    thisVerb.appendSuffix(suffix: "ervir")
    thisVerb.appendSuffix(suffix: "estir")
    thisVerb.appendSuffix(suffix: "emir")
    thisVerb.appendSuffix(suffix: "endir")
    thisVerb.appendSuffix(suffix: "etir")
    verbModels.append(thisVerb)
    
    
    
    idNum = 57
    thisVerb = VerbModel(id: idNum, modelVerb: "placer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "zc")
    thisVerb.appendSuffix(suffix: "acer")
    thisVerb.appendExcludeSuffix(suffix: "isfacer") //satisfacer
    thisVerb.appendExcludeSuffix(suffix: "yacer")
    verbModels.append(thisVerb)


    idNum = 58
    thisVerb = VerbModel(id: idNum, modelVerb: "poder")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "o", to: "u")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.FUTURE,
                           person: ExceptionPerson.S1toP3All,
                           from: "poder", to: "podr")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S3P3,
                           from: "o", to: "u")
    thisVerb.appendSuffix(suffix: "poder")
    thisVerb.appendSuffix(suffix: "repoder")
    verbModels.append(thisVerb)
    
    
    idNum = 59
    thisVerb = VerbModel(id: idNum, modelVerb: "podrir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "u")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "o", to: "u")
    thisVerb.appendSuffix(suffix: "podrir")
    verbModels.append(thisVerb)
    
    idNum = 591
    thisVerb = VerbModel(id: idNum, modelVerb: "pudrir")
    thisVerb.appendSuffix(suffix: "pudrir")
    verbModels.append(thisVerb)
    
    idNum = 60
    thisVerb = VerbModel(id: idNum, modelVerb: "poner")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "n", to: "ng")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "on", to: "us")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.FUTURE,
                           person: ExceptionPerson.S1toP3All,
                           from: "poder", to: "pondr")
    thisVerb.appendSuffix(suffix: "poner")
    verbModels.append(thisVerb)
    
    idNum = 61
    thisVerb = VerbModel(id: idNum, modelVerb: "predecir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "ec", to: "ig")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "i")
 
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "ec", to: "ij")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.P3,
                           from: "ieron", to: "eron")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,  //not used
                           person: ExceptionPerson.S3P3,   //not used
                           from: "e", to: "i")  //not used
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "decido", to: "dicho")  //not used
    thisVerb.appendSuffix(suffix: "decir")
    verbModels.append(thisVerb)
    
    idNum = 62
    thisVerb = VerbModel(id: idNum, modelVerb: "producir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "cz")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "c", to: "j")
    thisVerb.appendSuffix(suffix: "ducir")
    verbModels.append(thisVerb)
   
    idNum = 63
    thisVerb = VerbModel(id: idNum, modelVerb: "prohibir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "i", to: "í")
    thisVerb.appendSuffix(suffix: "hibir")
    verbModels.append(thisVerb)
   
    idNum = 64
    thisVerb = VerbModel(id: idNum, modelVerb: "querer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "er", to: "is")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.FUTURE,
                           person: ExceptionPerson.S1toP3All,
                           from: "querer", to: "qerr")
    thisVerb.appendSuffix(suffix: "querer")
    verbModels.append(thisVerb)

    idNum = 65
    thisVerb = VerbModel(id: idNum, modelVerb: "raer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "a", to: "aig")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM3,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "ra", to: "")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "yendo")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "ido", to: "ído")
    
    thisVerb.appendSuffix(suffix: "raer")
    thisVerb.appendExcludeSuffix(suffix: "traer")
    verbModels.append(thisVerb)

    idNum = 66
    thisVerb = VerbModel(id: idNum, modelVerb: "regar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "g", to: "gu")
    thisVerb.appendSuffix(suffix: "regar")
    verbModels.append(thisVerb)
    
    idNum = 67
    thisVerb = VerbModel(id: idNum, modelVerb: "reír")
    /*thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "reír", to: "reír")
 */
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "í")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM3,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "re", to: "re")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.P1,
                           from: "xx", to: "ímos")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S3,
                           from: "xxx", to: "ió")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.P3,
                           from: "xxx", to: "ieron")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.P3,
                           from: "reír", to: "reir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "iendo")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "ido", to: "ído")
    thisVerb.appendSuffix(suffix: "reír")
    thisVerb.appendSuffix(suffix: "sonreir")
    thisVerb.appendSuffix(suffix: "leír")
    verbModels.append(thisVerb)

    idNum = 68
    thisVerb = VerbModel(id: idNum, modelVerb: "reñir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "endo")
    thisVerb.appendSuffix(suffix: "eñir")
    verbModels.append(thisVerb)
    
    
    idNum = 69
    thisVerb = VerbModel(id: idNum, modelVerb: "reunir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "u", to: "ú")
    thisVerb.appendSuffix(suffix: "reunir")
    verbModels.append(thisVerb)
    
    idNum = 70
    thisVerb = VerbModel(id: idNum, modelVerb: "roer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "o", to: "oig")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM3,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S2,
                           from: "re", to: "re")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "yendo")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "ido", to: "ído")
    thisVerb.appendSuffix(suffix: "roer")
    verbModels.append(thisVerb)
    
    idNum = 71
    thisVerb = VerbModel(id: idNum, modelVerb: "saber")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "ab", to: "ep")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "ab", to: "up")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S2,
                           from: "saber", to: "sabr")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "sabo", to: "sé")  //this will change all the present subjunctive
    thisVerb.appendSuffix(suffix: "saber")
    verbModels.append(thisVerb)
    
    idNum = 72
    thisVerb = VerbModel(id: idNum, modelVerb: "sacar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "c", to: "qu")  //this will change all the present subjunctive
    thisVerb.appendSuffix(suffix: "car")
    thisVerb.appendExcludeSuffix(suffix: "incar")
    thisVerb.appendExcludeSuffix(suffix: "orcar")
    thisVerb.appendExcludeSuffix(suffix: "olcar")
    thisVerb.appendExcludeSuffix(suffix: "ocar")
    verbModels.append(thisVerb)
    
    idNum = 73
    thisVerb = VerbModel(id: idNum, modelVerb: "salir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "l", to: "lg")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S2,
                           from: "salir", to: "saldr")
    thisVerb.appendSuffix(suffix: "salir")
    verbModels.append(thisVerb)
    
    idNum = 74
    thisVerb = VerbModel(id: idNum, modelVerb: "satisfacer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "g")  //
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S3,
                           from: "satisfacer", to: "satisfizo")  //this will chthis will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S2,
                           from: "satisfacer", to: "satisfar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1toP3All,
                           from: "a", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "acido", to: "echo")
    thisVerb.appendSuffix(suffix: "isfacer")
    verbModels.append(thisVerb)
    
    idNum = 75
    thisVerb = VerbModel(id: idNum, modelVerb: "seguir")
    
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "gu", to: "g")  //this will change all the present subjunct
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S3P3,
                           from: "e", to: "i")
    thisVerb.appendSuffix(suffix: "seguir")
    verbModels.append(thisVerb)
    
    idNum = 76
    thisVerb = VerbModel(id: idNum, modelVerb: "sentir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEMSINGLE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S3P3,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S3P3,
                           from: "e", to: "i")
    thisVerb.appendSuffix(suffix: "erir")
    thisVerb.appendSuffix(suffix: "ertir")
    thisVerb.appendSuffix(suffix: "entir")
    thisVerb.appendSuffix(suffix: "ervir")
    thisVerb.appendSuffix(suffix: "envir")
    verbModels.append(thisVerb)
    
    
    idNum = 77
    thisVerb = VerbModel(id: idNum, modelVerb: "soler")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendSuffix(suffix: "soler")
    verbModels.append(thisVerb)
    
    
    idNum = 78
    thisVerb = VerbModel(id: idNum, modelVerb: "tañer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S3P3,
                           from: "", to: "")
    thisVerb.appendSuffix(suffix: "tañer")
    thisVerb.appendSuffix(suffix: "peller")
    verbModels.append(thisVerb)
    
    idNum = 79
    thisVerb = VerbModel(id: idNum, modelVerb: "traer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "a", to: "aig")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "a", to: "aj")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.P3,
                           from: "ieron", to: "eron")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S2,
                           from: "iendo", to: "yendo")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S2,
                           from: "ido", to: "ído")
    thisVerb.appendSuffix(suffix: "traer")
    verbModels.append(thisVerb)
   
    idNum = 80
    thisVerb = VerbModel(id: idNum, modelVerb: "trocar")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "c", to: "qu")  //this will change all the present subjunctive
    thisVerb.appendSuffix(suffix: "ocar")
    thisVerb.appendSuffix(suffix: "orcar")
    thisVerb.appendSuffix(suffix: "olcar")
    thisVerb.appendSuffix(suffix: "oscar")
    verbModels.append(thisVerb)
    
    idNum = 81
    thisVerb = VerbModel(id: idNum, modelVerb: "valer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "l", to: "lg")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S2,
                           from: "valer", to: "valdr")
    thisVerb.appendSuffix(suffix: "valer")
    verbModels.append(thisVerb)
    
    idNum = 82
    thisVerb = VerbModel(id: idNum, modelVerb: "venir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "e", to: "ie")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "ien", to: "eng")  //this will change all the present subjunctive
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P1,
                           from: "ir", to: "gamos")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACE,
                           tense: ExceptionTense.PRESENTSUBJ,
                           person: ExceptionPerson.P2,
                           from: "ir", to: "gáis")

    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM,
                           tense: ExceptionTense.PRETERITE,
                           person: ExceptionPerson.S1,
                           from: "e", to: "i")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEINFINITIVE,
                           tense: ExceptionTense.CONDITIONAL,
                           person: ExceptionPerson.S2,
                           from: "venir", to: "vendr")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.PRETSTEM2,
                           tense: ExceptionTense.GERUND,
                           person: ExceptionPerson.S1,
                           from: "e", to: "i")
    thisVerb.appendSuffix(suffix: "venir")
    verbModels.append(thisVerb)
    
    idNum = 83
    thisVerb = VerbModel(id: idNum, modelVerb: "ver")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.SPECIAL,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "ver", to: "ver")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STANDALONE,
                           tense: ExceptionTense.PRESENT,  //not used
                           person: ExceptionPerson.S3,   //not used
                           from: "ver", to: "ver")  //not used
    thisVerb.appendSuffix(suffix: "ver")
    verbModels.append(thisVerb)
    
    idNum = 84
    thisVerb = VerbModel(id: idNum, modelVerb: "volver")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.STEM,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "o", to: "ue")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.REPLACEENDING,
                           tense: ExceptionTense.PASTPART,
                           person: ExceptionPerson.S1S2S3P3,
                           from: "olvido", to: "uelto")
    thisVerb.appendSuffix(suffix: "olver")
    verbModels.append(thisVerb)
    
    idNum = 85
    thisVerb = VerbModel(id: idNum, modelVerb: "yacer")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "zg")  //this will change all the present subjunctive
    thisVerb.appendSuffix(suffix: "yacer")
    verbModels.append(thisVerb)
    
    idNum = 86
    thisVerb = VerbModel(id: idNum, modelVerb: "zurcir")
    thisVerb.appendException(exceptionPattern: ExceptionPattern.ORTHO,
                           tense: ExceptionTense.PRESENT,
                           person: ExceptionPerson.S1,
                           from: "c", to: "z")  //this will change all the present subjunctive
    thisVerb.appendSuffix(suffix: "cir")
    //thisVerb.appendSuffix(suffix: "ncir")
    verbModels.append(thisVerb)
    
    idNum = 5
    thisVerb = VerbModel(id: idNum, modelVerb: "cortar")
    thisVerb.appendSuffix(suffix: "ar")
    verbModels.append(thisVerb)
    
    idNum = 6
    thisVerb = VerbModel(id: idNum, modelVerb: "deber")
    thisVerb.appendSuffix(suffix: "er")
    verbModels.append(thisVerb)
    
    idNum = 7
    thisVerb = VerbModel(id: idNum, modelVerb: "vivir")
    thisVerb.appendSuffix(suffix: "ir")
    verbModels.append(thisVerb)
    
    
    return verbModels
}


func parseVerbModels(verbModels: [VerbModel]){
    for vm in verbModels {
        let modelVerb = vm.modelVerb
        let exceptionCount = vm.exceptionList.count
        print("model verb \(vm.id). \(modelVerb) has exceptionCount = \(exceptionCount)")
    }
}

func testVerbsAgainstVerbModels(verbModels: [VerbModel]){
    var verbWordList = [String]()
    
    verbWordList.append("enraizar")
    verbWordList.append("mestruar")
    verbWordList.append("averiguar")
    verbWordList.append("adecuar")
    verbWordList.append("reforcer")
    verbWordList.append("inquirir")
    verbWordList.append("xxxquirir")
    verbWordList.append("enguillir")
    verbWordList.append("chuckar")
    verbWordList.append("chuckahincar")
    verbWordList.append("ahijar")
    verbWordList.append("redar")
    verbWordList.append("examinar")
    verbWordList.append("rehilar")
    verbWordList.append("forzar")
    verbWordList.append("empezar")
    verbWordList.append("atraillar")
    verbWordList.append("undecir")
    verbWordList.append("amohinar")
    verbWordList.append("rehusar")
    verbWordList.append("leer")
    verbWordList.append("concernir")
    

    for verbWord in verbWordList {
        var modelFound = false
        for vm in verbModels {
            if vm.isModelFor(verbWord: verbWord){
                modelFound = true
                print("VerbWord \(verbWord) has verb model \(vm.id) - model verb \(vm.modelVerb)")
                break
            }
        }
        if !modelFound {print("VerbWord \(verbWord) has no known verb model")}
    }
}
