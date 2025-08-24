//
//  PreviewData.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//  Deprecated: Use MockDataContainer.preview instead
//

import SwiftData

@MainActor
struct PreviewDataContainer {
  static func make() -> ModelContainer {
    do {
      let container = try ModelContainer(
        for: Task.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
      )
      
      let sampleTasks = [
        Task(title: "Buy groceries"),
        Task(title: "Learn SwiftUI", isCompleted: true, items: [Item(name: "Components"), Item(name: "Performance")]),
        Task(title: "Call Mom"),
        Task(title: "Write unit tests"),
        Task(title: "Review code", isCompleted: true)
      ]
      
      let context = container.mainContext
      
      for task in sampleTasks {
        context.insert(task)
      }
      
      try context.save()
      
      return container
    } catch {
      fatalError("Failed to create preview container: \(error)")
    }
  }
}
