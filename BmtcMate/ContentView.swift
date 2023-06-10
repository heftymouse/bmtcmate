import SwiftUI

struct ContentView: View {
    @State var scheduledBuses: [ScheduledBusRoute] = []
    @State var showManualSelectSheet: Bool = false
    @State var isDetectingNearby: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("BmtcMate")
                .font(.largeTitle)
                .animation(.linear)
            HStack(spacing: 16) {
                Button(action: {
                    self.isDetectingNearby = true
                }) {
                    if isDetectingNearby {
                        Label(
                            title: { /*@START_MENU_TOKEN@*/Text("Detecting")/*@END_MENU_TOKEN@*/ },
                            icon: {
                                ProgressView()
                                    .padding(.trailing, 2)
                            }
                        )

                    } else {
                        Text("Detect nearby")
                    }
                }
                .disabled(isDetectingNearby)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Button(action: {
                    isDetectingNearby = false
                    showManualSelectSheet = true
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
            
            
            List(scheduledBuses) { bus in
                NavigationLink(bus.route, value: bus)
            }
            .navigationDestination(for: ScheduledBusRoute.self) { bus in
                ScheduledBusInfoView(bus: bus)
                    .navigationTitle(Text(bus.route))
            }
            
            Spacer()
        }
    }
}

struct LoadingAnimationValues: Animatable {
    var angle: Angle = Angle.zero
}

#Preview {
    ContentView(scheduledBuses: [
        .init(route: "210-FA", time: Date.now),
        .init(route: "410-FA", time: Date.now.addingTimeInterval(10))
        ])
}
