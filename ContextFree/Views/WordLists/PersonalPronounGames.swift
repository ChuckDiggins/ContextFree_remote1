//
//  PronounGames.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/2/21.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square" )
            }
        }
    }
}

let Info = (singleList:[dSingle], indexList:[Int], breakIndex: Int).self

struct PersonalPronounGames: View {
    @EnvironmentObject var cfModelView : CFModelView
    
    @State private var currentTense = Tense.preterite
    @State private var currentPerson = Person.S3
    //@State private var singleList = [dSingle]()
    @State private var singleList = [dSingle]()
    @State private var processedSingleList = [dSingle]()
    @State private var singleIndexList = [Int]()
    @State private var processedIndexList = [Int]()
    @State private var selectedList = [Bool]()
    @State private var subjectIndexList = [Int]()
    @State private var directObjectIndexList = [Int]()
    @State private var indirectObjectIndexList = [Int]()
    
    @State private var breakIndex = 0
    @State private var currentLanguage = LanguageType.Spanish
    
    @State private var currentSingleIndex = 0
    @State private var selectedProcessedIndex = 0
    @State private var sentenceString = ""
    
    @State private var m_clause = dIndependentAgnosticClause()
    @State private var m_englishClause = dIndependentAgnosticClause()
    
    @State private var checkboxSpanish: Bool = false
    @State private var checkboxFrench: Bool = true
    @State private var checkboxEnglish: Bool = false
    
    @State private var checkboxSubject: Bool = true
    @State private var checkboxDirectObject: Bool = true
    @State private var checkboxIndirectObject: Bool = true
    @State private var checkboxPrepositional: Bool = false
    @State private var selected = 1
    @State private var currentFunctionString = ""
    
    @State var m_randomPronounPhrase : RandomPersonalPronounPhrase!
    let Function : [PPFunctionType] = [.none, .subject, .directObject, .indirectObject]
    @State private var currentFunction = 0
    @State private var currentEquivalentPronoun = ""
    @State private var morphStruct = CFMorphStruct()
    @State private var morphIndex = 0
    
