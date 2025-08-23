//
//  ItemListView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftUI
import SwiftData

struct ItemListView: View {
    @StateObject private var viewModel: ItemViewModel
    
    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: ItemViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.headline)
                        
                        // This shows why we need the task reference!
                        if let task = item.task {
                            Text("Task: \(task.title)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            Text("No task assigned")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.vertical, 2)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let item = viewModel.items[index]
                        viewModel.deleteItem(item)
                    }
                }
            }
            .navigationTitle("All Items")
        }
    }
}

#Preview {
    let context = PreviewData.container.mainContext
    return ItemListView(context: context)
        .modelContainer(PreviewData.container)
}
