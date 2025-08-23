//
//  TaskEditView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData
import SwiftUI

struct TaskEditView: View {
  @Environment(\.dismiss) private var dismiss

  // @ObservedObject: Receives ViewModel from parent view (TaskListView)
  // Allows this view to observe changes and call ViewModel methods
  @ObservedObject var viewModel: TaskViewModel

  // @State: Local form state initialized with existing task values
  // These hold the temporary editing state until save/cancel
  @State private var title: String = ""
  @State private var isCompleted: Bool = false
  @State private var newItemName: String = ""

  // The task being edited - passed in during initialization
  private let task: Task

  // Custom initializer that pre-populates form fields with existing task data
  // _title and _isCompleted use State(initialValue:) to set initial values
  init(viewModel: TaskViewModel, task: Task) {
    self.viewModel = viewModel
    self.task = task
    // Initialize @State properties with existing task values
    _title = State(initialValue: task.title)
    _isCompleted = State(initialValue: task.isCompleted)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("Task Details") {
          // Two-way binding: changes in TextField update @State title
          TextField("Title", text: $title)
          // Toggle for completion status
          Toggle("Completed", isOn: $isCompleted)
        }
        
        Section("Items") {
          // Display existing items
          ForEach(task.items) { item in
            HStack {
              Text(item.name)
              Spacer()
              Button(action: { 
                viewModel.deleteItem(item)
              }) {
                Image(systemName: "trash")
                  .foregroundColor(.red)
              }
            }
          }
          
          // Add new item form
          HStack {
            TextField("New item name", text: $newItemName)
            Button("Add") {
              if !newItemName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                viewModel.addItem(to: task, name: newItemName)
                newItemName = ""
              }
            }
            .disabled(newItemName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
          }
        }
      }
      .navigationTitle("Edit Task")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            dismiss() // Discard changes and close view
          }
        }

        ToolbarItem(placement: .confirmationAction) {
          Button("Save") {
            // Call ViewModel to update the existing task with new values
            viewModel.updateTask(task, title: title, isCompleted: isCompleted)
            dismiss() // Close view after saving
          }
        }
      }
    }
  }
}

#Preview {
  let context = PreviewData.container.mainContext
  // Fetch first task from preview data for demonstration
  let task = try! context.fetch(FetchDescriptor<Task>()).first!
  let vm = TaskViewModel(context: context)
  TaskEditView(viewModel: vm, task: task)
    .modelContainer(PreviewData.container)
}
