//
//  VehicleDataRequest.swift
//  BmtcMate
//
//  Created by Nik on 6/11/23.
//

import Foundation

struct VehicleData: Decodable {
    let data: [Vehicle]
    let message: String
    let isSuccess: Bool
    let exception: String?
    let rowCount: Int
    let responseCode: Int

    enum CodingKeys: String, CodingKey {
        case data, message = "Message", isSuccess = "Issuccess", exception = "exception", rowCount = "RowCount", responseCode = "responsecode"
    }
}

struct Vehicle: Decodable {
    let vehicleId: Int
    let vehicleRegNo: String
    let responseCode: Int

    enum CodingKeys: String, CodingKey {
        case vehicleId = "vehicleid", vehicleRegNo = "vehicleregno", responseCode = "responsecode"
    }
}

struct VehicleDataRequest: Encodable {
    let lan: String
    let vehicleRegNo: String

    func encodeToJson() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
