//
//  StopViewControlloer.swift
//  Overwatch Failure
//
//  Created by Jessica Wu on 1/17/21.
//

import Foundation
import UIKit


class StopViewController: UIViewController {


    @IBOutlet weak var CreditTextOutlet: UITextView!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        let attributedString = NSMutableAttributedString(string: "Web version of this app is available at \n https://overwatch.fail")
        attributedString.addAttribute(.link, value: "https://overwatch.fail", range: NSRange(location: 42, length: 22))

        CreditTextOutlet.attributedText = attributedString
        CreditTextOutlet.textColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        CreditTextOutlet.textAlignment = NSTextAlignment.center
      }

      func CreditTextOutlet(_ CreditTextOutlet: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
          UIApplication.shared.open(URL)
          return false
      }
    
}

