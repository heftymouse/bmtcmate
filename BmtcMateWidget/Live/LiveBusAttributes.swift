//
//  liveBusAttributes.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import Foundation
import ActivityKit

struct LiveBusAttributes: ActivityAttributes {
    public typealias BusState = ContentState
    
    public struct ContentState: Codable, Hashable, Equatable {
        var eta: String
    }
    
    var busNumber: String
    var destination: String
}
