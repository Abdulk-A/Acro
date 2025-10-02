//
//  Acronyms.swift
//  Acro
//
//  Created by Abdullah on 10/2/25.
//

import Foundation
import SwiftData

@Model
class Acronym {
    var name: String
    var definitions: [String]

    init(name: String, definitions: [String]) {
        self.name = name
        self.definitions = definitions
    }
}
