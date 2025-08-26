//
//  TaskListView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
  // @StateObject: Creates and owns the ViewModel instance
  // SwiftUI manages lifecycle - creates once, keeps alive as long as view exists
  // Use @StateObject when THIS view creates the object
  @StateObject private var viewModel: TaskViewModel

  // @State: Local view state for controlling sheet presentations
  @State private var showAddView: Bool = false
  @State private var selectedTask: Task?

  // Custom initializer that creates ViewModel with provided context
  // This establishes the connection between SwiftData and the ViewModel
  init(context: ModelContext) {
    _viewModel = StateObject(wrappedValue: TaskViewModel(context: context))
  }

  var body: some View {
    NavigationStack {
      List {
        // ForEach automatically observes viewModel.tasks changes via @Published
        // When tasks array changes, this ForEach automatically updates the UI
        ForEach(viewModel.tasks) { task in
          Button {
            selectedTask = task // Set selected task to trigger edit sheet
          } label: {
            TaskRow(task: task)
          }
        }
        .onDelete { indexSet in
          for index in indexSet {
            let task = viewModel.tasks[index]
            viewModel.deleteTask(task)
          }
        }
      }
      .navigationTitle("Tasks")
      .toolbar {
        Button(action: { showAddView = true }, label: {
          Image(systemName: "plus")
        })
      }
      // When selectedTask becomes non-nil, sheet appears
      // When sheet dismisses, selectedTask automatically becomes nil
      .sheet(item: $selectedTask, content: { task in
        TaskEditView(viewModel: viewModel, task: task)
      })
      .sheet(isPresented: $showAddView) {
        TaskCreateView(viewModel: viewModel)
      }
    }
  }
}

#Preview {
  let container = PreviewDataContainer.make()
  TaskListView(context: container.mainContext)
    .modelContainer(container)
}
