import SwiftUI

struct ScheduledBusInfoView: View {
    var bus: ScheduledBusRoute
    var scheduledStops: [ScheduledBusStop] = []
    
    var body: some View {
        Text("todo")
    }
}

#Preview {
    ScheduledBusInfoView(bus: .init(route: "210-FA", time: Date.now))
}
