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
      let container = try ModelContainer(for: Task.self, configurations: .init(isStoredInMemoryOnly: true))

      // Create sample data for previews
      // This provides realistic data for UI development and testing
      let context = container.mainContext
      let sampleTasks = [
        Task(title: "Buy gorceries"),
        Task(title: "Learn SwiftUI", isCompleted: true),
        Task(title: "Call Mom"),
      ]

      // Insert sample tasks into the preview database
      for sampleTask in sampleTasks {
        context.insert(sampleTask)
      }

      // Save the sample data to make it available in previews
      try context.save()

      return container
    } catch {
      fatalError("Failed to create preview data container: \(error)")
    }
  }()
}
