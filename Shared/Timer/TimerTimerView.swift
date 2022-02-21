//
//  TimerTimerView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 27/01/22.
//

import Foundation
import SwiftUI

struct TimerTimerView: View {
    let exerciseName: String
    let timeElapsed: Double
    let timeTotal: Double
    let isResting: Bool
    let nextText: String
    let theme: Theme
    
    var body: some View {
        ZStack {
            if isResting {
                Circle()
                    .fill(Color.pink)
            } else {
                Circle()
                    .fill(Color.green)
            }
            Circle()
                .strokeBorder(theme.mainColor, lineWidth: 24)
                .overlay {
                    VStack {
                        Text(exerciseName)
                            .font(.largeTitle)
                        Text("\(Int(ceil(timeTotal-timeElapsed)))")
                            .font(.title)
                        if isResting {
                            Text(nextText)
                                .font(.title2)
                        }
                    }
                }
                .overlay {
                    TimerArc(timeElapsed: timeElapsed, timeTotal: timeTotal)
                        .rotation(Angle(degrees: -90))
                        .stroke(theme.accentColor, lineWidth: 12)
                }
        }
    }
}

struct TimerTimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerTimerView(exerciseName: "Pushups", timeElapsed: Double(3), timeTotal: Double(15), isResting: false, nextText: "Situps", theme: .navy)
    }
}
