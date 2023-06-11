//
//  NearbyBusView.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import SwiftUI
import ActivityKit

struct NearbyBusView: View {
    var bus: NearbyBus
    @State var tripDetails: BusTripDetails? = nil
    @State var selectedDestination: RouteDetail? = nil
    @Binding var liveActivity: Activity<LiveBusAttributes>?
    
    var body: some View {
        VStack( spacing: 16) {
            LazyVGrid(columns: [GridItem(.fixed(80)), GridItem(.flexible())], alignment: .leading, content: {
                Image(systemName: "bus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Arrival Time")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(bus.arrivalTime)
                        .font(.headline)
                }
                
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("From")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(bus.fromStationName)
                        .font(.subheadline)
                }
                
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("To")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(bus.toStationName)
                        .font(.subheadline)
                }
                
                Image(systemName: "number.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Route")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(bus.routeName)
                        .font(.subheadline)
                }
            })
        }
        .onAppear {
            Task(priority: .high) {
                let vehicleId = try! await getVehicleId(busno: bus.busNo)
                let tripDets = try! await getBusTripData(vehicleId: vehicleId)
                DispatchQueue.main.async {
                    self.tripDetails = tripDets
                }
            }
        }
        
        if let tripDetails = self.tripDetails {
            if liveActivity == nil {
                HStack {
                    Spacer()
                    Picker("Destination", selection: $selectedDestination) {
                        Text("None").tag(nil as RouteDetail?)
                        ForEach(tripDetails.routeDetails.filter({ i in
                            i.stopstatus == 1
                        }), id: \.self) {
                            Text($0.stationname)
                                .tag($0 as RouteDetail?)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button("Start live activity") {
                        let activity = try! Activity<LiveBusAttributes>.request(attributes: LiveBusAttributes(busNumber: bus.routeNo, destination: selectedDestination!.stationname), content: .init(state: .init(eta: self.selectedDestination!.eta!), staleDate: nil))
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .disabled(selectedDestination == nil)
                    Spacer()
                }
            }
        }
    }
}
