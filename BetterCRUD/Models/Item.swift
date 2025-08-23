//
//  Item.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 17/08/25.
//

import Foundation
import SwiftData

@Model
final class Item: Identifiable {
  var id: UUID
  var name: String
  
  // Many-to-one relationship: Each Item belongs to one Task
  // Optional because an Item might be created before being assigned to a Task
  var task: Task?

  init(id: UUID = UUID(), name: String, task: Task? = nil) {
    self.id = id
    self.name = name
    self.task = task
  }
}
