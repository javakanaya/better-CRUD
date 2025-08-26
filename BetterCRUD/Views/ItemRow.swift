//
//  ItemRow.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 26/08/25.
//

import SwiftUI

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
                .font(.body)
                .fontWeight(.medium)
            
            if let task = item.task {
                Text("From: \(task.title)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text("Unassigned")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
        .padding(.vertical, 2)
    }
}
