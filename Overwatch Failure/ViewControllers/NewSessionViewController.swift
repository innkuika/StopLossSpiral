//
//  NewSessionViewController.swift
//  Overwatch Failure
//
//  Created by Jessica Wu on 3/21/21.
//

import Foundation
import UIKit

class NewSessionViewController: UIViewController {
    @IBOutlet weak var templateSwitchOutlet: UISwitch!
    @IBOutlet weak var nameTextfieldOutlet: UITextField!
    @IBOutlet weak var totalMatchTextFieldOutlet: UITextField!
    @IBOutlet weak var LossInRowTextFieldOutlet: UITextField!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var errorMessageLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // ui stuff
        templateSwitchOutlet.onTintColor = myPurple
        styleButton(button: startButtonOutlet)
        errorMessageLabelOutlet.text = ""
    }
    @IBAction func startButtonPressed(_ sender: Any) {
        let totalMatchNumber = Int(totalMatchTextFieldOutlet.text ?? "-1") ?? -1
        let lossInRowNumber = Int(LossInRowTextFieldOutlet.text ?? "-1") ?? -1
        if totalMatchNumber <= 0 {
            errorMessageLabelOutlet.text = "Total Match Number Invalid"
        } else if lossInRowNumber <= 0 {
            errorMessageLabelOutlet.text = "Loss in Row Number Invalid"
        } else {
            var gameName = nameTextfieldOutlet.text ?? "Untitled"
            if gameName.trimmingCharacters(in: .whitespaces).isEmpty {
                gameName = "Untitled"
            }
            
            let gameTemplate = GameSessionTemplate(name: gameName, totalMatch: totalMatchNumber, lossInRow: lossInRowNumber)
            
            // save to user default if necessary
            if templateSwitchOutlet.isOn {
                let defaults = UserDefaults.standard
                if let savedTemplates = defaults.object(forKey: defaultsKeys.GameSessionTemplatesKey) as? Data {
                    let decoder = JSONDecoder()
                    if let loadedTemplates = try? decoder.decode(GameSessionTemplates.self, from: savedTemplates) {
                        var gameTemplates = loadedTemplates.templates
                        gameTemplates.append(gameTemplate)
                        
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(GameSessionTemplates(templates: gameTemplates)) {
                            let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: defaultsKeys.GameSessionTemplatesKey)
                        }
                    }
                }
            }
            
           // navigate to sessionViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let SessionViewController = storyboard.instantiateViewController(identifier: "SessionViewController") as? SessionViewController else {
                assertionFailure("cannot instantiate SessionViewController")
                return
            }
            SessionViewController.template = gameTemplate
            navigationController?.pushViewController(SessionViewController, animated: true)
        }
    }
    
    
    
}
