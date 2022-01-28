//
//  TimerHeaderView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 23/01/22.
//

import SwiftUI

struct TimerHeaderView: View {
    let secondsElapsed: Double
    let secondsRemaining: Double
    let theme: Theme
    
    private var totalSeconds: Double {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        Int(secondsRemaining / 60)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(Int(floor(secondsElapsed)))", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(Int(ceil(secondsRemaining)))", systemImage: "hourglass.tophalf.fill")
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
        .foregroundColor(theme.accentColor)
    }
}

struct TimerHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        TimerHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
    }
}
