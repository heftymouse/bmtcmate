//
//  BmtcMateWidget.swift
//  BmtcMateWidget
//
//  Created by Vasu Deshpande on 10/06/23.
//

import WidgetKit
import CoreLocation
import SwiftUI

struct Provider: TimelineProvider {
    let locationViewModel = LocationViewModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), stop: nil, buses: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), stop: nil, buses: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        if(!locationViewModel.authorizedForWidgetUpdates()) {
            locationViewModel.requestPermission()
            print("beans")
        }
        
        getNearbyBuses() { stop, buses in
            let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: .now)!
            let entry = SimpleEntry(date: .now, stop: stop, buses: buses)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
    
    func getNearbyBuses(completion: @escaping (NearbyBusStation, [NearbyBus]) -> Void) {
        Task {
            let loc = locationViewModel.lastSeenLocation
            let station = try! await getNearbyStations(latitude: loc!.coordinate.latitude, longitude: loc!.coordinate.longitude)[0]
            let buses = try! await BmtcMateWidgetExtension.getNearbyBuses(stationId: station.id);
            completion(station, buses)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let stop: NearbyBusStation?
    let buses: [NearbyBus]
}

struct BmtcMateWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.stop!.name)
            VStack {
                ForEach(0..<4) { i in
                    HStack {
                        Image(systemName: "bus")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding()
                        Text(entry.buses[i].routeNo)
                        Spacer()
                        Text(entry.buses[i].estimatedArrival)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct BmtcMateWidget: Widget {
    let kind: String = "BmtcMateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BmtcMateWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("BMTCMate")
        .description("BMTC on your Home Screen.")
        .supportedFamilies([.systemLarge])
    }
}

//#Preview(as: .systemMedium) {
//    BmtcMateWidget()
//} timeline: {
//    SimpleEntry(date: .now)
//    SimpleEntry(date: .now)
//}
