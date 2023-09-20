//
//  ContentView.swift
//  PildoraLiveActivities
//
//  Created by fernando.troncoso on 5/9/23.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State private var isTrackingTime: Bool = false
    @State private var startTime: Date? = nil
    @State private var activity: Activity<TimeTrackingAttributes>? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    if let startTime {
                        Text(startTime, style: .relative)
                    } else {
                        Color.clear
                    }
                }
                .frame(height: 30)

                Button {
                    isTrackingTime.toggle()
                    if isTrackingTime {
                        startTime = .now
                        //Comenzamos la actividad
//                        startActivity()
                    } else {
                        //Acabamos la actividad
//                        stopActivity()
                        self.startTime = nil
                    }
                } label: {
                    Text(isTrackingTime ? "Stop" : "Start")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .background(Circle().fill(isTrackingTime ? .red : .green))
                }
                .navigationTitle("Temporizador")
            }
        }
    }
    
//    func startActivity() {
//        let attributes = TimeTrackingAttributes()
//        let state = TimeTrackingAttributes.ContentState(startTime: .now)
//        let content = ActivityContent(state: state, staleDate: nil)
//        activity = try? Activity<TimeTrackingAttributes>.request(attributes: attributes, content: content, pushType: nil)
//    }
//
//    func stopActivity() {
//        guard let startTime else { return }
//        let state = TimeTrackingAttributes.ContentState(startTime: startTime)
//        let content = ActivityContent(state: state, staleDate: nil)
//        Task {
//            await activity?.end(content, dismissalPolicy: .immediate)
//        }
//    }
}
