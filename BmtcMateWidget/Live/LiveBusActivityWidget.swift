//
//  LiveBusActivityWidget.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import Foundation
import WidgetKit
import SwiftUI

struct LiveBusActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveBusAttributes.self) { context in
            VStack {
                Spacer()
                Text("On the way to \(context.attributes.destination)")
                Spacer()
                HStack {
                    Spacer()
                    Label {
                        Text("Route \(context.attributes.busNumber)")
                    } icon: {
                        Image(systemName: "bus")
                            .foregroundColor(.blue)
                    }
                    .font(.title2)
                    Spacer()
                    Label {
                        Text(context.state.eta)
                    } icon: {
                        Image(systemName: "bus")
                            .foregroundColor(.blue)
                    }
                    .font(.title2)
                    Spacer()
                }
                Spacer()
            }
            .activitySystemActionForegroundColor(.blue)
            .activityBackgroundTint(.cyan)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label(context.attributes.destination, systemImage: "bus")
                        .foregroundColor(.indigo)
                        .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(context.state.eta)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "bus")
                            .foregroundColor(.indigo)
                    }
                    .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("On the way to \(context.attributes.destination)")
                        .lineLimit(1)
                        .font(.caption)
                }
            } compactLeading: {
                Label {
                    Text(context.attributes.destination)
                } icon: {
                    Image(systemName: "bus")
                        .foregroundColor(.blue)
                }
                .font(.caption2)
            } compactTrailing: {
                Text(context.state.eta)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "bus")
                    Text(context.state.eta)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                }
            }
        }
    }
}

func formatItLikeILikeIt(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
}
