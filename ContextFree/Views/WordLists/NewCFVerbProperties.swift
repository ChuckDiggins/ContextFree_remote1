//
//  NewVerbProperties.swift
//  ContextFree
//
//  Created by Charles Diggins on 5/10/21.
//

import SwiftUI


struct NewCFVerbProperties: View {
    @EnvironmentObject var cfModelView : CFModelView
    @State private var currentVerbPhrase = "verb"
    @State  var englishPhrase = ""
    @State  var frenchPhrase = ""
    @State private var patternString = "19"
    @State private var patternNumber = 0
    @State private var currentIndex = 0
    @State private var currentVerb = Verb()
    @State private var currentVerbNumber = 1
    @State private var verbCount = 0
    @State private var def = ""
    
    @State private var verbTypeList = [String]()
    @State private var subj = [String]()
    @State private var obj = [String]()
    
    @State private var transitivityIndex = 0
    @State private var passivityIndex = 0
    
    @State private var wordIsChanged = false
    
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
    
    let subjObjLayout = [GridItem(.adaptive(minimum:80))]
    
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Button(action: {
                        if wordIsChanged {
                            saveWord()
                        }
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
                            .font(.system(size: 24))
                    }
                    Button(action: {
                        if wordIsChanged {
                            saveWord()
                        }
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
                            .font(.system(size: 24))
                    }
                    
                    .padding(5)
                    
                }
                Text("Spanish: \(currentVerbNumber) of \(verbCount)").padding(10)
                Text("Spanish phrase: \(currentVerbPhrase)").padding(10)
                HStack{
                    Text("English:")
                    TextField("English phrase:", text: $englishPhrase)
                        .background(Color.white)
                        .padding(.trailing,5 )
                        .disableAutocorrection(true)
                }
                HStack{
                    Text("French:")
                    TextField("French phrase:", text: $frenchPhrase)
                        .background(Color.white)
                        .padding(.trailing,5 )
                        .disableAutocorrection(true)
                }
                Text("Bescherrelle pattern: \(patternString)")
            }.background(Color("Color4"))
            
            List{
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
            currentIndex = cfModelView.getVerbCount()-1
            let word = cfModelView.getListWord(index: currentIndex, wordType:  WordType.verb)
            currentVerb = word as! Verb
            currentIndex += 1
            verbCount = cfModelView.getWordCount(wordType:  .verb)
            showCurrentWordInfo()
        }
    }
    
    func saveWord(){
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
        
        currentVerb.updateWords(english: englishPhrase, french: frenchPhrase)
        //currentVerb.updateTransitivity(trans : getTransitivity(index: transitivityIndex))
        currentVerb.updatePassivity(pass : getPassivity(index: passivityIndex))
        currentVerb.updateVariables(vType: verbTypeList, subj : subj, obj : obj)
        let jsonVerb = currentVerb.createJsonVerb(bNumber: patternNumber)
        print(jsonVerb)
        //cfModelView.appendJsonVerb(jsonVerb: jsonVerb)
    }
    
    func showCurrentWordInfo(){
        wordIsChanged = false
        let thisVerb = currentVerb
        currentVerbPhrase = thisVerb.getBVerb().getPhrase()
        englishPhrase = "to " + thisVerb.getWordAtLanguage(language: .English)
        frenchPhrase = thisVerb.getWordAtLanguage(language: .French)
        //var spPhrase = thisVerb.getWordAtLanguage(language: .Spanish)
        
        let romanceBVerb = thisVerb.getBVerb() as! BRomanceVerb
        patternString = romanceBVerb.getBescherelleInfo()
        
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
    
    
    func setRadioOptionTrue(list: [VerbOption], index : Int)->[VerbOption]{
        var listCopy = list
        for i in 0 ..< listCopy.count {
            listCopy[i].isSelected = false
        }
        listCopy[index].isSelected = true
        
        return listCopy
    }
}


struct NewCFVerbProperties_Previews: PreviewProvider {
    static var previews: some View {
        NewCFVerbProperties()
    }
}

