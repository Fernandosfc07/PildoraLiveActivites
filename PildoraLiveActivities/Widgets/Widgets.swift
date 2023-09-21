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
    @ObservedObject var timerManager = TimerManager.manager
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeTrackingAttributes.self) { context in
            TimeTrackingWidgetView(context: context, timerManager: timerManager)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "clock")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .padding(.leading, 20)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Spacer()
                        Text("\(context.state.startTime)")
                            .font(Font.system(size: 20, design: .default))
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                        Spacer()
                    }
                }
            } compactLeading: {
                Image(systemName: "clock")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .padding(.leading, 24)
            } compactTrailing: {
                Text("\(context.state.startTime)")
                    .padding(.trailing, 24)
            } minimal: {
                Text("\(context.state.startTime)")
            }
            
        }
        
    }
}

struct TimeTrackingWidgetView: View {
    let context: ActivityViewContext<TimeTrackingAttributes>
    let timerManager: TimerManager
    
    var body: some View {
        Text(context.state.startTime)
            .font(Font.system(size: 50, design: .default))
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(.vertical, 30)
            .background(Color.black)
    }
}
