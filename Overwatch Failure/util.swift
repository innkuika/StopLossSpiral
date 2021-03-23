//
//  util.swift
//  Overwatch Failure
//
//  Created by Jessica Wu on 3/21/21.
//

import Foundation
import UIKit

struct defaultsKeys {
    static let GameSessionTemplatesKey = "GameSessionTemplates"
}

struct GameSessionTemplate: Codable {
    var name: String
    var totalMatch: Int
    var lossInRow: Int
}

struct GameSessionTemplates: Codable {
    var templates: [GameSessionTemplate]
}

func styleButton(button: UIButton){
    button.layer.cornerRadius = 10
    button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 25)
    button.titleLabel?.textColor = UIColor.systemBackground
}

let myPurple = UIColor(red: 183/255, green: 196/255, blue: 253/255, alpha: 1.0)
