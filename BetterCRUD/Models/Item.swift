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
  @Attribute(.unique) var id: UUID
  var name: String
  var task: Task?

  init(name: String, task: Task? = nil) {
    id = UUID()
    self.name = name
    self.task = task
  }
}
