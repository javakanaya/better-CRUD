//
//  Item.swift
//  BetterCRUD
//
//  Created by Java Kanaya Prada on 17/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
