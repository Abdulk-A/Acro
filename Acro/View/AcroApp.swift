//
//  AcroApp.swift
//  Acro
//
//  Created by Abdullah on 10/2/25.
//

import SwiftUI
import SwiftData

@main
struct AcroApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Acronym.self)
    }
}
