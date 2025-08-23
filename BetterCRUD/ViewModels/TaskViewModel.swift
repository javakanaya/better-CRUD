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
  private var _context: ModelContext
  
  // Public access to context for other ViewModels
  var context: ModelContext {
    return _context
  }

  // @Published: Automatically notifies SwiftUI views when this array changes
  // This creates the reactive connection between data and UI
  @Published var tasks: [Task] = []

  // Dependency injection: Context is provided from outside (usually from a View)
  // This makes the ViewModel testable and flexible
  init(context: ModelContext) {
    self._context = context
    fetchTasks() // Load initial data when ViewModel is created
  }

  // FetchDescriptor: Defines how to query the database
  func fetchTasks() {
    let descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.title)])
    do {
      tasks = try _context.fetch(descriptor)
    } catch {
      print("Failed to fetch tasks: \(error)")
    }
  }

  func addTask(title: String, itemNames: [String] = []) {
    let task = Task(title: title)
    
    // Add items to the task
    for itemName in itemNames {
      let item = Item(name: itemName, task: task)
      task.items.append(item)
      _context.insert(item)
    }
    
    _context.insert(task)
    saveContext()
  }

  func updateTask(_ task: Task, title: String, isCompleted: Bool) {
    task.title = title
    task.isCompleted = isCompleted
    saveContext()
  }
  
  func addItem(to task: Task, name: String) {
    let item = Item(name: name, task: task)
    task.items.append(item)
    _context.insert(item)
    saveContext()
  }
  
  func deleteItem(_ item: Item) {
    _context.delete(item)
    saveContext()
  }

  func deleteTask(_ task: Task) {
    _context.delete(task)
    saveContext()
  }

  // Private helper method that handles:
  // 1. Saving context changes to database
  // 2. Refreshing the tasks array to update UI
  // 3. Error handling for save operations
  private func saveContext() {
    do {
      try _context.save() // Persist changes to SQLite database
      fetchTasks() // Reload data to update @Published tasks array (triggers UI refresh)
    } catch {
      print("Failed to save context: \(error)")
    }
  }
}
