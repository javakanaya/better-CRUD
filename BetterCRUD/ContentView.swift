//
//  ContentView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 17/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ItemViewModel()
    @State private var editingItem: Item? = nil
    @State private var editedName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New item name", text: $viewModel.newItemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        viewModel.addItem()
                    }
                }.padding()
                List {
                    ForEach(viewModel.items) { item in
                        HStack {
                            if editingItem?.id == item.id {
                                TextField("Edit name", text: $editedName)
                                Button("Save") {
                                    viewModel.updateItem(item, with: editedName)
                                    editingItem = nil
                                }
                                Button("Cancel") {
                                    editingItem = nil
                                }
                            } else {
                                Text(item.name)
                                Spacer()
                                Button("Edit") {
                                    editingItem = item
                                    editedName = item.name
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
            }
            .navigationTitle("Items CRUD")
            .toolbar {
                EditButton()
            }
        }
    }

}
