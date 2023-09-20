//
//  TimeResourses.swift
//  PildoraLiveActivities
//
//  Created by fernando.troncoso on 20/9/23.
//

import Foundation

class TimeResourses {
    static func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