    var body: some View {
        HStack{
            Button(action: {
                currentLanguage = .Spanish
                sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
                updateCurrentSentenceViewStuff()
            }){
                Text("Spanish")
            }.font(currentLanguage == .Spanish ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
            
            Button(action: {
                currentLanguage = .French
                sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
                updateCurrentSentenceViewStuff()
            }){
                Text("French")
            }.font(currentLanguage == .French ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .French ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
            
            Button(action: {
                currentLanguage = .English
                sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
                updateCurrentSentenceViewStuff()
            }){
                Text("English")
            }.font(currentLanguage == .English ? .title : .system(size: 20) )
            .foregroundColor(currentLanguage == .English ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
        }.padding()
        
        //show the random sentence
        HStack {
            ForEach(singleIndexList, id: \.self){index in
                Button(action: {
                    currentSingleIndex = index
                    changeWord()
                }){
                    HStack{
                        Text(singleList[index].getProcessWordInWordStateData(language: currentLanguage))
                            .font(.subheadline)
                            .foregroundColor(index == currentSingleIndex ? .red : .black)
                    }
                }
            }
        }.padding(10)
        .border(Color.green)
        .background(Color.white)
        
        /*
        Button(action: {
            highlightCurrentFunction()
            updateCurrentSentenceViewStuff()
        }){
            HStack{
                Text("Show: ").foregroundColor(.black)
                Text(currentFunctionString)
                    .padding()
                Text("Pronoun equivalent: ").foregroundColor(.black)
                Text(currentEquivalentPronoun)
            }
        }.font(.subheadline)
        */
        
        //morph the sentence here
        Button(action: {
            morphIndex += 1
            if morphIndex >= morphStruct.count(){morphIndex = 0}
        }){
            VStack{
                HStack{
                    Text(morphStruct.getMorphStep(index: morphIndex).part1).foregroundColor(.black)
                    Text(morphStruct.getMorphStep(index: morphIndex).part2).foregroundColor(.red).font(.system(size: 20)).bold()
                    Text(morphStruct.getMorphStep(index: morphIndex).part3).foregroundColor(.black)
                }
                .padding()
                HStack{
                    Text(morphStruct.getMorphStep(index: morphIndex).comment1).foregroundColor(.black)
                    Text(morphStruct.getMorphStep(index: morphIndex).comment2).foregroundColor(.red).font(.system(size: 20)).bold()
                    Text(morphStruct.getMorphStep(index: morphIndex).comment3).foregroundColor(.black)
                }
            }
        }.padding(10)
        .border(Color.green)
        .background(Color.white)
        
        VStack{
            HStack(alignment: .center){
                Spacer()
                Button(action: {createRandomClause( )}) {
                    Text("Random sentence")
                        .padding(10)
                        .background(Color.green)
                        .foregroundColor(Color.yellow)
                        .cornerRadius(25)
                }
                Spacer()
            }
        }.onAppear{
            cfModelView.createNewModel(language: .Agnostic)
            m_randomPronounPhrase = RandomPersonalPronounPhrase(wsp: cfModelView.getWordStringParser(), rft: .subjectPronounVerb)
            highlightCurrentFunction()
            createRandomClause()
        }
        
        
        VStack(alignment: .center){
            Button(action: {
                generateRandomTense()
            }){
                HStack {
                    Text("Tense: \(currentTense.rawValue)").background(Color.yellow).foregroundColor(.black).frame(width: 250, height: 80)
                        .cornerRadius(10).padding(25)
                    
                }
            }
        }
        
        VStack{
            Text("Select pronoun options:").font(.headline)
            Toggle(isOn: $checkboxSubject){
                Text("Subject pronouns")
            }.toggleStyle(CheckboxToggleStyle())
            Toggle(isOn: $checkboxDirectObject){
                Text("Direct object pronouns")
            }.toggleStyle(CheckboxToggleStyle())
            Toggle(isOn: $checkboxIndirectObject){
                Text("Indirect object pronouns")
            }.toggleStyle(CheckboxToggleStyle())
            Toggle(isOn: $checkboxPrepositional){
                Text("Prepositional pronouns")
            }.toggleStyle(CheckboxToggleStyle())
        }.font(.subheadline).padding()
        
        
    }
    
    
   
    func changeWord(){
        let single = singleList[currentSingleIndex]
        var wsd = single.getSentenceData()
        
        switch wsd.wordType {
        case .verb:
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .none)
            single.copyGuts(newSingle: newSingle)
        case .adjective, .determiner, .adverb, .conjunction:
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .none)
            single.copyGuts(newSingle: newSingle)
        case .noun:
            let nounSingle = single as! dNounSingle
            var newFunctionType = PPFunctionType.none
            if nounSingle.isSubject() { newFunctionType = .subject }
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType : newFunctionType)
            nounSingle.copyGuts(newSingle: newSingle)
            if nounSingle.isSubject() {
                m_clause.setPerson(value: nounSingle.getPerson())
            }
        case .pronoun:
            let ppSingle = single as! dPersonalPronounSingle
            var newFunctionType = PPFunctionType.none
            if ppSingle.isSubject() { newFunctionType = .subject }
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType : newFunctionType)
            ppSingle.copyGuts(newSingle: newSingle)
            if ppSingle.isSubject() {
                m_clause.setPerson(value: ppSingle.getPerson())
            }
        case .preposition:
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .none)
            single.copyGuts(newSingle: newSingle)
        default: break
        }
        wsd = single.getSentenceData()
        m_clause.processInfo()
        currentPerson = m_clause.getPerson()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: currentLanguage, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
    
    func createRandomClause(){
        
        var str = ""
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        //this clause will be in Romance order
        
        m_clause = m_randomPronounPhrase.createRandomAgnosticPronounPhrase(subject: checkboxSubject,
                                                                           directObject: checkboxDirectObject,
                                                                           indirectObject: checkboxIndirectObject,
                                                                           prepositional: checkboxPrepositional)
        
        currentPerson = m_clause.getPerson()
        switch currentLanguage {
        case .French:
            str  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        case .Spanish:
            str  = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        case .English:
            m_englishClause = dIndependentAgnosticClause()
            m_englishClause.copy(inClause: m_clause)
            m_englishClause.convertRomancePhraseOrderToEnglishPhraseOrder()
            str  = m_englishClause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        default:
            break
        }
        
        
        updateCurrentSentenceViewStuff()
    }
    
    func testCFMorphModel(){
        var cfMorphSentence = CFMorphSentence(m_clause: m_clause)
        morphStruct.clear()

        //create the subject morph model first
        if checkboxSubject {
            var subjectCFMM = CFMorphModel(id: 0, modelName: "Convert Spanish Phrases to PPs")
            subjectCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "grab", cfFromTypeString: "subjectPhrase", cfToTypeString: ""))
            subjectCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "replace", cfFromTypeString: "subjectPhrase", cfToTypeString: "subjectPronoun"))
            subjectCFMM.parseMorphModel()
            morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: subjectCFMM)
        }
        
        if checkboxDirectObject {
            var doCFMM = CFMorphModel(id: 1, modelName: "Convert Spanish DO phrases to DO PPs")
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "grab", cfFromTypeString: "directObjectPhrase", cfToTypeString: ""))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "replace", cfFromTypeString: "directObjectPhrase", cfToTypeString: "directObjectPronoun"))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "insert", cfToTypeString: "directObjectPronoun", moveToString: "precedingVerb"))
            doCFMM.parseMorphModel()
            morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: doCFMM)
        }
        
        if checkboxIndirectObject {
            var doCFMM = CFMorphModel(id: 1, modelName: "Convert Spanish inDO phrases to inDO PPs")
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "grab", cfFromTypeString: "indirectObjectPhrase", cfToTypeString: ""))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "replace", cfFromTypeString: "indirectObjectPhrase", cfToTypeString: "indirectObjectPronoun"))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "insert", cfToTypeString: "indirectObjectPhrase", moveToString: "precedingDOPronoun"))
            doCFMM.parseMorphModel()
            morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: doCFMM)
        }
    }
    
    func updateCurrentSentenceViewStuff(){
        
        singleList = m_clause.getSingleList()
        m_clause.setWorkingSingleList(singleList: singleList)
        testCFMorphModel()
        
        /*
        processPronouns()
        
        var cfMorphSentence = CFMorphSentence(m_clause: m_clause)
        morphStruct.clear()
        morphIndex = 01
        var ppFunctionList = [PPFunctionType]()
        if checkboxSubject {ppFunctionList.append(.subject)}
        if checkboxDirectObject {ppFunctionList.append(.directObject)}
        if checkboxIndirectObject {ppFunctionList.append(.indirectObject)}
        /*
         @State private var checkboxSubject: Bool = true
         @State private var checkboxDirectObject: Bool = true
         @State private var checkboxIndirectObject: Bool = true
         */
        morphStruct = cfMorphSentence.convertSpanishPhrasesToPersonalPronouns(inputMorphStruct: morphStruct, ppFunctionList: ppFunctionList)
        */
        
        //englishSingleList = m_englishClause.getSingleList()

        singleIndexList.removeAll()
        for i in 0 ..< singleList.count {
            singleIndexList.append(i)
        }
        
        //for now
        processedIndexList.removeAll()
        processedSingleList.removeAll()
        selectedList.removeAll()
        for i in 0 ..< singleList.count {
            selectedList.append(false)
            processedIndexList.append(i)
            processedSingleList.append(singleList[i])
        }
        
        setSelectIndices()
        
        
    }
    
    
    func processPronouns(){
        var subjectPronoun = ""
        var directObjectPronoun = ""
        var indirectObjectPronoun = ""
        subjectPronoun = m_clause.getSubjectPronounString(language: currentLanguage)
        directObjectPronoun = m_clause.getDirectObjectPronounString(language: currentLanguage)
        indirectObjectPronoun = m_clause.getIndirectObjectPronounString(language: currentLanguage)
        
        print("Subject pronoun: \(subjectPronoun) \nDirect object pronoun: \(directObjectPronoun) \nIndirect object pronoun: \(indirectObjectPronoun)")
        
        let doList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .DirectObject)
        let subjList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .Subject)
        let inDoList = m_clause.getCompositeSentenceString(language: currentLanguage, targetFunction: .IndirectObject)
        print ("Subj count: \(subjList.count), doCount: \(doList.count), inDoCount: \(inDoList.count)")
        
        let singleList = m_clause.getSingleList()
        
        //fill the subjList indices ...subjectIndexList
        subjectIndexList.removeAll()
        for subjIndex in 0 ..< subjList.count {
            let subj = subjList[subjIndex]
            for ssIndex in 0 ..< singleList.count {
                let single = singleList[ssIndex]
                if subj == single {
                    subjectIndexList.append(ssIndex)
                    break
                }
            }
        }
        
        //fill the directObjectList indices ...directObjectIndexList
        directObjectIndexList.removeAll()
        for doIndex in 0 ..< doList.count {
            let d = doList[doIndex]
            for ssIndex in 0 ..< singleList.count {
                let single = singleList[ssIndex]
                if d == single {
                    directObjectIndexList.append(ssIndex)
                    break
                }
            }
        }
        
        //fill the directObjectList indices ...directObjectIndexList
        indirectObjectIndexList.removeAll()
        var singleListStart = 0
        for indoIndex in 0 ..< inDoList.count {
            let d = inDoList[indoIndex]
            for ssIndex in singleListStart ..< singleList.count {
                let single = singleList[ssIndex]
                if d == single {
                    indirectObjectIndexList.append(ssIndex)
                    singleListStart = ssIndex+1
                    break
                }
            }
        }
    }
    
    func highlightCurrentFunction(){
        currentFunction += 1
        if currentFunction > Function.count - 1 {
            currentFunction = 0
        }
        currentFunctionString = Function[currentFunction].rawValue
        switch currentFunction {
        case 0:  currentEquivalentPronoun = "none current"
        case 1:  currentEquivalentPronoun = m_clause.getSubjectPronounString(language: currentLanguage)
        case 2:  currentEquivalentPronoun = m_clause.getDirectObjectPronounString(language: currentLanguage)
        case 3:  currentEquivalentPronoun = m_clause.getIndirectObjectPronounString(language: currentLanguage)
        default: break
        }
     
        
    }
    
    func setSelectIndices(){
        var currentIndexList = [Int]()

        switch currentFunction {
        case 0:  currentIndexList = [Int]()
        case 1:  currentIndexList = subjectIndexList
        case 2:  currentIndexList = directObjectIndexList
        case 3:  currentIndexList = indirectObjectIndexList
        default:
            break
        }
        
        //loop through every single location and determine if it is selected
        for i in 0 ..< singleList.count {
            for ci in currentIndexList {
                if singleIndexList[i] == ci {selectedList[i] = true}
            }
        }
    }
    
    
    
    func generateRandomTense(){
        let tense = currentTense
        while tense == currentTense {
            currentTense = cfModelView.getRandomTense()
        }
        
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .French, tense: currentTense, person: currentPerson)
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .English, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
    func generateRandomPerson(){
        let person = currentPerson
        while person == currentPerson {
            let i = Int.random(in: 0 ..< 6)
            currentPerson = Person.all[i]
        }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: .Spanish, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
}


struct PronounGames_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPronounGames()
    }
}
