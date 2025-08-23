//
//  TaskCreateView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftUI

struct TaskCreateView: View {
  // @Environment: Accesses SwiftUI's environment values
  // dismiss: Function to programmatically close this view
  @Environment(\.dismiss) private var dismiss

  // @ObservedObject: Observes an existing ViewModel instance passed from parent
  // This view doesn't own the ViewModel - it receives it from TaskListView
  // Use @ObservedObject when the object comes from elsewhere
  @ObservedObject var viewModel: TaskViewModel

  // @State: Local view state for form input
  @State private var title: String = ""
  @State private var items: [String] = [""]
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Task Details") {
          TextField("Task Title", text: $title)
        }
        
        Section("Items") {
          ForEach(items.indices, id: \.self) { index in
            HStack {
              TextField("Item name", text: $items[index])
              
              if items.count > 1 {
                Button(action: { 
                  items.remove(at: index) 
                }) {
                  Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
                }
              }
            }
          }
          
          Button(action: { 
            items.append("") 
          }) {
            HStack {
              Image(systemName: "plus.circle.fill")
                .foregroundColor(.green)
              Text("Add Item")
            }
          }
        }
      }
      .navigationTitle("New Task")
      .toolbar {
        // Cancel button - dismisses view without saving
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            dismiss() // Close the sheet
          }
        }

        // Save button - creates new task and dismisses view
        ToolbarItem(placement: .confirmationAction) {
          Button("Save") {
            // Filter out empty items and create the task with items
            let nonEmptyItems = items.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            viewModel.addTask(title: title, itemNames: nonEmptyItems)
            dismiss() // Close the sheet after saving
          }
          // Disable save button when title is empty to prevent invalid data
          .disabled(title.isEmpty)
        }
      }
    }
  }
}

#Preview {
  TaskCreateView(
    viewModel: TaskViewModel(
      context: PreviewData.container.mainContext
    )
  ).modelContainer(PreviewData.container)
}
