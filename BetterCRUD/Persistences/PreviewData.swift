//
//  PreviewData.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData

@MainActor
struct PreviewData {
  static var container: ModelContainer = {
    do {
      let container = try ModelContainer(for: Task.self, configurations: .init(isStoredInMemoryOnly: false))

      // mock task for previews
      let context = container.mainContext
      let sampleTasks = [
        Task(title: "Buy gorceries"),
        Task(title: "Learn SwiftUI", isCompleted: true),
        Task(title: "Call Mom"),
      ]

      for sampleTask in sampleTasks {
        context.insert(sampleTask)
      }

      try context.save()

      return container
    } catch {
      fatalError("Failed to create preview data container: \(error)")
    }
  }()
}
