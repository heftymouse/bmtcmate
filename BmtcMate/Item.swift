//
//  Item.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 10/06/23.
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
