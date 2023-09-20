//
//  TimerView.swift
//  PildoraLiveActivities
//
//  Created by fernando.troncoso on 12/9/23.
//

import Foundation
import SwiftUI
import ActivityKit

struct TimerView: View {
    
    @State private var isTrackingTime: Bool = false
    @State private var startTime: Date? = nil
    @State private var activity: Activity<TimeTrackingAttributes>? = nil
    @State private var elapsedTime = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("\(formatTime(seconds: elapsedTime))")
                .font(Font.system(size: 60, design: .default))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.horizontal, 50)
                .padding(.bottom, 100)
            
            HStack {
                Button {
                    elapsedTime = 0
                    self.stopActivity()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    if timer == nil {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            self.elapsedTime += 1
                        }
                        
                        self.startActivity()
                    } else {
                        timer?.invalidate()
                        timer = nil
                    }
                }) {
                    Image(systemName: timer == nil ? "play.circle.fill" : "pause.circle.fill")
                        .resizable()
                        .font(.largeTitle)
                        .foregroundColor(timer == nil ? .green : .red)
                        .frame(width: 80, height: 80)
                }
            }
            .padding(.horizontal, 50)
        }
        .onChange(of: elapsedTime, perform: { _ in
            self.updateActivity()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
    
    func startActivity() {
        let attributes = TimeTrackingAttributes()
        let state = TimeTrackingAttributes.ContentState(startTime: formatTime(seconds: elapsedTime))
        let content = ActivityContent(state: state, staleDate: nil)
        activity = try? Activity<TimeTrackingAttributes>.request(attributes: attributes, content: content, pushType: nil)
    }
    
    func stopActivity() {
        let state = TimeTrackingAttributes.ContentState(startTime: formatTime(seconds: elapsedTime))
        let content = ActivityContent(state: state, staleDate: nil)
        Task {
            await activity?.end(content, dismissalPolicy: .immediate)
        }
    }
    
    func updateActivity() {
        let state = TimeTrackingAttributes.ContentState(startTime: formatTime(seconds: elapsedTime))
        let content = ActivityContent(state: state, staleDate: nil)
        Task {
            await activity?.update(content)
        }
    }
    
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
