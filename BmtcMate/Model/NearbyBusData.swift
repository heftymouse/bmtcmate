//
//  NearbyBusData.swift
//  BmtcMate
//
//  Created by Nik on 6/11/23.
//

import Foundation

struct NearbyBusData: Decodable {
    let data: [NearbyBus]
    let message: String
    let isSuccess: Bool
    let exception: String?
    let rowCount: Int
    let responseCode: Int

    enum CodingKeys: String, CodingKey {
        case data, message = "Message", isSuccess = "Issuccess", exception = "exception", rowCount = "RowCount", responseCode = "responsecode"
    }
}

struct NearbyBus: Decodable {
    let routeNo: String
    let routeName: String
    let fromStationName: String
    let toStationName: String
    let busNo: String
    let arrivalTime: String

    enum CodingKeys: String, CodingKey {
        case routeNo = "routeno", routeName = "routename", fromStationName = "fromstationname", toStationName = "tostationname", busNo = "busno", arrivalTime = "arrivaltime"
    }
}

struct NearbyBusDataRequest: Decodable {
    let lan: String
    let regNo: String
}
