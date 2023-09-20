//
//  Widgets.swift
//  Widgets
//
//  Created by fernando.troncoso on 11/9/23.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct Widgets: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeTrackingAttributes.self) { context in
            TimeTrackingWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Main \(context.state.startTime)")
                }
            } compactLeading: {
                Text("CL \(context.state.startTime)")
            } compactTrailing: {
                Text("CT \(context.state.startTime)")
            } minimal: {
                Text("M \(context.state.startTime)")
            }

        }

    }
}

struct TimeTrackingWidgetView: View {
    let context: ActivityViewContext<TimeTrackingAttributes>
    
    var body: some View {
        Text(context.state.startTime)
    }
}
