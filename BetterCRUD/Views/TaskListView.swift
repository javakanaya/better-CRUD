//
//  TaskListView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
  @StateObject private var viewModel: TaskViewModel
  
  @State private var showAddView: Bool = false
  @State private var selectedTask: Task?
  
  init(context: ModelContext) {
    _viewModel = StateObject(wrappedValue: TaskViewModel(context: context))
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.tasks) { task in
          Button {
            selectedTask = task
          } label: {
            HStack {
              Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(task.isCompleted ? .green : .gray)
              Text(task.title)
                .strikethrough(task.isCompleted)
            }
          }
        }
        // what is this indexSet ??
        .onDelete { indexSet in
          indexSet.map { viewModel.tasks[$0] }.forEach(viewModel.deleteTask)
        }
      }
      .navigationTitle("Tasks")
      .toolbar {
        Button(action: { showAddView = true }, label: {
          Image(systemName: "plus")
        })
      }
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
  TaskListView(context: PreviewData.container.mainContext)
    .modelContainer(PreviewData.container)
}
