//
//  AlertNewPhraseName.swift
//  AlertNewPhraseName
//
//  Created by Charles Diggins on 1/19/22.
//

import Foundation

struct AlertNewPhraseName {
    func getPhraseNameAlert(){
        let alert = UIAlertController(title: "Phrase name:", message: "Enter the name here", preferredStyle: .alert)
        alert.addTextField{ (pass) in
            pass.isSecureTextEntry = false
            pass.placeholder = "name"
        }
        
        let answerButton = UIAlertAction(title: "Answer", style: .default){ (_) in
            // do something here
            //cellString = alert.textFields![0].text!
            //        foregroundColor = Color.yellow
            //        backgroundColor = Color.purple
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive){ (_) in
            //same
        }
        alert.addAction(cancelButton)
        alert.addAction(answerButton)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            //do something here
        })
    }
}
