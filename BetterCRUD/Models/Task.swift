//
//  Task.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import Foundation
import SwiftData



// @Model: SwiftData macro that transforms this class into a persistent data model
// - Automatically generates database schema
// - Enables CRUD operations through ModelContext
// - Makes objects observable for SwiftUI updates
@Model

/// when you declare a class as being final, no other class can inherit from it.
/// This means they can't override your methods in order to change your behavior – they need to use your class the way it was written.
final class Task: Identifiable {
  // @Attribute(.unique): Ensures this property has unique values across all Task instances
  // Similar to PRIMARY KEY in SQL databases
  @Attribute(.unique) var id: UUID

  // SwiftData automatically persists these properties
  var title: String
  var isCompleted: Bool
  var items: [Item] = []

  init(title: String, isCompleted: Bool = false, items: [Item] = []) {
    // UUID() generates a unique identifier for each task instance
    id = UUID()
    self.title = title
    self.isCompleted = isCompleted
    self.items = items
  }
}
