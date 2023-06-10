//
//  VehicleDataRequest.swift
//  BmtcMate
//
//  Created by Nik on 6/11/23.
//

import Foundation

struct VehicleDataRequest: Encodable {
    let lan: String
    let vehicleRegNo: String

    func encodeToJson() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
