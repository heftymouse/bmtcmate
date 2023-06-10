import Foundation

typealias BusRoute = String

struct ScheduledBusRoute: Hashable, Equatable, Identifiable {
    public var id: Date { time }
    let route: BusRoute
    let time: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
        hasher.combine(route)
    }
}
