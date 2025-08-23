//
//  TaskModelContainer.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData

/// @MainActor is a global actor that uses the main queue for executing its work.
/// In practice, this means methods or types marked with @MainActor can (for the most part) safely modify the UI
/// because it will always be running on the main queue,
/// and calling MainActor.run() will push some custom work of your choosing to the main actor, and thus to the main queue.
@MainActor
struct TaskModelContainer {
  static let shared: ModelContainer = {
    do {
      let container = try ModelContainer(for: Task.self)
      return container
    } catch {
      fatalError("Failed to crate ModelContainer: \(error)")
    }
  }()
}
