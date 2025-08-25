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

  func createItem(name: String) {
    let item = Item(name: name)
    context.insert(item)
    saveContext()
  }


  func updateItem(_ item: Item, name: String, task: Task?) {
    item.name = name
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
