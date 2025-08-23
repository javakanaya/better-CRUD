//
//  BetterCRUDApp.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 17/08/25.
//

import SwiftData
import SwiftUI

@main
struct BetterCRUDApp: App {
  var body: some Scene {
    WindowGroup {
      TaskListView(context: TaskModelContainer.shared.mainContext)
    }
    .modelContainer(TaskModelContainer.shared)
  }
}
