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

// @MainActor ensures this struct and its properties are accessed only on the main thread
// Critical for UI-related data operations
@MainActor
struct TaskModelContainer {
  // Singleton pattern: One shared container for the entire app
  // ModelContainer is like a database connection manager
  // - Manages the SQLite database file
  // - Provides ModelContext instances for data operations
  // - Handles schema migrations and data persistence
  static let shared: ModelContainer = {
    do {
      // Create container for Task model
      // This sets up the underlying SQLite database with Task schema
      let container = try ModelContainer(for: Task.self)
      return container
    } catch {
      // Fatal error if database setup fails - app cannot function without persistence
      fatalError("Failed to crate ModelContainer: \(error)")
    }
  }()
}
