import Foundation
import SwiftUI

struct ScheduledBusesView: View {
    var buses: [ScheduledBusRoute]
    
    var body: some View {
        NavigationStack {
            List(buses) { bus in
                NavigationLink(bus.route, value: bus)
            }
            .navigationDestination(for: ScheduledBusRoute.self) { bus in
                ScheduledBusInfoView(bus: bus)
            }
        }
    }
}
