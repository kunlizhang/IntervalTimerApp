//
//  TimerTimerView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 27/01/22.
//

import Foundation
import SwiftUI

struct TimerTimerView: View {
    let exercise: String
    let theme: Theme
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                Text(exercise)
                    .font(.title)
            }
            .foregroundStyle(theme.accentColor)
    }
}

struct TimerTimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerTimerView(exercise: "Pushups" , theme: .bubblegum)
    }
}
