// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let busTripDetails = try? JSONDecoder().decode(BusTripDetails.self, from: jsonData)

import Foundation

// MARK: - BusTripDetails
struct BusTripDetails: Codable {
    let routeDetails: [RouteDetail]
    let liveLocation: [LiveLocation]
    let message: String
    let issuccess: Bool
    let rowCount, responsecode: Int

    enum CodingKeys: String, CodingKey {
        case routeDetails = "RouteDetails"
        case liveLocation = "LiveLocation"
        case message = "Message"
        case issuccess = "Issuccess"
        case rowCount = "RowCount"
        case responsecode
    }
}

// MARK: - LiveLocation
struct LiveLocation: Codable {
    let latitude, longitude: Double
    let location, lastrefreshon, nextstop, previousstop: String
    let vehicleid: Int
    let vehiclenumber, routeno: String
    let servicetypeid: Int
    let servicetype: String
    let heading, responsecode, tripStatus, lastreceiveddatetimeflag: Int

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, location, lastrefreshon, nextstop, previousstop, vehicleid, vehiclenumber, routeno, servicetypeid, servicetype, heading, responsecode
        case tripStatus = "trip_status"
        case lastreceiveddatetimeflag
    }
}

// MARK: - RouteDetail
struct RouteDetail: Codable {
    let rowid, tripid: Int
    let routeno, routename, busno, tripstatus: String
    let tripstatusid, sourcestation, destinationstation, servicetype: String
    let webservicetype: String
    let servicetypeid: Int
    let lastupdatedat, stationname: String
    let stationid: Int
    let actualArrivaltime: String
    let stopstatus: Int
    let etastatus, etastatusmapview: String
    let latitude, longitude: Double
    let currentstop, laststop, weblaststop, nextstop: String
    let currlatitude, currlongitude: Double
    let schArrivaltime, schDeparturetime, eta, actualArrivaltime1: String
    let actualDepartudetime, tripstarttime, tripendtime: String
    let routeid, vehicleid, responsecode, lastreceiveddatetimeflag: Int
    let srno: Int

    enum CodingKeys: String, CodingKey {
        case rowid, tripid, routeno, routename, busno, tripstatus, tripstatusid, sourcestation, destinationstation, servicetype, webservicetype, servicetypeid, lastupdatedat, stationname, stationid
        case actualArrivaltime = "actual_arrivaltime"
        case stopstatus, etastatus, etastatusmapview, latitude, longitude, currentstop, laststop, weblaststop, nextstop, currlatitude, currlongitude
        case schArrivaltime = "sch_arrivaltime"
        case schDeparturetime = "sch_departuretime"
        case eta
        case actualArrivaltime1 = "actual_arrivaltime1"
        case actualDepartudetime = "actual_departudetime"
        case tripstarttime, tripendtime, routeid, vehicleid, responsecode, lastreceiveddatetimeflag, srno
    }
}

struct BusTripDataRequest: Encodable {
    let vehicleId: Int
}

