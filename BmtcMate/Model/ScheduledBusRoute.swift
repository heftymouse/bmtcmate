import Foundation

public typealias BusRoute = String

public struct ScheduledBusRoute: Hashable, Equatable, Identifiable {
    public var id: Date { time }
    public let route: BusRoute
    public let time: Date
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(time)
        hasher.combine(route)
    }
}
