//
//  util.swift
//  Overwatch Failure
//
//  Created by Jessica Wu on 3/21/21.
//

import Foundation

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

