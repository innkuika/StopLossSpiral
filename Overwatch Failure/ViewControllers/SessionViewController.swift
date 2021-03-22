//
//  ViewController.swift
//  Overwatch Failure
//
//  Created by Jessica Wu on 1/17/21.
//

import UIKit


class SessionViewController: UIViewController {
    // passed in
    var template: GameSessionTemplate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    @IBOutlet weak var LossNumberTextOutlet: UITextField!
    @IBOutlet weak var PlayNumberTextOutlet: UITextField!
    
    @IBOutlet weak var CurLossNumber: UILabel!
    @IBOutlet weak var CurPlayNumber: UILabel!
    
    @IBAction func LossNumberTextEditing(_ sender: Any) {
        let num: Int? = Int(LossNumberTextOutlet.text ?? "")
        if num == nil && LossNumberTextOutlet.text != ""{
            LossNumberTextOutlet.text = "2"
        }
    }
    @IBAction func PlayNumberTextEditing(_ sender: Any) {
        let num: Int? = Int(PlayNumberTextOutlet.text ?? "")
        if num == nil && PlayNumberTextOutlet.text != ""{
            PlayNumberTextOutlet.text = "5"
        }
    }
    
    @IBAction func LossButton(_ sender: Any) {
        let curLossNum = Int(CurLossNumber.text ?? "0") ?? 0
        CurLossNumber.text = String(curLossNum + 1)
        
        let curPlayNum = Int(CurPlayNumber.text ?? "0") ?? 0
        CurPlayNumber.text = String(curPlayNum + 1)
        
        let TotalPlayNumber = Int(PlayNumberTextOutlet.text ?? "0") ?? 0
        let TotalLossNumber = Int(LossNumberTextOutlet.text ?? "0") ?? 0
        
        if TotalLossNumber <= curLossNum + 1 || TotalPlayNumber <= curPlayNum + 1{
            performSegue(withIdentifier: "stopViewSegue", sender: nil)
        }
    }
    
    @IBAction func WinButton(_ sender: Any) {
        CurLossNumber.text = "0"
        
        let curPlayNum = Int(CurPlayNumber.text ?? "0") ?? 0
        CurPlayNumber.text = String(curPlayNum + 1)
        
        let curLossNum = Int(CurLossNumber.text ?? "0") ?? 0
        
        let TotalPlayNumber = Int(PlayNumberTextOutlet.text ?? "0") ?? 0
        let TotalLossNumber = Int(LossNumberTextOutlet.text ?? "0") ?? 0
        
        if TotalLossNumber <= curLossNum || TotalPlayNumber <= curPlayNum + 1{
            performSegue(withIdentifier: "stopViewSegue", sender: nil)
        }
    }
    
    
}

