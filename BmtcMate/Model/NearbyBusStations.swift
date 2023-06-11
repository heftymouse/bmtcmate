//
//  GeoFenceData.swift
//  BmtcMate
//
//  Created by Nik on 6/11/23.
//

import Foundation

struct NearbyBusStations: Decodable {
    let list: [NearbyBusStation]
    let message: String
    let isSuccess: Bool
    let exception: String?
    let rowCount: Int
    let responseCode: Int

    enum CodingKeys: String, CodingKey {
        case list = "data", message = "Message", isSuccess = "Issuccess", exception = "exception", rowCount = "RowCount", responseCode = "responsecode"
    }
}

struct NearbyBusStation: Decodable {
    let rowNumber: Int
    let id: Int
    let name: String
    let centerLatitude: Double
    let centerLongitude: Double
    let towards: String
    let distance: Double
    let totalMinutes: Double
    let responseCode: Int
    let radiusKm: Int

    enum CodingKeys: String, CodingKey {
        case rowNumber = "rowno", id = "geofenceid", name = "geofencename", centerLatitude = "center_lat", centerLongitude = "center_lon", towards, distance, totalMinutes = "totalminute", responseCode = "responsecode", radiusKm = "radiuskm"
    }
}

public struct NearbyBusStationsRequest: Encodable {
    var latitude: Double
    var longitude: Double
    var stationId: Int
}
