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
    let timeElapsed: Int
    let timeTotal: Int
    let theme: Theme
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                Text(exerciseName)
                    .font(.title)
            }
            .foregroundStyle(theme.accentColor)
            .overlay {
                TimerArc(timeElapsed: timeElapsed, timeTotal: timeTotal)
                    .rotation(Angle(degrees: -90))
                    .stroke(theme.mainColor, lineWidth: 12)
            }
    }
}

struct TimerTimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerTimerView(exerciseName: "Pushups", timeElapsed: 3, timeTotal: 15, theme: .bubblegum)
    }
}
