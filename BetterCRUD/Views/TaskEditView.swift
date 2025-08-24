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
  @State private var items: [Item] = []
  @State private var isCompleted: Bool = false
  
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
    _items = State(initialValue: task.items)
    
  }

  
  var body: some View {
    NavigationStack {
      Form {
        Section("Task Details") {
          TextField("Title", text: $title)
          Toggle("Completed", isOn: $isCompleted)
        }
        Section("Items") {
          ForEach(items.indices, id: \.self) { index in
            TextField("Item \(index + 1)", text: $items[index].name)
          }
          
          Button(action: {
            items.append(Item(name: ""))
          }) {
            HStack {
              Image(systemName: "plus")
              Text("Add Item")
            }
          }
        }
      }
      .navigationTitle("Edit Task")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            dismiss()
          }
        }
        
        ToolbarItem(placement: .confirmationAction) {
          Button("Save") {
            viewModel.updateTask(task, title: title, isCompleted: isCompleted, items: items)
            dismiss()
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
