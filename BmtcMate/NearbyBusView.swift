//
//  NearbyBusView.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import SwiftUI

struct NearbyBusView: View {
    var bus: NearbyBus
    
    var body: some View {
        VStack {
            Text(bus.arrivalTime)
            Text(bus.fromStationName)
            Text(bus.toStationName)
            Text(bus.routeName)
        }
    }
}
