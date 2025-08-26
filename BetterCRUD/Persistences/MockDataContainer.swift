//
//  MockDataContainer.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 24/08/25.
//

import SwiftData

@MainActor
struct MockDataContainer {
  static func make() -> ModelContainer {
    do {
      let container = try ModelContainer(
        for: Task.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
      )

      return container
    } catch {
      fatalError("Failed to create mock container: \(error)")
    }
  }
}
