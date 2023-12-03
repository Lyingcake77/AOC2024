//
//  Item.swift
//  AOC2024
//
//  Created by Dev on 11/25/23.
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
