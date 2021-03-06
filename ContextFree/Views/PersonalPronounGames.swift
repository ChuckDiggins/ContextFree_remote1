//
//  PronounGames.swift
//  ContextFree
//
//  Created by Charles Diggins on 7/2/21.
//

import SwiftUI
import JumpLinguaHelpers

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
var m_currentLanguage : LanguageType = .French

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
    //@State private var currentLanguage = LanguageType.Spanish
    
    @State private var currentSingleIndex = 0
    @State private var selectedProcessedIndex = 0
    @State private var sentenceString = ""
    
    @State private var m_clause : dIndependentAgnosticClause!
    @State private var m_englishClause : dIndependentAgnosticClause!
    
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
    let Function : [ContextFreeFunction] = [.Subject, .DirectObject, .IndirectObject]
    @State private var currentFunction = 0
    @State private var currentEquivalentPronoun = ""
    @State private var currentString = ""
    @State private var morphStruct = CFMorphStruct()
    @State private var morphIndex = 0
    
    //this is for changing all the noun phrase order from Romance to English
    @State private var m_englishPhraseCFMM = CFMorphModel(id: 0, modelName: "")
    
    let colors:[Color]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing:0), count: 12)
    
    var body: some View {
        
        //LanguageChooserView(currentLanguage: currentLanguage)
 
        HStack{
            Button(action: {
                m_currentLanguage = .Spanish
                setNewLanguage()
            }){
                Text("Spanish")
                    .bold()
                    .frame(width: 150, height: 20)
                    .font(m_currentLanguage == .Spanish ? .system(size: 20)  : .system(size: 10) )
                    .foregroundColor(m_currentLanguage == .Spanish ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Button(action: {
                m_currentLanguage = .French
                setNewLanguage()
            }){
                Text("French")
                    .bold()
                    .frame(width: 150, height: 20)
                    .font(m_currentLanguage == .French ? .system(size: 20) : .system(size: 10) )
                    .foregroundColor(m_currentLanguage == .French ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Button(action: {
                m_currentLanguage = .English
                setNewLanguage()
            }){
                Text("English")
                    .bold()
                    .frame(width: 150, height: 20)
                    .font(m_currentLanguage == .English ? .system(size: 20)  : .system(size: 10) )
                    .foregroundColor(m_currentLanguage == .English ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }.padding()


        //LanguageButtonGroup()
        
        //show the random sentence
        
        //LazyVGrid (columns: columns, spacing: 0){
        HStack{
            ForEach(singleIndexList, id: \.self){index in
                //colors[index % colors.count].overlay (
                Button(action: {
                    currentSingleIndex = index
                    changeWord()
                }){
                    HStack{
                        Text(singleList[index].getProcessWordInWordStateData(language: m_currentLanguage))
                            .font(.subheadline)
                            .foregroundColor(index == currentSingleIndex ? .red : .black)
                    }
                }
                //)
            }
        }.padding(10)
        .border(Color.green)
        .background(Color.white)
        
        
        Button(action: {
            highlightCurrentFunction()
            updateCurrentSentenceViewStuff()
        }){
            VStack{
                HStack{
                    Text("\(currentFunctionString): ")
                    Text(currentString)
                }
                HStack{
                    Text("Pronoun equivalent: ").foregroundColor(.black)
                    Text(currentEquivalentPronoun)
                }
            }
        }.font(.subheadline)
        
        
        //morph the sentence here
        Button(action: {
            morphIndex += 1
            if morphIndex >= morphStruct.count(){morphIndex = 0}
        }){
            VStack{
                HStack{
                    Text(morphStruct.getMorphStep(index: morphIndex).part1).foregroundColor(.black)
                    Text(morphStruct.getMorphStep(index: morphIndex).part2).foregroundColor(.red).font(.system(size: 30)).bold()
                    Text(morphStruct.getMorphStep(index: morphIndex).part3).foregroundColor(.black)
                }
                .padding()
                HStack{
                    Text(morphStruct.getMorphStep(index: morphIndex).comment1).foregroundColor(.black)
                    Text(morphStruct.getMorphStep(index: morphIndex).comment2).foregroundColor(.red).font(.system(size: 30)).bold()
                    Text(morphStruct.getMorphStep(index: morphIndex).comment3).foregroundColor(.black)
                    Text(morphStruct.getMorphStep(index: morphIndex).comment4).foregroundColor(.red).font(.system(size: 30)).bold()
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
            
            //cfModelView.createNewModel(language: .Agnostic)
            m_randomPronounPhrase = RandomPersonalPronounPhrase(wsp: cfModelView.getWordStringParser(), rft: .subjectPronounVerb)
            createRandomClause()
            highlightCurrentFunction()
            createEnglishNounPhraseOrderMorph()  //create for when it's needed
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
    
    struct LanguageButtonGroup : View {
        var body: some View {
            HStack{
                LanguageButton(buttonLanguage: .Spanish)
                LanguageButton(buttonLanguage: .French)
                LanguageButton(buttonLanguage: .English)
            }
        }
    }
    
    struct LanguageButton : View {
        let buttonLanguage : LanguageType
        
        init(buttonLanguage: LanguageType){
            self.buttonLanguage = buttonLanguage
        }
        
        var body: some View {
            GeometryReader { geometry in
                Button(action: {
                    m_currentLanguage = buttonLanguage
                    //setNewLanguage()
                    print(m_currentLanguage.rawValue)
                }){
                    Text(buttonLanguage.rawValue)
                        .bold()
                        .frame(width: 120, height: 40)
                        .font(m_currentLanguage == buttonLanguage ? .title : .title )
                        .foregroundColor(m_currentLanguage == buttonLanguage ? Color.red : Color(UIColor(named: "SurgeryBackground")!))
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        
    }
    
    func setNewLanguage(){
        if m_currentLanguage == .English { convertToEnglishWordOrder() }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: m_currentLanguage, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
   
    func setNewLanguage(language: LanguageType){
        m_currentLanguage = language
        if m_currentLanguage == .English { convertToEnglishWordOrder() }
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: m_currentLanguage, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
   
    func changeWord(){
        let single = singleList[currentSingleIndex]
        var wsd = single.getSentenceData()
        
        switch wsd.wordType {
        case .V:
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .None)
            single.copyGuts(newSingle: newSingle)
        case .Adj, .Det, .Adv, .C:
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .None)
            single.copyGuts(newSingle: newSingle)
        case .N:
            let nounSingle = single as! dNounSingle
            var newFunctionType = ContextFreeFunction.None
            if nounSingle.isSubject() { newFunctionType = .Subject }
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType : newFunctionType)
            nounSingle.copyGuts(newSingle: newSingle)
            if nounSingle.isSubject() {
                m_clause.setPerson(value: nounSingle.getPerson())
            }
        case .Pronoun:
            let ppSingle = single as! dPersonalPronounSingle
            var newFunctionType = ContextFreeFunction.None
            if ppSingle.isSubject() { newFunctionType = .Subject }
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType : newFunctionType)
            ppSingle.copyGuts(newSingle: newSingle)
            if ppSingle.isSubject() {
                m_clause.setPerson(value: ppSingle.getPerson())
            }
        case .P:
            let newSingle = m_randomPronounPhrase.m_randomWord.getAgnosticRandomWordAsSingle(wordType : wsd.wordType, functionType: .None)
            single.copyGuts(newSingle: newSingle)
        default: break
        }
        wsd = single.getSentenceData()
        m_clause.processInfo()
        currentPerson = m_clause.getPerson()
        sentenceString = m_clause.setTenseAndPersonAndCreateNewSentenceString(language: m_currentLanguage, tense: currentTense, person: currentPerson)
        updateCurrentSentenceViewStuff()
    }
    
    
    func createRandomClause(){
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
        var str = ""
        switch m_currentLanguage {
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
        if ( str.count > 0 ){
        print("createRandomClause: random clause = \(str)")
        }
        else {
            print("createRandomClause: random clause was not created.")
        }
        morphIndex = 0
        updateCurrentSentenceViewStuff()
    }
    
    func createEnglishNounPhraseOrderMorph(){
        m_englishPhraseCFMM = CFMorphModel(id: 0, modelName: "Convert Spanish Noun Phrases to English Order")
        m_englishPhraseCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "move", cfFromTypeString: "followingAdjective", cfToTypeString: "precedingAdjective"))
        m_englishPhraseCFMM.unpackJSONOperations()
        
    }
    
    func convertToEnglishWordOrder(){
        //var cfMorphSentence = CFMorphSentence(m_clause: m_clause)
        morphStruct.clear()
        //morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: m_englishPhraseCFMM)
    }
    
    func testCFMorphModel(){
//        var cfMorphSentence = CFMorphSentence(m_clause: m_clause)
        morphStruct.clear()
    
        //create the subject morph model first
        if checkboxSubject {
            var subjectCFMM = CFMorphModel(id: 0, modelName: "Convert simple Spanish subject phrases to subject pronouns")
            subjectCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "grab", cfFromTypeString: "subjectPhrase", cfToTypeString: ""))
            subjectCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "replace", cfFromTypeString: "subjectPhrase", cfToTypeString: "subjectPronoun"))
            subjectCFMM.unpackJSONOperations()
            //morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: subjectCFMM)
        }
        

        if checkboxDirectObject {
            var doCFMM = CFMorphModel(id: 1, modelName: "Convert simple Spanish DO phrases to DO pronouns")
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "grab", cfFromTypeString: "directObjectPhrase", cfToTypeString: ""))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "replace", cfFromTypeString: "directObjectPhrase", cfToTypeString: "directObjectPronoun"))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "move", cfFromTypeString: "directObjectPronoun", locationString: "precedingVerb"))
            doCFMM.unpackJSONOperations()
            //morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: doCFMM)
        }

        
        if checkboxIndirectObject {
            var doCFMM = CFMorphModel(id: 1, modelName: "Convert simple Spanish inDO phrases to inDO pronouns")
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "grab", cfFromTypeString: "indirectObjectPhrase", cfToTypeString: ""))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "replace", cfFromTypeString: "indirectObjectPhrase", cfToTypeString: "indirectObjectPronoun"))
            doCFMM.appendOperation(mp: MorphOperationJson(morphOperation: "move", cfFromTypeString: "indirectObjectPronoun", locationString: "precedingDOPronoun"))
            doCFMM.unpackJSONOperations()
            //morphStruct  = cfMorphSentence.applyMorphModel(language: currentLanguage, inputMorphStruct: morphStruct, cfMorphModel: doCFMM)
        }
        
    }
    
    func updateCurrentSentenceViewStuff(){
        
        singleList = m_clause.getSingleList()
        var index = 0
        for s in singleList {
            let singleString = s.getWordStringAtLanguage(language: m_currentLanguage)
            print ("Index \(index), word: \(singleString) ... cfFunction \(s.m_clusterFunction)")
            index += 1
        }
        
        m_clause.setWorkingSingleList(singleList: singleList)
        
        //Tests logic for parsing the current clause
        
        // - MARK: CF Morph Model Test
        
        processPronouns()
        //testCFMorphModel()

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
        subjectPronoun = m_clause.getPronounString(language: m_currentLanguage, type: .SUBJECT)
        directObjectPronoun = m_clause.getPronounString(language: m_currentLanguage, type: .DIRECT_OBJECT)
        indirectObjectPronoun = m_clause.getPronounString(language: m_currentLanguage, type: .INDIRECT_OBJECT)
        
        print("Subject pronoun: \(subjectPronoun) \nDirect object pronoun: \(directObjectPronoun) \nIndirect object pronoun: \(indirectObjectPronoun)")
        
        var result = m_clause.getCompositeSentenceString(language: m_currentLanguage, targetFunction: .Subject)
        let subjList = result.targetSingleList
        let subjString = result.targetString
        
        result = m_clause.getCompositeSentenceString(language: m_currentLanguage, targetFunction: .DirectObject)
        let doList = result.targetSingleList
        let doString = result.targetString
        
        result  = m_clause.getCompositeSentenceString(language: m_currentLanguage, targetFunction: .IndirectObject)
        let inDoList = result.targetSingleList
        let inDoString = result.targetString
        
        print("Subject string = \(subjString)")
        print("Direct string = \(doString)")
        print("Indirect object string = \(inDoString)")
        
        //print ("Subj count: \(subjList.count), doCount: \(doList.count), inDoCount: \(inDoList.count)")
        
        //MARK: <#singleList#>
        
        let singleList = m_clause.getSingleList()
        
        //fill the subjList indices ...subjectIndexList
        subjectIndexList.removeAll()
        for subj in subjList {
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
        for d in doList {
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
        //var singleListStart = 0
        for d in inDoList{
            for ssIndex in 0 ..< singleList.count {
                let single = singleList[ssIndex]
                if d == single {
                    indirectObjectIndexList.append(ssIndex)
                    //singleListStart = ssIndex+1
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
        case 0:  currentEquivalentPronoun = m_clause.getPronounString(language: m_currentLanguage, type: .SUBJECT)
            let result = m_clause.getCompositeSentenceString(language: m_currentLanguage, targetFunction: .Subject)
            currentString = result.targetString
        case 1:  currentEquivalentPronoun = m_clause.getPronounString(language: m_currentLanguage, type: .DIRECT_OBJECT)
            let result = m_clause.getCompositeSentenceString(language: m_currentLanguage, targetFunction: .DirectObject)
            currentString = result.targetString
        case 2:  currentEquivalentPronoun = m_clause.getPronounString(language: m_currentLanguage, type: .INDIRECT_OBJECT)
            let result = m_clause.getCompositeSentenceString(language: m_currentLanguage, targetFunction: .IndirectObject)
            currentString = result.targetString
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
        PersonalPronounGames(colors: [Color.red, Color.blue])
    }
}
