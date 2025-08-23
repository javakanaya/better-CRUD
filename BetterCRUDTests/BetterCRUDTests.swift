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
  
  // MARK: - Basic CRUD Tests
  
  @Test func addTask() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Test Task")
    
    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks.first?.title == "Test Task")
    #expect(viewModel.tasks.first?.isCompleted == false)
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
  
  // MARK: - Multiple Tasks Tests
  
  @Test
  func addMultipleTasks() {
    let viewModel = TaskViewModel(context: context)
    let taskTitles = ["Task 1", "Task 2", "Task 3"]
    
    for title in taskTitles {
      viewModel.addTask(title: title)
    }
    
    #expect(viewModel.tasks.count == 3)
    // Tasks should be sorted by title alphabetically
    #expect(viewModel.tasks[0].title == "Task 1")
    #expect(viewModel.tasks[1].title == "Task 2")
    #expect(viewModel.tasks[2].title == "Task 3")
  }
  
  @Test
  func deleteSpecificTaskFromMultiple() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Keep Task 1")
    viewModel.addTask(title: "Delete This")
    viewModel.addTask(title: "Keep Task 2")
    
    let taskToDelete = viewModel.tasks.first { $0.title == "Delete This" }!
    viewModel.deleteTask(taskToDelete)
    
    #expect(viewModel.tasks.count == 2)
    #expect(!viewModel.tasks.contains { $0.title == "Delete This" })
    #expect(viewModel.tasks.contains { $0.title == "Keep Task 1" })
    #expect(viewModel.tasks.contains { $0.title == "Keep Task 2" })
  }
  
  // MARK: - Task Completion Tests
  
  @Test
  func toggleTaskCompletion() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Toggle Task")
    
    let task = viewModel.tasks.first!
    #expect(task.isCompleted == false)
    
    // Mark as completed
    viewModel.updateTask(task, title: task.title, isCompleted: true)
    #expect(viewModel.tasks.first?.isCompleted == true)
    
    // Mark as not completed
    viewModel.updateTask(task, title: task.title, isCompleted: false)
    #expect(viewModel.tasks.first?.isCompleted == false)
  }
  
  @Test
  func partialCompletionOfMultipleTasks() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Task A")
    viewModel.addTask(title: "Task B")
    viewModel.addTask(title: "Task C")
    
    // Complete only the middle task
    let taskB = viewModel.tasks.first { $0.title == "Task B" }!
    viewModel.updateTask(taskB, title: taskB.title, isCompleted: true)
    
    let completedTasks = viewModel.tasks.filter { $0.isCompleted }
    let incompleteTasks = viewModel.tasks.filter { !$0.isCompleted }
    
    #expect(completedTasks.count == 1)
    #expect(incompleteTasks.count == 2)
    #expect(completedTasks.first?.title == "Task B")
  }
  
  // MARK: - Edge Cases and Data Integrity Tests
  
  @Test
  func addTaskWithEmptyTitle() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "")
    
    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks.first?.title == "")
  }
  
  @Test
  func addTaskWithSpecialCharacters() {
    let viewModel = TaskViewModel(context: context)
    let specialTitle = "Task with 特殊字符 & émojis 🚀💯"
    viewModel.addTask(title: specialTitle)
    
    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks.first?.title == specialTitle)
  }
  
  @Test
  func addTaskWithVeryLongTitle() {
    let viewModel = TaskViewModel(context: context)
    let longTitle = String(repeating: "Very long task title ", count: 50)
    viewModel.addTask(title: longTitle)
    
    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks.first?.title == longTitle)
  }
  
  @Test
  func updateTaskWithEmptyTitle() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Original Title")
    
    let task = viewModel.tasks.first!
    viewModel.updateTask(task, title: "", isCompleted: false)
    
    #expect(viewModel.tasks.first?.title == "")
  }
  
  // MARK: - Data Persistence and Sorting Tests
  
  @Test
  func tasksSortedAlphabetically() {
    let viewModel = TaskViewModel(context: context)
    let unsortedTitles = ["Zebra", "Apple", "Banana", "123 Numbers"]
    
    for title in unsortedTitles {
      viewModel.addTask(title: title)
    }
    
    let expectedOrder = ["123 Numbers", "Apple", "Banana", "Zebra"]
    
    #expect(viewModel.tasks.count == 4)
    for (index, expectedTitle) in expectedOrder.enumerated() {
      #expect(viewModel.tasks[index].title == expectedTitle)
    }
  }
  
  @Test
  func uniqueTaskIDs() {
    let viewModel = TaskViewModel(context: context)
    viewModel.addTask(title: "Task 1")
    viewModel.addTask(title: "Task 2")
    viewModel.addTask(title: "Task 3")
    
    let taskIDs = viewModel.tasks.map { $0.id }
    let uniqueIDs = Set(taskIDs)
    
    #expect(taskIDs.count == uniqueIDs.count) // All IDs should be unique
  }
  
  // MARK: - State Management Tests
  
  @Test
  func freshViewModelStartsEmpty() {
    let viewModel = TaskViewModel(context: context)
    #expect(viewModel.tasks.isEmpty)
  }
  
  @Test
  func multipleOperationsSequence() {
    let viewModel = TaskViewModel(context: context)
    
    // Add tasks
    viewModel.addTask(title: "First")
    viewModel.addTask(title: "Second")
    viewModel.addTask(title: "Third")
    #expect(viewModel.tasks.count == 3)
    
    // Complete one task
    let firstTask = viewModel.tasks.first { $0.title == "First" }!
    viewModel.updateTask(firstTask, title: "First Updated", isCompleted: true)
    #expect(viewModel.tasks.first { $0.title == "First Updated" }?.isCompleted == true)
    
    // Delete one task
    let secondTask = viewModel.tasks.first { $0.title == "Second" }!
    viewModel.deleteTask(secondTask)
    #expect(viewModel.tasks.count == 2)
    #expect(!viewModel.tasks.contains { $0.title == "Second" })
    
    // Verify final state
    #expect(viewModel.tasks.count == 2)
    let remainingTitles = viewModel.tasks.map { $0.title }
    #expect(remainingTitles.contains("First Updated"))
    #expect(remainingTitles.contains("Third"))
  }
  
  // MARK: - Boundary Tests
  
  @Test
  func deleteAllTasks() {
    let viewModel = TaskViewModel(context: context)
    
    // Add multiple tasks
    for i in 1...5 {
      viewModel.addTask(title: "Task \(i)")
    }
    #expect(viewModel.tasks.count == 5)
    
    // Delete all tasks
    let tasksToDelete = Array(viewModel.tasks) // Copy to avoid mutation during iteration
    for task in tasksToDelete {
      viewModel.deleteTask(task)
    }
    
    #expect(viewModel.tasks.isEmpty)
  }
  
  @Test
  func addDuplicateTitles() {
    let viewModel = TaskViewModel(context: context)
    let duplicateTitle = "Duplicate Task"
    
    viewModel.addTask(title: duplicateTitle)
    viewModel.addTask(title: duplicateTitle)
    viewModel.addTask(title: duplicateTitle)
    
    #expect(viewModel.tasks.count == 3)
    let duplicates = viewModel.tasks.filter { $0.title == duplicateTitle }
    #expect(duplicates.count == 3)
    
    // Each task should still have a unique ID
    let uniqueIDs = Set(duplicates.map { $0.id })
    #expect(uniqueIDs.count == 3)
  }
}
