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
    let timerManager: TimerManager
    
    var body: some View {
        HStack {
            Text(context.state.startTime)
                .font(Font.system(size: 30, design: .default))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
            Spacer()
            HStack(spacing: 24) {
                Button {
                    timerManager.elapsedTime = 0
                    timerManager.stopActivity()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .font(.largeTitle)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: {
                if timerManager.timer == nil {
                    timerManager.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        timerManager.elapsedTime += 1
                    }
                    
                    timerManager.startActivity()
                } else {
                    timerManager.timer?.invalidate()
                    timerManager.timer = nil
                }
            }) {
                Image(systemName: timerManager.timer == nil ? "play.circle.fill" : "pause.circle.fill")
                    .resizable()
                    .font(.largeTitle)
                    .foregroundColor(timerManager.timer == nil ? .green : .red)
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
