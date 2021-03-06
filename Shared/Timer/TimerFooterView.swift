//
//  TimerFooterView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 26/01/22.
//

import SwiftUI

struct TimerFooterView: View {
    let currExercise: Int
    let totalExercises: Int
    let currSet: Int
    let totalSets: Int
    let theme: Theme

    
    var body: some View {
        VStack {
            Text("Exercise \(currExercise) of \(totalExercises)")
            Text("")
            Text("Set \(currSet) of \(totalSets)")
        }
        .padding()
        .font(.title2)
        .foregroundColor(theme.accentColor)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(theme.mainColor)
        }
    }
}

struct TimerFooterView_Preview: PreviewProvider {
    static var previews: some View {
        TimerFooterView(currExercise: 1, totalExercises: 6, currSet: 2, totalSets: 3, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
    }
}
