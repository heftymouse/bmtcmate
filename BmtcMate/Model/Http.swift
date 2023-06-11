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
        
        @discardableResult
        func json<T: Encodable>(_ body: T) throws -> RequestBuilder {
            var builder = self
            let jsonData = try JSONEncoder().encode(body)
            builder.urlRequest.httpBody = jsonData
            builder.urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return builder
        }
        
        @discardableResult
        func string(_ body: String) -> RequestBuilder {
            var builder = self
            builder.urlRequest.httpBody = body.data(using: .utf8)
            builder.urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")
            return builder
        }
        
        @discardableResult
        func body(_ body: Data?) -> RequestBuilder {
            var builder = self
            builder.urlRequest.httpBody = body
            return builder
        }
        
        func request() async throws -> (Data, URLResponse?) {
            let (data, urlResponse) = try await Http.session.data(for: urlRequest)
            return (data, urlResponse)
        }
    }
}

func getNearbyStations(latitude: Double, longitude: Double) async throws -> [NearbyBusStation] {
    return try await JSONDecoder().decode(NearbyBusStations.self, from: Http.post("https://bmtcmobileapistaging.amnex.com/WebAPI/NearbyStations_V2")
        .header("authToken", field: "N/A")
        .header("clientId", field: "0")
        .header("devicetype", field: "ios")
        .header("lan", field: "en")
        .header("deviceid", field: "randomvalue")
        .json(NearbyBusStationsRequest(latitude: latitude, longitude: longitude, stationId: 0))
        .request().0)
    .list.filter { station in
        station.distance <= 0.51
    }
}
