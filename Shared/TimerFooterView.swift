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
    let exercises: [Workout.Exercise]
    let theme: Theme
    
    private var nextText: String {
        if currExercise < totalExercises && currSet <= totalSets {
            return "Next exercise: \(exercises[currExercise].name)"
        } else if currSet < totalSets {
            return "Next exercise: \(exercises[0].name)"
        } else {
            return "Last exercise!"
        }
    }
    
    var body: some View {
        VStack {
            Text("Exercise \(currExercise) of \(totalExercises)")
            Text("")
            Text("Set \(currSet) of \(totalSets)")
            Text("")
            Text(nextText)
        }
        .padding()
        .font(.headline)
        .foregroundColor(theme.accentColor)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(theme.mainColor)
        }
    }
}

struct TimerFooterView_Preview: PreviewProvider {
    static var previews: some View {
        TimerFooterView(currExercise: 1, totalExercises: 6, currSet: 2, totalSets: 3, exercises: Workout.sampleData[0].exercises, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
    }
}
