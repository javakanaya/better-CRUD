//
//  BetterCRUDApp.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 17/08/25.
//

import SwiftData
import SwiftUI

// @main: Marks this as the app's entry point
@main
struct BetterCRUDApp: App {
  var body: some Scene {
    WindowGroup {
      // Root view of the app - ContentView with TabView containing TaskListView and other tabs
      // This establishes the connection between SwiftData and the UI through the context
      ContentView(context: TaskModelContainer.shared.mainContext)
    }
    // .modelContainer: Provides the SwiftData container to the entire view hierarchy
    // This enables SwiftData functionality throughout the app
    .modelContainer(TaskModelContainer.shared)
  }
}
