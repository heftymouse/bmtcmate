//
//  NearbyBusStationsRequest.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import Foundation

public struct NearbyBusStationsRequest: Encodable {
    var latitude: Double
    var longitude: Double
    var stationId: Int
}

