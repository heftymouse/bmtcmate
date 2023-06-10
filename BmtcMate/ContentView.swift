import SwiftUI

struct ContentView: View {
    @State var scheduledBuses: [ScheduledBusRoute] = []
    @State var showManualSelectSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("BmtcMate")
                .font(.largeTitle)
                .animation(.linear)
            HStack(spacing: 16) {
                Button(action: {
                    
                }) {
                    Text("Detect bus stop")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Button(action: {
                    
                }) {
                    Text("Set Manually")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .sheet(isPresented: $showManualSelectSheet) {
                    Text("todo")
                }
            }
            
            Text("Bus Stop: \("todo")")
                .padding()
            
            ScheduledBusesView(buses: self.scheduledBuses)
                .frame(maxHeight: .infinity)
            Spacer()
        }
    }
}

#Preview {
    ContentView(scheduledBuses: [
        .init(route: "210-FA", time: Date.now),
        .init(route: "410-FA", time: Date.now.addingTimeInterval(10))
        ])
}
