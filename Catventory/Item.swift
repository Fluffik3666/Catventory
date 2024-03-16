//
//  Item.swift
//  Catventory
//
//  Created by Sasha Bagrov on 16/03/2024.
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
