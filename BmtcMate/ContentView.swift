import SwiftUI
import CoreLocation

struct ContentView: View {
    @State var showManualSelectSheet: Bool = false
    @State var isDetectingNearby: Bool = false
    @StateObject var locationViewModel = LocationViewModel()
    @State var nearbyStations: [NearbyBusStation] = []
    @State var nearbyStation: NearbyBusStation? = nil
    
    var body: some View {
        NavigationStack {
            Text("BmtcMate")
                .font(.largeTitle)
                .animation(.linear)
            HStack(spacing: 16) {
                Button(action: {
                    updateLoc()
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
                
                .onAppear {
                    print("no u")
                    updateLoc()
                }
            }
            
            if let nearbyStation = nearbyStation {
                Text("Bus Station: \(nearbyStation.name)")
                    .padding()
            } else {
                Text(isDetectingNearby ? "" : "No nearby bus station found")
            }
            
            
//                List(scheduledBuses) { bus in
//                    NavigationLink(bus.route, value: bus)
//                }
//                .navigationDestination(for: ScheduledBusRoute.self) { bus in
//                    ScheduledBusInfoView(bus: bus)
//                        .navigationTitle(Text(bus.route))
//                }
            
            Text("\(self.locationViewModel.authorizationStatus.rawValue)")
            Text("\(self.locationViewModel.lastSeenLocation.debugDescription )")
            Spacer()
        }
    }
    
    func updateLoc() {
        self.isDetectingNearby = true
        self.locationViewModel.requestPermission()
        if locationViewModel.authorizationStatus == .authorizedAlways || locationViewModel.authorizationStatus == .authorizedWhenInUse {
            guard let loc = self.locationViewModel.lastSeenLocation else {
                self.nearbyStations = []
                self.nearbyStation = nil
                self.isDetectingNearby = false
                return
            }
            Task {
                print(loc.coordinate)
                let data: [NearbyBusStation]
                do {
                    data = try await getNearbyStations(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
                } catch {
                    self.nearbyStations = []
                    self.nearbyStation = nil
                    self.isDetectingNearby = false
                    return
                }
                DispatchQueue.main.async {
                    self.nearbyStations = data
                    self.nearbyStation = self.nearbyStations[0]
                }
            }
        } else {
            self.nearbyStations = []
            self.nearbyStation = nil
            self.isDetectingNearby = false
        }
    }
}

struct LoadingAnimationValues: Animatable {
    var angle: Angle = Angle.zero
}

#Preview {
    //    ContentView(scheduledBuses: [
    //        .init(route: "210-FA", time: Date.now),
    //        .init(route: "410-FA", time: Date.now.addingTimeInterval(10))
    //        ])
}
