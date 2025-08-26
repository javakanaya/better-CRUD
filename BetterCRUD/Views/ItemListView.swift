//
//  ItemListView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 26/08/25.
//

import SwiftUI
import SwiftData

struct ItemListView: View {
    @StateObject private var viewModel: ItemViewModel
    
    init(context: ModelContext) {
      _viewModel = StateObject(wrappedValue: ItemViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            List {
              ForEach(viewModel.items) { item in
                ItemRow(item: item)
              }
            }
            .navigationTitle("Items")
        }
    }
}



#Preview {
  let container = PreviewDataContainer.make()
  ItemListView(context: container.mainContext)
    .modelContainer(container)
}
