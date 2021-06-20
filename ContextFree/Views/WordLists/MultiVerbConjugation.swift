//
//  MultiVerbConjugation.swift
//  ContextFree
//
//  Created by Charles Diggins on 6/18/21.
//

import SwiftUI



//
//  VerbFormView.swift
//  VIperSpanish 2
//
//  Created by Charles Diggins on 12/2/20.
//

import Combine
import SwiftUI


struct MultiVerbConjugation: View {
    @EnvironmentObject var cfModelView : CFModelView
    
    @State private var language = LanguageType.English
    @State private var spanishVerb = SpanishVerb()
    @State private var frenchVerb = FrenchVerb()
    @State private var englishVerb = EnglishVerb()
    @State private var spanishPhrase = ""
    @State private var englishPhrase = ""
    @State private var frenchPhrase = ""
    @State var currentTenseString = ""
    @State var currentVerbString = ""
    @State var currentVerbPhrase = ""
    @State var newVerbPhrase = ""
    @State private var currentVerb = Verb()
    @State private var currentVerbNumber = 1
    @State private var verbCount = 0
    @State var currentIndex = 0
    @State var currentTense = Tense.present
    @State var personString = ["","","","","",""]
    @State var verb1String = ["","","","","",""]
    @State var verb2String = ["","","","","",""]
    @State var verb3String = ["","","","","",""]
    
    //swipe gesture
    
    @State var startPos : CGPoint = .zero
    @State var isSwiping = true
    @State var color = Color.red.opacity(0.4)
    @State var direction = ""
    
    //@State var bAddNewVerb = false
    
    var body: some View {
        //ChangeTenseButtonView()
        
        /*
         Button(action: {
         currentTenseString = currentTense.rawValue
         }){
         Text("Tense: \(currentTenseString)")
         //Image(systemName: "play.rectangle.fill").foregroundColor(.black)
         }
         .font(.callout)
         .padding(2)
         .background(Color.green)
         .foregroundColor(.white)
         .cornerRadius(4)
         */
        HStack{
            Button(action: {
                getPreviousVerb()
            }){
                Text("Prev verb").background(Color("Color1"))
                    .cornerRadius(8)
                    .font(.system(size: 24))
            }
            Button(action: {
                getNextVerb()
            }){
                Text("Next verb").background(Color("Color1"))
                    .cornerRadius(8)
                    .font(.system(size: 24))
            }
            
            .padding(5)
            
        }
        
        
        Spacer()
            .frame(height: 20)
        
        VStack {
            HStack{
                Text("  Verbs: ")
                Text(spanishPhrase)
                    .frame(width: 100, height: 30, alignment: .leading)
                    .background(Color.white)
                    .foregroundColor(.black)
                Text(frenchPhrase)
                    .frame(width: 100, height: 30, alignment: .leading)
                    .background(Color.white)
                    .foregroundColor(.black)
                Text(englishPhrase)
                    .frame(width: 100, height: 30, alignment: .leading)
                    .background(Color.white)
                    .foregroundColor(.black)
            }
            ForEach((0...5), id:\.self) { personIndex in
                HStack{
                    Text(personString[personIndex])
                        .frame(width: 60, height: 30, alignment: .trailing)
                    Text(verb1String[personIndex])
                        .frame(width: 100, height: 30, alignment: .leading)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                    Text(verb2String[personIndex])
                        .frame(width: 100, height: 30, alignment: .leading)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                    Text(verb3String[personIndex])
                        .frame(width: 100, height: 30, alignment: .leading)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                }
            }
        }.font(.system(size: 16))
        .onAppear(){
            cfModelView.createNewModel(language: .Spanish)
            currentIndex = cfModelView.getWordCount(wordType:  .verb)-1
            currentVerbNumber = currentIndex + 1
            let word = cfModelView.getListWord(index: currentIndex, wordType:  WordType.verb)
            currentVerb = word as! Verb
            verbCount = cfModelView.getWordCount(wordType:  .verb)
            fillPersons()
            showCurrentWordInfo()
        }
        .onTapGesture(count:2){
            getNextVerb()
        }
        .gesture(DragGesture()
                    .onChanged { gesture in
                        if self.isSwiping {
                            self.startPos = gesture.location
                            self.isSwiping.toggle()
                        }
                        print("Swiped")
                    }
                    .onEnded { gesture in
                        let xDist =  abs(gesture.location.x - self.startPos.x)
                        let yDist =  abs(gesture.location.y - self.startPos.y)
                        if self.startPos.y <  gesture.location.y && yDist > xDist {
                            self.direction = "Down"
                            self.color = Color.green.opacity(0.4)
                            getNextVerb()
                        }
                        else if self.startPos.y >  gesture.location.y && yDist > xDist {
                            self.direction = "Up"
                            self.color = Color.blue.opacity(0.4)
                            getPreviousVerb()
                        }
                        else if self.startPos.x > gesture.location.x && yDist < xDist {
                            self.direction = "Left"
                            self.color = Color.yellow.opacity(0.4)
                            getNextVerb()
                        }
                        else if self.startPos.x < gesture.location.x && yDist < xDist {
                            self.direction = "Right"
                            self.color = Color.purple.opacity(0.4)
                            getNextVerb()
                        }
                        self.isSwiping.toggle()
                        print("gesture here")
                    }
        )
        Spacer()
            .frame(height: 20)
        
    }
    
    
    func getNextVerb(){
        currentIndex += 1
        if currentIndex >= verbCount {
            currentIndex = 0
        }
        currentVerbNumber = currentIndex + 1
        let word =  cfModelView.getListWord(index: currentIndex, wordType:  .verb)
        currentVerb = word as! Verb
        verbCount = cfModelView.getWordCount(wordType:   WordType.verb)
        showCurrentWordInfo()
    }
    
