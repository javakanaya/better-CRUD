//
//  BetterCRUDTests.swift
//  BetterCRUDTests
//
//  Created by Java Kanaya Prada on 17/08/25.
//

@testable import BetterCRUD
import Testing
import SwiftData

@MainActor
struct BetterCRUDTests {
  let container = MockContainer.make()
  var context: ModelContext { container.mainContext }
  
  @Test func addTask() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Test Task")
    
    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks.first?.title == "Test Task")
  }
  
  @Test
  func updateTask() {
      let viewModel = TaskViewModel(context: context)
      viewModel.addTask(title: "Old Title")

      let task = viewModel.tasks.first!
      viewModel.updateTask(task, title: "New Title", isCompleted: true)

      #expect(viewModel.tasks.first?.title == "New Title")
      #expect(viewModel.tasks.first?.isCompleted == true)
  }

  @Test
  func deleteTask() {
      let viewModel = TaskViewModel(context: context)
      viewModel.addTask(title: "To Delete")

      let task = viewModel.tasks.first!
      viewModel.deleteTask(task)

      #expect(viewModel.tasks.isEmpty)
  }
}
