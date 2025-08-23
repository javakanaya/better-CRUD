//
//  TaskCreateView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 23/08/25.
//

import SwiftUI

struct TaskCreateView: View {
  @Environment(\.dismiss) private var dismiss
  @ObservedObject var viewModel: TaskViewModel
  
  @State private var title: String = ""
  
    var body: some View {
      NavigationStack {
        Form {
          TextField("Task Title", text: $title)
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
              viewModel.addTask(title: title)
              dismiss()
            }
            // disabled the save button when title is empty
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