    func getPreviousVerb(){
        currentIndex -= 1
        if currentIndex < 0 {currentIndex = verbCount-1}
        currentVerbNumber = currentIndex + 1
        let word = cfModelView.getListWord(index: currentIndex, wordType: .verb)
        currentVerb = word as! Verb
        verbCount = cfModelView.getWordCount(wordType:  WordType.verb)
        showCurrentWordInfo()
    }
    
    func  fillPersons(){
        switch language {
        case .English:
            personString[0] = "I"
            personString[1] = "you"
            personString[2] = "he"
            personString[3] = "we"
            personString[4] = "you"
            personString[5] = "they"
        case .Spanish:
            personString[0] = "yo"
            personString[1] = "tú"
            personString[2] = "él"
            personString[3] = "nosotros"
            personString[4] = "vosotros"
            personString[5] = "ellos"
        default: break
        }
        
    }
    
    func  showCurrentWordInfo(){
        let thisVerb = currentVerb
        spanishPhrase = thisVerb.getWordAtLanguage(language: .Spanish)
        englishPhrase = thisVerb.getWordAtLanguage(language: .English)
        frenchPhrase = thisVerb.getWordAtLanguage(language: .French)
        
        if analyzeSpanishVerb() {
            verb1String[0] = spanishVerb.getConjugateForm(tense: currentTense, person: .S1)
            verb1String[1] = spanishVerb.getConjugateForm(tense: currentTense, person: .S2)
            verb1String[2] = spanishVerb.getConjugateForm(tense: currentTense, person: .S3)
            verb1String[3] = spanishVerb.getConjugateForm(tense: currentTense, person: .P1)
            verb1String[4] = spanishVerb.getConjugateForm(tense: currentTense, person: .P2)
            verb1String[5] = spanishVerb.getConjugateForm(tense: currentTense, person: .P3)
        }
        if analyzeFrenchVerb() {
            verb2String[0] = frenchVerb.getConjugateForm(tense: currentTense, person: .S1)
            verb2String[1] = frenchVerb.getConjugateForm(tense: currentTense, person: .S2)
            verb2String[2] = frenchVerb.getConjugateForm(tense: currentTense, person: .S3)
            verb2String[3] = frenchVerb.getConjugateForm(tense: currentTense, person: .P1)
            verb2String[4] = frenchVerb.getConjugateForm(tense: currentTense, person: .P2)
            verb2String[5] = frenchVerb.getConjugateForm(tense: currentTense, person: .P3)
        }
        
        if analyzeEnglishVerb() {
            verb3String[0] = englishVerb.getConjugateForm(tense: currentTense, person: .S1)
            verb3String[1] = englishVerb.getConjugateForm(tense: currentTense, person: .S2)
            verb3String[2] = englishVerb.getConjugateForm(tense: currentTense, person: .S3)
            verb3String[3] = englishVerb.getConjugateForm(tense: currentTense, person: .P1)
            verb3String[4] = englishVerb.getConjugateForm(tense: currentTense, person: .P2)
            verb3String[5] = englishVerb.getConjugateForm(tense: currentTense, person: .P3)
        }
        
    }
    
    func analyzeSpanishVerb()->Bool{
        if frenchPhrase.count > 0 {
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .Spanish, verbPhrase: spanishPhrase)
            if result.0 {
                let verb = result.1  //BVerb
                let bSpanishVerb = verb as! BSpanishVerb
                spanishVerb = SpanishVerb(word: bSpanishVerb.m_verbWord, def: "", type: VerbType.normal)
                spanishVerb.setBVerb(bVerb: bSpanishVerb)
                return true
            }
        }
        return false
    }
    
    func analyzeFrenchVerb()->Bool{
        if frenchPhrase.count > 0 {
            let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .French, verbPhrase: frenchPhrase)
            if result.0 {
                let verb = result.1  //BVerb
                let bFrenchVerb = verb as! BFrenchVerb
                frenchVerb = FrenchVerb(word: bFrenchVerb.m_verbWord, def: "", type: VerbType.normal)
                frenchVerb.setBVerb(bVerb: bFrenchVerb)
                return true
            }
        }
        return false
    }
    
    func analyzeEnglishVerb()->Bool{
        if englishPhrase.count > 0 {let result = cfModelView.analyzeAndCreateBVerb_SPIFE(language: .English, verbPhrase: englishPhrase)
            if result.0 {
                let verb = result.1  //BVerb
                let bEnglishVerb = verb as! BEnglishVerb
                englishVerb = EnglishVerb(word: bEnglishVerb.m_verbWord, def: "", type: VerbType.normal)
                englishVerb.setBVerb(bVerb: bEnglishVerb)
                return true
            }
        }
        return false
    }
    
}

struct MultiVerbConjugation_Previews: PreviewProvider {
    static var previews: some View {
        MultiVerbConjugation()
    }
}
