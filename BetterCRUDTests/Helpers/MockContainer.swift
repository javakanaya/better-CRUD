//
//  MockContainer.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData

@MainActor
struct MockContainer {
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
