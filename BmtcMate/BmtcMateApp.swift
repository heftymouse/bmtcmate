//
//  BmtcMateApp.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 10/06/23.
//

import SwiftUI
import SwiftData

@main
struct BmtcMateApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
