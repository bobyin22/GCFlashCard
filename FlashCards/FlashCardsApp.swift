//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

@main
struct FlashCardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
