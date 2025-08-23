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

  init(id: UUID = UUID(), name: String) {
    self.id = id
    self.name = name
  }
}
