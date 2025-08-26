//
//  ItemViewModel.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 25/08/25.
//

import Foundation
import SwiftData

@MainActor
class ItemViewModel: ObservableObject {
  private var context: ModelContext

  @Published var items: [Item] = []

  init(context: ModelContext) {
    self.context = context
    fetchItems()
  }

  func fetchItems() {
    let descriptor = FetchDescriptor<Item>(sortBy: [SortDescriptor(\.name)])
    do {
      items = try context.fetch(descriptor)
    } catch {
      print("Failed to fetch items: \(error)")
    }
  }

  func createItem(name: String, task: Task? = nil) {
    let item = Item(name: name, task: task)
    context.insert(item)
    saveContext()
  }

  func updateItem(_ item: Item, name: String, task: Task? = nil) {
    item.name = name
    if let task = task {
      item.task = task
    }
    saveContext()
  }

  func deleteItem(_ item: Item) {
    context.delete(item)
    saveContext()
  }

  private func saveContext() {
    do {
      try context.save()
      fetchItems()
    } catch {
      print("Failed to save context: \(error)")
    }
  }
}
