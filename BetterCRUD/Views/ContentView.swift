//
//  ContentView.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 24/08/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    let context: ModelContext
    
    // Query for uncompleted tasks to show in badge
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == false
    }) private var uncompletedTasks: [Task]
    
    var body: some View {
        TabView {
            Tab("Tasks", systemImage: "checkmark.circle") {
                TaskListView(context: context)
            }
            .badge(uncompletedTasks.count)
            
            Tab("Items", systemImage: "list.bullet") {
                Text("Items")
            }
        }
    }
}

#Preview {
    let container = PreviewDataContainer.make()
    ContentView(context: container.mainContext)
        .modelContainer(container)
}
