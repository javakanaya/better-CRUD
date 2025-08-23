//
//  Task.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import Foundation
import SwiftData

/// when you declare a class as being final, no other class can inherit from it.
/// This means they can’t override your methods in order to change your behavior – they need to use your class the way it was written.
@Model
final class Task {
  @Attribute(.unique) var id: UUID
  var title: String
  var isCompleted: Bool

  init(title: String, isCompleted: Bool = false) {
    id = UUID()
    self.title = title
    self.isCompleted = isCompleted
  }
}
