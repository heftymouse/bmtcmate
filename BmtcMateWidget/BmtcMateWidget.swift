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
            let refreshDate = Calendar.current.date(byAdding: .second, value: 30, to: .now)!
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
            HStack {
                Spacer()
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                Spacer()
                Text(entry.stop!.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Button(intent: WidgetIntent()) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }

            }
            
            VStack {
                Divider()
                ForEach(0..<5) { i in
                    HStack {
                        Image(systemName: "bus")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(entry.buses[i].routeNo.first == "V" ? .blue : .gray)
                            .padding(4)
                        VStack {
                            Text(entry.buses[i].routeNo)
                            Text(entry.buses[i].routeName)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(entry.buses[i].estimatedArrival)
                            Text(entry.buses[i].shortArriveTime)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    Divider()
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
