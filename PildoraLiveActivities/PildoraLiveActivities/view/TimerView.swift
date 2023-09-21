//
//  TimerView.swift
//  PildoraLiveActivities
//
//  Created by fernando.troncoso on 12/9/23.
//

import Foundation
import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timerManager = TimerManager.manager
    
    var body: some View {
        VStack {
            Text("\(TimeResourses.formatTime(seconds: timerManager.elapsedTime))")
                .font(Font.system(size: 60, design: .default))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.horizontal, 50)
                .padding(.bottom, 100)
            HStack {
                Button {
                    timerManager.elapsedTime = 0
                    timerManager.invalidateTimer()
                    timerManager.stopActivity()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    if timerManager.timer == nil {
                        timerManager.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            timerManager.elapsedTime += 1
                        }
                        if !timerManager.isStartActivity {
                            timerManager.startActivity()
                        }
                    } else {
                        timerManager.invalidateTimer()
                    }
                }) {
                    Image(systemName: timerManager.timer == nil ? "play.circle.fill" : "pause.circle.fill")
                        .resizable()
                        .font(.largeTitle)
                        .foregroundColor(timerManager.timer == nil ? .green : .red)
                        .frame(width: 80, height: 80)
                }
            }
            .padding(.horizontal, 50)
        }
        .onChange(of: timerManager.elapsedTime, perform: { _ in
            timerManager.updateActivity()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
