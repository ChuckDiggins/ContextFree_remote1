//
//  Unconjugate.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import Foundation

/*
func unConjugate(verbForm : String)->( BSpanishVerb, Tense, Person)  {
    var conjugateForm = ""
    //var verb = BSpanishVerb()
    
    var count = 0
    for verb in m_masterVerbList {
        for tense in Tense.indicativeAll {
            for person in Person.all {
                conjugateForm = verb.getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : false ).finalVerbForm()
                conjugateForm = VerbUtilities().removeLeadingOrFollowingBlanks(characterArray: conjugateForm)
                if conjugateForm == verbForm {
                    print("\(count) verb forms were searched")
                    return (verb, tense, person)
                }
                count += 1
            }
        }
        
        for tense in Tense.subjunctiveAll {
            for person in Person.all {
                conjugateForm = verb.getConjugatedMorphStruct(tense: tense, person: person, conjugateEntirePhrase : false ).finalVerbForm()
                conjugateForm = VerbUtilities().removeLeadingOrFollowingBlanks(characterArray: conjugateForm)
                if conjugateForm == verbForm {
                    print("\(count) verb forms were searched")
                    return (verb, tense, person)
                }
                count += 1
            }
        }
    }
    print("\(count) verb forms were searched")
    return (BSpanishVerb(), .present, .S1)
}
 */
