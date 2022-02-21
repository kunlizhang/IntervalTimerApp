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
        guard secondsRemaining > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private func timeFormatString(timeInSeconds: Int) -> String {
        var seconds: String
        if timeInSeconds % 60 < 10 {
            seconds = "0\(timeInSeconds % 60)"
        } else {
            seconds = "\(timeInSeconds % 60)"
        }
        return "\(timeInSeconds/60):" + seconds
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack(alignment: .leading) {
                    Text("Time Elapsed")
                        .font(.headline)
                    Label(timeFormatString(timeInSeconds: Int(floor(secondsElapsed))), systemImage: "hourglass.bottomhalf.fill")
                        .font(.title2)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Time Remaining")
                        .font(.headline)
                    Label(timeFormatString(timeInSeconds: Int(ceil(secondsRemaining))), systemImage: "hourglass.tophalf.fill")
                        .font(.title2)
                }
            }
        }
        .foregroundColor(theme.accentColor)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue(timeFormatString(timeInSeconds: Int(ceil(secondsRemaining))))
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(theme.mainColor)
        }
    }
}

struct TimerHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        TimerHeaderView(secondsElapsed: 60, secondsRemaining: 189, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
    }
}
