//
//  Http.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import Foundation

import Foundation

public struct Http {
    private static let session = URLSession(configuration: .default)
    
    public static func post(_ url: String) -> RequestBuilder {
        return .init(url: URL(string: url)!)
    }
    
    public static func post(url: URL) -> RequestBuilder {
        return .init(url: url)
    }
    
    public struct RequestBuilder {
        private var urlRequest: URLRequest
        
        init(url: URL) {
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("InnateMC", forHTTPHeaderField: "User-Agent")
        }
        
        func header(_ value: String?, field: String) -> RequestBuilder {
            var builder = self
            builder.urlRequest.setValue(value, forHTTPHeaderField: field)
            return builder
        }
        
        func dothefuni() -> RequestBuilder {
            var builder = self
                .header("N/A", field: "authtoken")
                .header("0", field: "clientid")
                .header("ios", field: "devicetype")
                .header("en", field: "lan")
                .header("randomvalue", field: "deviceid")
            return builder
        }
        
        @discardableResult
        func json<T: Encodable>(_ body: T) throws -> RequestBuilder {
            var builder = self
            let jsonData = try JSONEncoder().encode(body)
            builder.urlRequest.httpBody = jsonData
            builder.urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            return builder
        }
        
        @discardableResult
        func string(_ body: String) -> RequestBuilder {
            var builder = self
            builder.urlRequest.httpBody = body.data(using: .utf8)
            builder.urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            return builder
        }
        
        @discardableResult
        func body(_ body: Data?) -> RequestBuilder {
            var builder = self
            builder.urlRequest.httpBody = body
            return builder
        }
        
        func request() async throws -> (Data, URLResponse?) {
            print(String(data: urlRequest.httpBody!, encoding: .utf8)!)
            let (data, urlResponse) = try await Http.session.data(for: urlRequest)
            return (data, urlResponse)
        }
    }
}

func getNearbyStations(latitude: Double, longitude: Double) async throws -> [NearbyBusStation] {
    let (data, _) = try await Http.post("https://bmtcmobileapistaging.amnex.com/WebAPI/NearbyStations_V2")
        .header("N/A", field: "authtoken")
        .header("0", field: "clientid")
        .header("ios", field: "devicetype")
        .header("en", field: "lan")
        .header("randomvalue", field: "deviceid")
        .json(NearbyBusStationsRequest(latitude: latitude, longitude: longitude, stationId: 0))
        .request()
    print(String(data: data, encoding: .utf8)!)
    return try JSONDecoder().decode(NearbyBusStations.self, from: data)
    .list.filter { station in
        station.distance <= 0.51
    }
}

func getNearbyBuses(stationId: Int) async throws -> [NearbyBus] {
    return try await JSONDecoder().decode(NearbyBusData.self, from: Http.post("https://bmtcmobileapistaging.amnex.com/WebAPI/GetMobileTripsData")
        .header("N/A", field: "authtoken")
        .header("0", field: "clientid")
        .header("ios", field: "devicetype")
        .header("en", field: "lan")
        .header("randomvalue", field: "deviceid")
        .json(NearbyBusDataRequest(stationId: stationId, tripType: 1))
        .request().0)
    .data
}

func getVehicleId(busno: String) async throws -> Int {
    return try await JSONDecoder().decode(VehicleData.self, from: Http.post("https://bmtcmobileapistaging.amnex.com/WebAPI/ListVehicles")
        .header("N/A", field: "authtoken")
        .header("0", field: "clientid")
        .header("ios", field: "devicetype")
        .header("en", field: "lan")
        .header("randomvalue", field: "deviceid")
        .json(VehicleDataRequest(lan: "en", vehicleRegNo: busno)).request().0)
        .data[0].vehicleId
}

func getBusTripData(vehicleId: Int) async throws -> BusTripDetails {
    let data = try await Http.post("https://bmtcmobileapistaging.amnex.com/WebAPI/VehicleTripDetails")
        .header("N/A", field: "authtoken")
        .header("0", field: "clientid")
        .header("ios", field: "devicetype")
        .header("en", field: "lan")
        .header("randomvalue", field: "deviceid")
        .json(BusTripDataRequest(vehicleId: vehicleId))
        .request().0
    print(String(data: data, encoding: .utf8)!)
    return try await JSONDecoder().decode(BusTripDetails.self, from: data)
}
