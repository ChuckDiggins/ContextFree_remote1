//
//  AddVerbToDictionary.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/11/21.
//
//
// adds a multilingual verb to the shared dictionary
//

import SwiftUI


struct AddVerbToDictionary: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var spanishPhrase = ""
    @State private var englishPhrase = ""
    @State private var frenchPhrase = ""
    @State private var spanishPatternString = "Pattern:   "
    @State private var frenchPatternString = "Pattern:   "
    @State private var englishPatternString = "Pattern:   "
    @State private var currentIndex = 0
    @State private var currentVerbNumber = 1
    @State private var currentVerb = Verb()
    @State private var verbCount = 0
    @State private var def = ""
    
    @State private var verbTypeList = [String]()
    @State private var subj = [String]()
    @State private var obj = [String]()
    
    @State private var transitivityIndex = 0
    @State private var passivityIndex = 0
    
    @State private var wordIsChanged = false
    
    @State private var all3WordsAreFilled = false
    @State private var okToSave = false
    
    @State private var spanishVerb = SpanishVerb()
    @State private var frenchVerb = FrenchVerb()
    @State private var englishVerb = EnglishVerb()
    @State private var alertIsPresented = false
    @State private var badVerb = "Spanish"
    @State private var messageToUser = "Fill in all 3 verb forms to create a new multi-verb"
    
    struct VerbOption : Identifiable {
        var id : Int
        var name: String
        var isSelected: Bool = true
    }
    
    @State var verbType : [VerbOption] = [
        VerbOption(id: 0, name: "Regular"),
        VerbOption(id: 1, name: "Auxiliary", isSelected: false),
        VerbOption(id: 2, name: "Connecting", isSelected: false),
        VerbOption(id: 3, name: "Helping", isSelected: false),
        VerbOption(id: 4, name: "Modal", isSelected: false),
        VerbOption(id: 5, name: "Phrasal", isSelected: false)]
    
    @State var transitivityList : [VerbOption] = [VerbOption(id: 0, name: "Transitive"),  //I hit the ball
                                                  VerbOption(id: 1, name: "Ditransitive", isSelected: false),  //She gave Tom the ball
                                                  VerbOption(id: 2, name: "Intransitive", isSelected: false),  //I dream
                                                  VerbOption(id: 3, name: "Ambitransitive", isSelected: false) ]//I read, I read the book
    
    
    @State var passivityList : [VerbOption] = [VerbOption(id: 0, name: "Active"),
                                               VerbOption(id: 1, name: "Passive", isSelected: false),
                                               VerbOption(id: 2, name: "Both", isSelected: false)]
    
    
    
    //favorite subjects and objects for this verb
    
    @State var subjectivity : [VerbOption] = [VerbOption(id: 0, name: "Person", isSelected: false),
                                              VerbOption(id: 1, name: "Animal", isSelected: false),
                                              VerbOption(id: 2, name: "Place", isSelected: false),
                                              VerbOption(id: 3, name: "Furniture", isSelected: false),
                                              VerbOption(id: 4, name: "Concept", isSelected: false),
                                              VerbOption(id: 5, name: "Plant", isSelected: false),
                                              VerbOption(id: 6, name: "Thing", isSelected: false),
                                              VerbOption(id: 7, name: "Legal entity", isSelected: false),
                                              VerbOption(id: 8, name: "Activity", isSelected: false)]
    
    @State var objectivity : [VerbOption] = [VerbOption(id: 0, name: "Person", isSelected: false),
                                             VerbOption(id: 1, name: "Animal", isSelected: false),
                                             VerbOption(id: 2, name: "Place", isSelected: false),
                                             VerbOption(id: 3, name: "Furniture", isSelected: false),
                                             VerbOption(id: 4, name: "Concept", isSelected: false),
                                             VerbOption(id: 5, name: "Plant", isSelected: false),
                                             VerbOption(id: 6, name: "Thing", isSelected: false),
                                             VerbOption(id: 7, name: "Legal entity", isSelected: false),
                                             VerbOption(id: 8, name: "Activity", isSelected: false)]
    
    let subjObjLayout = [GridItem(.adaptive(minimum: 80), spacing: 0)]
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    currentIndex -= 1
                    if currentIndex < 0 {currentIndex = verbCount-1}
                    currentVerbNumber = currentIndex + 1
                    let word = cfModelView.getListWord(index: currentIndex, wordType: .verb)
                    currentVerb = word as! Verb
                    verbCount = cfModelView.getWordCount(wordType:  WordType.verb)
                    showCurrentWordInfo()
                }){
                    Text("Prev verb").background(Color("Color1"))
                        .cornerRadius(8)
                        .font(.system(size: 16))
                }
                Button(action: {
                    currentIndex += 1
                    if currentIndex >= verbCount {
                        currentIndex = 0
                    }
                    currentVerbNumber = currentIndex + 1
                    let word =  cfModelView.getListWord(index: currentIndex, wordType:  .verb)
                    currentVerb = word as! Verb
                    verbCount = cfModelView.getWordCount(wordType:   WordType.verb)
                    showCurrentWordInfo()
                }){
                    Text("Next verb").background(Color("Color1"))
                        .cornerRadius(8)
                        .font(.system(size: 16))
                }
                
                .padding(5)
                
            }
            Text(messageToUser).font(.system(size: 16).weight(.bold))
                .padding()
            VStack{
                HStack{
                    Button(action: {
                        currentVerbNumber = 0
                        frenchPhrase = ""
                        spanishPhrase = ""
                        englishPhrase = ""
                        spanishPatternString = ""
                        frenchPatternString = ""
                        okToSave = false
                        all3WordsAreFilled = false
                        messageToUser = "New verb and info were saved"
                    }){
                        Text("New verb")
                            .padding(5)
                            .background(Color.yellow)
                            .cornerRadius(8)
                            .font(.system(size: 16))
                    }


                    Text("Verb: \(currentVerbNumber) of \(verbCount)").padding(10)

                }
                HStack{
                    Text("Spanish:")
                    TextField("Spanish phrase:", text: $spanishPhrase)
                        .background(Color.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Text(spanishPatternString)
                }.padding(2)
                HStack{
                    Text("French :")
                    TextField("French phrase:", text: $frenchPhrase)
                        .background(Color.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Text(frenchPatternString)
                }.padding(2)
                HStack{
                    Text("English:")
                    TextField("English phrase:", text: $englishPhrase)
                        .background(Color.white)
                        .padding(.trailing,5 )
                        //.disableAutocorrection(true)
                        .autocapitalization(.none)
                    Text(englishPatternString)
                }.padding(3)
            }.background(Color("Color4"))
            
            HStack{
                Button(action: {
                    all3WordsAreFilled = true
                    if spanishPhrase.isEmpty || frenchPhrase.isEmpty || englishPhrase.isEmpty {
                        all3WordsAreFilled = false
                    }
                    if all3WordsAreFilled {
                        if analyzeFrenchVerb() && analyzeSpanishVerb() {
                            okToSave = true
                            messageToUser = "Fill in verb info below"
                        }
                    }
                }){
                    Text("Analyze")
                        .padding(10)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .font(.system(size: 16))
/*
                        //add alert for verb is not legal
                        
                        .alert(isPresented: $alertIsPresented, content: {
                            Alert(title: Text("Verb cannot be added!"), message: Text("This \(badVerb) verb already exists or is illegal"),
                                  dismissButton: .default(Text("OK!")))
                        })
 */
                }
                //.padding(5)

                Button(action: {
                    if okToSave {
                        saveWord()
                    }
                }){
                    Text("   Save   ")
                        .padding(10)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .font(.system(size: 16))
                    
                }
                
                Button(action: {
                   print("coming soon")
                }){
                    Text("   Edit   ")
                        .padding(10)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .font(.system(size: 16))
                    
                }
                Button(action: {
                    print("coming soon")
                    }){
                    Text(" Delete ")
                        .padding(10)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .font(.system(size: 16))
                    
                }
                //.padding(5)
            }
            
            
            List{
                
                VStack{
                    Text("Transitivity:").font(.caption).fontWeight(.bold)
                    LazyVGrid(columns: subjObjLayout){
                        ForEach(0..<transitivityList.count){ index in
                            HStack {
                                Button(action: {
                                    wordIsChanged = true
                                    transitivityList[index].isSelected = transitivityList[index].isSelected ? false : true
                                    if transitivityList[index].isSelected {
                                        transitivityList = setRadioOptionTrue(list: transitivityList, index: index)
                                        transitivityIndex = index
                                    }
                                }) {
                                    HStack{
                                        if transitivityList[index].isSelected {
                                            Image(systemName: "circle.fill")
                                                .foregroundColor(.green)
                                                .animation(.easeIn)
                                        } else {
                                            Image(systemName: "circle")
                                                .foregroundColor(.primary)
                                                .animation(.easeOut)
                                        }
                                        Text(transitivityList[index].name)
                                    }
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }.font(.caption)
                    .padding(1)
                }.background(Color("Color2"))
                VStack {
                    Text("Passivity:").font(.caption).fontWeight(.bold)
                    LazyVGrid(columns: subjObjLayout){
                        ForEach(0..<passivityList.count){ index in
                            HStack {
                                Button(action: {
                                    wordIsChanged = true
                                    passivityList[index].isSelected = passivityList[index].isSelected ? false : true
                                    if passivityList[index].isSelected {
                                        passivityList = setRadioOptionTrue(list: passivityList, index: index)
                                        passivityIndex = index
                                    }
                                }) {
                                    HStack{
                                        if passivityList[index].isSelected {
                                            
                                            Image(systemName: "circle.fill")
                                                .foregroundColor(.green)
                                                .animation(.easeIn)
                                        } else {
                                            Image(systemName: "circle")
                                                .foregroundColor(.primary)
                                                .animation(.easeOut)
                                        }
                                        Text(passivityList[index].name)
                                    }
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }.font(.caption)
                }.background(Color("Color2"))
                
                VStack{
                    Text("Verb types (select one or more):").font(.caption).fontWeight(.bold)
                    LazyVGrid(columns: subjObjLayout, spacing: 10){
                        ForEach(0..<verbType.count){ index in
                            HStack {
                                Button(action: {
                                    wordIsChanged = true
                                    verbType[index].isSelected = verbType[index].isSelected ? false : true
                                }) {
                                    HStack{
                                        if verbType[index].isSelected {
                                            Image(systemName: "checkmark.square.fill")
                                                .foregroundColor(.red)
                                                .animation(.easeIn)
                                        } else {
                                            Image(systemName: "square")
                                                .foregroundColor(.primary)
                                                .animation(.easeOut)
                                        }
                                        Text(verbType[index].name).font(.caption)
                                    }
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }.font(.caption)
                }.background(Color("Color2"))
                
                VStack{
                    Text("Favorite subjects:").font(.caption).fontWeight(.bold)
                    LazyVGrid(columns: subjObjLayout, spacing: 10){
                        ForEach(0..<subjectivity.count){ index in
                            HStack {
                                Button(action: {
                                    wordIsChanged = true
                                    subjectivity[index].isSelected = subjectivity[index].isSelected ? false : true
                                }) {
                                    HStack{
                                        if subjectivity[index].isSelected {
                                            Image(systemName: "checkmark.square.fill")
                                                .foregroundColor(.red)
                                                .animation(.easeIn)
                                        } else {
                                            Image(systemName: "square")
                                                .foregroundColor(.primary)
                                                .animation(.easeOut)
                                        }
                                        Text(subjectivity[index].name).font(.caption)
                                    }
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }.background(Color("Color4"))
                
                VStack{
                    Text("Favorite objects:").font(.caption).fontWeight(.bold)
                    LazyVGrid(columns: subjObjLayout, spacing: 10){
                        ForEach(0..<objectivity.count){ index in
                            HStack {
                                Button(action: {
                                    wordIsChanged = true
                                    objectivity[index].isSelected = objectivity[index].isSelected ? false : true
                                }) {
                                    HStack{
                                        if objectivity[index].isSelected {
                                            Image(systemName: "checkmark.square.fill")
                                                .foregroundColor(.red)
                                                .animation(.easeIn)
                                        } else {
                                            Image(systemName: "square")
                                                .foregroundColor(.primary)
                                                .animation(.easeOut)
                                        }
                                        Text(objectivity[index].name).font(.caption)
                                    }
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }.background(Color("Color4"))
            }//end of Form
            
            Spacer()
            
            
        }.onAppear{
            cfModelView.createNewModel(language: .Spanish)
            currentIndex = cfModelView.getWordCount(wordType:  .verb)-1
            currentVerbNumber = currentIndex + 1
            let word = cfModelView.getListWord(index: currentIndex, wordType:  WordType.verb)
            currentVerb = word as! Verb
            verbCount = cfModelView.getWordCount(wordType:  .verb)
            showCurrentWordInfo()
        }
    }
    
    func saveWord(){
            saveCompositeWord()
            okToSave = false
            all3WordsAreFilled = false
            messageToUser = "Verb and semantic info were saved"
    }
    
    func showCurrentWordInfo(){
        wordIsChanged = false
        let thisVerb = currentVerb
        //spanishPhrase = thisVerb.getBVerb().getPhrase()
        spanishPhrase = thisVerb.getWordAtLanguage(language: .Spanish)
        englishPhrase = thisVerb.getWordAtLanguage(language: .English)
        frenchPhrase = thisVerb.getWordAtLanguage(language: .French)
        
        analyzeFrenchVerb()
        analyzeSpanishVerb()
        analyzeEnglishVerb()

        
        for i in 0..<transitivityList.count{ transitivityList[i].isSelected = false }
        transitivityList[thisVerb.transitivity.rawValue].isSelected = true
        for i in 0..<passivityList.count{ passivityList[i].isSelected = false }
        passivityList[thisVerb.passivity.rawValue].isSelected = true
        
        for i in 0..<subjectivity.count {subjectivity[i].isSelected = false}
        for f in thisVerb.getFavoriteSubjects() { subjectivity[f.rawValue].isSelected = true }
        
        for i in 0..<objectivity.count {objectivity[i].isSelected = false}
        for f in thisVerb.getFavoriteObjects() {objectivity[f.rawValue].isSelected = true}
        
        for i in 0..<verbType.count {verbType[i].isSelected = false}
        //var vt = thisVerb.getVerbTypes()
       
        for f in thisVerb.getVerbTypes() {
            //exclude a phrase separable and impersonal
            if ( f.rawValue < 6 ){
                verbType[f.rawValue].isSelected = true
            }
        }
    }
    
    func analyzeSpanishVerb()->Bool{
        let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .Spanish, verbPhrase: spanishPhrase)
        if result.0 {
            let verb = result.1  //BVerb
            let bSpanishVerb = verb as! BSpanishVerb
            spanishPatternString = bSpanishVerb.getBescherelleInfo()
            spanishVerb = SpanishVerb(word: bSpanishVerb.m_verbWord, def: "", type: VerbType.normal)
            spanishVerb.setBVerb(bVerb: bSpanishVerb)
            return true
        }
        else {
            badVerb = "Spanish"
            self.alertIsPresented = true
        }
        return false
    }
    
    func analyzeFrenchVerb()->Bool{
        let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .French, verbPhrase: frenchPhrase)
        if result.0 {
            let verb = result.1  //BVerb
            let bFrenchVerb = verb as! BFrenchVerb
            frenchPatternString = bFrenchVerb.getBescherelleInfo()
            frenchVerb = FrenchVerb(word: bFrenchVerb.m_verbWord, def: "", type: VerbType.normal)
            frenchVerb.setBVerb(bVerb: bFrenchVerb)
            return true
        }
        else {
            badVerb = "French"
            self.alertIsPresented = true
        }
        return false
    }
    
    func analyzeEnglishVerb()->Bool{
        let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .English, verbPhrase: englishPhrase)
        if result.0 {
            let verb = result.1  //BVerb
            let bEnglishVerb = verb as! BEnglishVerb
            englishPatternString = bEnglishVerb.getBescherelleInfo()
            englishVerb = EnglishVerb(word: bEnglishVerb.m_verbWord, def: "", type: VerbType.normal)
            englishVerb.setBVerb(bVerb: bEnglishVerb)
            return true
        }
        else {
            badVerb = "English"
            self.alertIsPresented = true
        }
        return false
    }
    
    func addVerbsToDictionary(){
        cfModelView.append(spanishVerb : spanishVerb, frenchVerb : frenchVerb )
    }
    
    func saveCompositeWord(){
        //adds the spanish and french verbs to the dictionary for the current lanugage
        addVerbsToDictionary()
        
        subj.removeAll()
        for s in subjectivity {
            if s.isSelected {
                subj.append(getNounTypeStringAtIndex(index: s.id))
            }
        }
        //collect the favorite objects
        obj.removeAll()
        for o in objectivity {
            if o.isSelected {
                obj.append(getNounTypeStringAtIndex(index: o.id))
            }
        }
        //collect the favorite objects
        verbTypeList.removeAll()
        for v in verbType {
            if v.isSelected {
                verbTypeList.append(getVerbTypeAsLetter(index: v.id))
            }
        }
        
        var currentVerb = Verb(spanish: spanishPhrase, french: frenchPhrase, english: englishPhrase)
        currentVerb.updateTransitivity(trans : getTransitivity(index: transitivityIndex))
        currentVerb.updatePassivity(pass : getPassivity(index: passivityIndex))
        currentVerb.updateVariables(vType: verbTypeList, subj : subj, obj : obj)
        let jsonVerb = currentVerb.createJsonVerb()
        print(jsonVerb)
        verbCount = cfModelView.appendJsonVerb(jsonVerb: jsonVerb)
        currentIndex = cfModelView.getVerbCount()-1
        currentVerbNumber = currentIndex
        let word = cfModelView.getListWord(index: currentIndex, wordType: .verb)
        currentVerb = word as! Verb
        verbCount = cfModelView.getWordCount(wordType:  WordType.verb)
        showCurrentWordInfo()
    }
    
    func setRadioOptionTrue(list: [VerbOption], index : Int)->[VerbOption]{
        var listCopy = list
        for i in 0 ..< listCopy.count {
            listCopy[i].isSelected = false
        }
        listCopy[index].isSelected = true
        
        return listCopy
    }
}


struct AddVerbToDictionary_Previews: PreviewProvider {
    static var previews: some View {
        AddVerbToDictionary()
    }
}
