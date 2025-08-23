import Foundation
import SwiftUI

class ItemViewModel: ObservableObject {
  @Published var items: [Item] = []
  @Published var newItemName: String = ""

  // Create
  func addItem() {
    guard !newItemName.isEmpty else { return }
    let newItem = Item(id: UUID(), name: newItemName)
    items.append(newItem)
    newItemName = ""
  }

  // Read is handled by @Published var items

  // Update
  func updateItem(_ item: Item, with newName: String) {
    if let index = items.firstIndex(where: { $0.id == item.id }) {
      items[index].name = newName
    }
  }

  // Delete
  func deleteItem(at offsets: IndexSet) {
    items.remove(atOffsets: offsets)
  }
}
