//
//  TaskViewModel.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import Foundation
import SwiftData

// @MainActor: All methods and properties run on main thread (required for UI updates)
// ObservableObject: Makes this class observable by SwiftUI views
// This is the "ViewModel" in MVVM - contains business logic and manages data state
@MainActor
class TaskViewModel: ObservableObject {
  // ModelContext: The "workspace" for database operations
  // Think of it as a session where you perform CRUD operations
  private var context: ModelContext

  // @Published: Automatically notifies SwiftUI views when this array changes
  // This creates the reactive connection between data and UI
  @Published var tasks: [Task] = []

  // Dependency injection: Context is provided from outside (usually from a View)
  // This makes the ViewModel testable and flexible
  init(context: ModelContext) {
    self.context = context
    fetchTasks() // Load initial data when ViewModel is created
  }

  // CRUD Operation: READ
  // FetchDescriptor: Defines how to query the database
  // Similar to "SELECT * FROM Task ORDER BY title" in SQL
  func fetchTasks() {
    let descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.title)])
    do {
      tasks = try context.fetch(descriptor)
    } catch {
      print("Failed to fetch tasks: \(error)")
    }
  }

  // CRUD Operation: CREATE
  // Creates new Task instance and persists it to database
  func addTask(title: String) {
    let task = Task(title: title)
    context.insert(task) // Add to context (like staging area)
    saveContext() // Actually save to database and refresh UI
  }

  // CRUD Operation: UPDATE
  // Modifies existing Task properties and persists changes
  func updateTask(_ task: Task, title: String, isCompleted: Bool) {
    task.title = title
    task.isCompleted = isCompleted
    saveContext() // Save changes to database
  }

  // CRUD Operation: DELETE
  // Removes Task from database
  func deleteTask(_ task: Task) {
    context.delete(task)
    saveContext()
  }

  // Private helper method that handles:
  // 1. Saving context changes to database
  // 2. Refreshing the tasks array to update UI
  // 3. Error handling for save operations
  private func saveContext() {
    do {
      try context.save() // Persist changes to SQLite database
      fetchTasks() // Reload data to update @Published tasks array (triggers UI refresh)
    } catch {
      print("Failed to save context: \(error)")
    }
  }
}
