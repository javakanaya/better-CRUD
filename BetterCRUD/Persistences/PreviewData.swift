//
//  PreviewData.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData

@MainActor
struct PreviewData {
  // Static container specifically for SwiftUI previews
  // Uses in-memory storage to avoid affecting real app data
  static var container: ModelContainer = {
    do {
      // isStoredInMemoryOnly: false means data persists during preview session
      // This allows previews to maintain state while developing
      let container = try ModelContainer(for: Task.self, Item.self, configurations: .init(isStoredInMemoryOnly: false))

      // Create sample data for previews
      // This provides realistic data for UI development and testing
      let context = container.mainContext
      
      // Create sample tasks with items
      let groceryTask = Task(title: "Buy groceries")
      let learningTask = Task(title: "Learn SwiftUI", isCompleted: true)
      let personalTask = Task(title: "Call Mom")
      
      // Add items to grocery task
      let milk = Item(name: "Milk", task: groceryTask)
      let bread = Item(name: "Bread", task: groceryTask)
      let eggs = Item(name: "Eggs", task: groceryTask)
      groceryTask.items = [milk, bread, eggs]
      
      // Add items to learning task
      let tutorial = Item(name: "Complete SwiftData tutorial", task: learningTask)
      let project = Item(name: "Build sample project", task: learningTask)
      learningTask.items = [tutorial, project]
      
      let sampleTasks = [groceryTask, learningTask, personalTask]
      let sampleItems = [milk, bread, eggs, tutorial, project]

      // Insert sample data into the preview database
      for sampleTask in sampleTasks {
        context.insert(sampleTask)
      }
      for sampleItem in sampleItems {
        context.insert(sampleItem)
      }

      // Save the sample data to make it available in previews
      try context.save()

      return container
    } catch {
      fatalError("Failed to create preview data container: \(error)")
    }
  }()
}
