//
//  TaskRow.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 26/08/25.
//

import SwiftUI

struct TaskRow: View {
  var task: Task

  var body: some View {
    HStack {
      Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
        .foregroundStyle(task.isCompleted ? .green : .gray)
      Text(task.title)
        .strikethrough(task.isCompleted)
    }
  }
}
