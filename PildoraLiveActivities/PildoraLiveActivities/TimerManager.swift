//
//  TimerManager.swift
//  PildoraLiveActivities
//
//  Created by fernando.troncoso on 20/9/23.
//

import Foundation
import ActivityKit
import SwiftUI

class TimerManager: ObservableObject {
    static let manager = TimerManager()
    @Published var isTrackingTime: Bool = false
    @Published var startTime: Date? = nil
    @Published var activity: Activity<TimeTrackingAttributes>? = nil
    @Published var elapsedTime = 0
    @Published var timer: Timer? = nil
    
    func startActivity() {
        let attributes = TimeTrackingAttributes()
        let state = TimeTrackingAttributes.ContentState(startTime: TimeResourses.formatTime(seconds: elapsedTime))
        let content = ActivityContent(state: state, staleDate: nil)
        activity = try? Activity<TimeTrackingAttributes>.request(attributes: attributes, content: content, pushType: nil)
    }
    
    func stopActivity() {
        let state = TimeTrackingAttributes.ContentState(startTime: TimeResourses.formatTime(seconds: elapsedTime))
        let content = ActivityContent(state: state, staleDate: nil)
        Task {
            await activity?.end(content, dismissalPolicy: .immediate)
        }
    }
    
    func updateActivity() {
        let state = TimeTrackingAttributes.ContentState(startTime: TimeResourses.formatTime(seconds: elapsedTime))
        let content = ActivityContent(state: state, staleDate: nil)
        Task {
            await activity?.update(content)
        }
    }
}
