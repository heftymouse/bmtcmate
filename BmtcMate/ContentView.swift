import SwiftUI
import CoreLocation
import ActivityKit

struct ContentView: View {
    @State var showManualSelectSheet: Bool = false
    @State var isDetectingNearby: Bool = false
    @StateObject var locationViewModel = LocationViewModel()
    @State var nearbyStations: [NearbyBusStation] = []
    @State var nearbyStation: NearbyBusStation? = nil
    @State var nearbyBuses: [NearbyBus] = []
    @State var liveActivity: Activity<LiveBusAttributes>? = nil
    
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
                    Picker("Options", selection: $nearbyStation) {
                        Text("None")
                            .tag(nil as NearbyBusStation?)
                        ForEach(nearbyStations) { option in
                            Text("\(option.name)\nTowards \(option.towards)")
                                .tag(option as NearbyBusStation?)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding()
                    Button("Done") {
                        showManualSelectSheet = false
                    }
                    .frame(maxWidth: .infinity)
                }
                
                .onAppear {
                    print("no u")
                    updateLoc()
                }
                .onChange(of: nearbyStation) { oldValue, newValue in
                    Task(priority: .high) {
                        if let newValue = newValue {
                            let it = try! await getNearbyBuses(stationId: newValue.id)
                            DispatchQueue.main.async {
                                self.nearbyBuses = it
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.nearbyBuses = []
                            }
                        }
                    }
                }
                .onReceive(locationViewModel.$lastSeenLocation, perform: { _ in
                    updateLoc()
                })
            }
            
            if let nearbyStation = nearbyStation {
                Text("Bus Station: \(nearbyStation.name) (Towards \(nearbyStation.towards))")
                    .padding()
            } else {
                Text(isDetectingNearby ? "" : "No nearby bus station found")
            }
            
            
            List(self.nearbyBuses) { bus in
                NavigationLink("\(bus.arriveTimeTimeComponent) \(bus.routeNo) to \(bus.toStationName)", value: bus)
            }
            .navigationDestination(for: NearbyBus.self) { bus in
                NearbyBusView(bus: bus, liveActivity: $liveActivity)
                    .navigationTitle(Text(bus.routeNo))
            }
        }
    }
    
    func stopActivity() {
        Task {
            await self.liveActivity!.end(nil, dismissalPolicy: .immediate)
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
                    self.isDetectingNearby = false
                }
            }
        } else {
            self.nearbyStations = []
            self.nearbyStation = nil
            self.isDetectingNearby = false
        }
    }
}
