//
//  TimeTrackingAttributes.swift
//  PildoraLiveActivities
//
//  Created by fernando.troncoso on 11/9/23.
//

import Foundation
import ActivityKit

struct TimeTrackingAttributes: ActivityAttributes {
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: String
    }
}
