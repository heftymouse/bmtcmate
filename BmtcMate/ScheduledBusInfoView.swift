import SwiftUI

struct ScheduledBusInfoView: View {
    var bus: ScheduledBusRoute
    
    var body: some View {
        Text(bus.route)
    }
}

#Preview {
    ScheduledBusInfoView(bus: .init(route: "210-FA", time: Date.now))
}
