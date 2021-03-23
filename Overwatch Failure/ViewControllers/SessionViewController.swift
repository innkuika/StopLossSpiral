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

    @IBOutlet weak var LossNumberTextOutlet: UITextField!
    @IBOutlet weak var PlayNumberTextOutlet: UITextField!
    
    @IBOutlet weak var CurLossNumber: UILabel!
    @IBOutlet weak var CurPlayNumber: UILabel!
    
    @IBOutlet weak var WinButtonOutlet: UIButton!
    @IBOutlet weak var LossButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        LossNumberTextOutlet.isUserInteractionEnabled = false
        PlayNumberTextOutlet.isUserInteractionEnabled = false
        guard let template = template else {
            assertionFailure("cannot find template")
            return
        }
        LossNumberTextOutlet.text = "\(template.lossInRow)"
        PlayNumberTextOutlet.text = "\(template.totalMatch)"
        navigationItem.title = template.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        WinButtonOutlet.layer.cornerRadius = 20
        LossButtonOutlet.layer.cornerRadius = 20

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

