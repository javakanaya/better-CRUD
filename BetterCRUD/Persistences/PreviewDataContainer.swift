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
      
      let context = container.mainContext
      
      let sampleTasks = [
        Task(title: "Buy groceries"),
        Task(title: "Learn SwiftUI", isCompleted: true, items: [Item(name: "Components"), Item(name: "Performance")]),
        Task(title: "Call Mom"),
        Task(title: "Write unit tests"),
        Task(title: "Review code", isCompleted: true)
      ]
      
      for task in sampleTasks {
        context.insert(task)
      }
        
      let sampleItems = [
        Item(name: "Do something"),
        Item(name: "Do another thing"),
        Item(name: "Do yet another thing"),
      ]
      
      for item in sampleItems {
        context.insert(item)
      }
    
      try context.save()
      
      return container
    } catch {
      fatalError("Failed to create preview container: \(error)")
    }
  }
}
