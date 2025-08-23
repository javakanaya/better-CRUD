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

  init(name: String) {
    id = UUID()
    self.name = name
  }
}
