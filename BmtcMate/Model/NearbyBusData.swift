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

struct NearbyBus: Decodable, Hashable, Identifiable {
    var id: String { arrivalTime + routeNo + busNo }
    let routeNo: String
    let routeName: String
    let fromStationName: String
    let toStationName: String
    let busNo: String
    let arrivalTime: String
    var arriveTimeTimeComponent: String {
        return String(arrivalTime.split(separator: " ")[1])
    }
    var estimatedArrival: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = formatter.date(from: arrivalTime)
        print(date, arrivalTime)
        let relativeFormatter = RelativeDateTimeFormatter()
        return relativeFormatter.localizedString(for: date!, relativeTo: .now)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(routeNo)
        hasher.combine(arrivalTime)
    }

    enum CodingKeys: String, CodingKey {
        case routeNo = "routeno", routeName = "routename", fromStationName = "fromstationname", toStationName = "tostationname", busNo = "busno", arrivalTime = "arrivaltime"
    }
}

struct NearbyBusDataRequest: Encodable {
    let stationId: Int
    let tripType: Int

    enum CodingKeys: String, CodingKey {
        case stationId = "stationid", tripType = "triptype"
    }
}
