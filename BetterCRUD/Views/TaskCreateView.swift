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
  @State private var itemNames: [String] = [""]

  var body: some View {
    NavigationStack {
      Form {
        Section("Task Details") {
          TextField("Task Title", text: $title)
        }

        Section("Items") {
          ForEach(itemNames.indices, id: \.self) { index in
            HStack {
              TextField("Item name", text: $itemNames[index])

              if itemNames.count > 1 {
                Button(action: {
                  itemNames.remove(at: index)
                }, label: {
                  Image(systemName: "minus.circle.fill").foregroundStyle(.red)
                })
              }
            }
          }

          Button(action: {
            itemNames.append("")
          }, label: {
            HStack {
              Image(systemName: "plus.circle.fill").foregroundStyle(.green)
              Text("Add Item")
            }
          })
        }
      }
      .navigationTitle("New Task")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            dismiss()
          }
        }

        ToolbarItem(placement: .confirmationAction) {
          Button("Save") {
            viewModel.createTask(title: title, itemNames: itemNames)
            dismiss()
          }
          // Disable save button when title is empty to prevent invalid data
          .disabled(title.isEmpty)
        }
      }
    }
  }
}

#Preview {
  let container = PreviewDataContainer.make()

  TaskCreateView(
    viewModel: TaskViewModel(
      context: container.mainContext
    )
  ).modelContainer(container)
}
