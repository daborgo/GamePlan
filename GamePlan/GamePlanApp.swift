//
//  GamePlanApp.swift
//  GamePlan
//
//  Created by Diego Borgo on 10/24/25.
//

import SwiftUI
import SwiftData

@main
struct GamePlanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for: Event.self)
        }
    }
}
