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
  
    var body: some View {
      NavigationStack {
        Form {
          TextField("Task Title", text: $title)
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
              viewModel.addTask(title: title) // Call ViewModel method to create task
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
