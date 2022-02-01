//
//  CardView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 20/01/22.
//

import SwiftUI

struct CardView: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(workout.exercises.count)", systemImage: "figure.walk")
                    .accessibilityLabel("\(workout.exercises.count) exercises")
                Spacer()
                Label(workout.lengthString, systemImage: "clock")
                    .padding(.trailing, 20)
                    .labelStyle(.trailingIcon)
                    .accessibilityLabel(workout.lengthString)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(workout.theme.accentColor)
    }
}

struct CardView_Preview: PreviewProvider {
    static var workout = Workout.sampleData[0]
    static var previews: some View {
        CardView(workout: workout)
            .background(workout.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
