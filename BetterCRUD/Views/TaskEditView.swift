//
//  TaskEditView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftUI
import SwiftData

struct TaskEditView: View {
  @Environment(\.dismiss) private var dismiss
  @ObservedObject var viewModel: TaskViewModel
  
  @State private var title: String = ""
  @State private var isCompleted: Bool = false
  
  private let task: Task
  
  init(viewModel: TaskViewModel, task: Task) {
    self.viewModel = viewModel
    self.task = task
    _title = State(initialValue: task.title)
    _isCompleted = State(initialValue: task.isCompleted)
  }
  
    var body: some View {
      NavigationStack {
        Form {
          TextField("Title", text: $title)
          Toggle("Completed", isOn: $isCompleted)
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
              viewModel.updateTask(task, title: title, isCompleted: isCompleted)
              dismiss()
            }
          }
        }
      }
    }
}

#Preview {
  let context = PreviewData.container.mainContext
  let task = try! context.fetch(FetchDescriptor<Task>()).first!
  let vm = TaskViewModel(context: context)
  TaskEditView(viewModel: vm, task: task)
    .modelContainer(PreviewData.container)
}
