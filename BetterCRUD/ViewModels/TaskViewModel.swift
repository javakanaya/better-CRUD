//
//  TaskViewModel.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import Foundation
import SwiftData

@MainActor
class TaskViewModel: ObservableObject {
  private var context: ModelContext

  @Published var tasks: [Task] = []

  init(context: ModelContext) {
    self.context = context
    fetchTasks()
  }

  func fetchTasks() {
    let descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.title)])
    do {
      tasks = try context.fetch(descriptor)
    } catch {
      print("Failed to fetch tasks: \(error)")
    }
  }

  func addTask(title: String) {
    let task = Task(title: title)
    context.insert(task)
    saveContext()
  }

  func updateTask(_ task: Task, title: String, isCompleted: Bool) {
    task.title = title
    task.isCompleted = isCompleted
    saveContext()
  }

  func deleteTask(_ task: Task) {
    context.delete(task)
    saveContext()
  }

  private func saveContext() {
    do {
      try context.save()
      fetchTasks()
    } catch {
      print("Failed to save context: \(error)")
    }
  }
}
