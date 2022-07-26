//
//  PostWorkoutView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 1/02/22.
//

import SwiftUI

struct PostWorkoutView: View {
    @State var showAd: Bool = true
    @Binding var workout: Workout
    
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
        List {
            Text("You did it!")
                .font(.headline)
            Section(header: Text("Key stats")) {
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text(workout.lengthString)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Total work time", systemImage: "timer")
                    Spacer()
                    Text(timeFormatString(timeInSeconds: workout.workTime*workout.sets*workout.exercises.list.count))
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Number of exercises", systemImage: "figure.walk")
                    Spacer()
                    Text("\(workout.exercises.list.count)")
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Exercises")) {
                List(workout.exercises.list) { exercise in
                    Label(exercise, systemImage: "figure.walk")
                }
            }
        }
        .navigationTitle(workout.title)
        .presentInterstitialAd(isPresented: $showAd, adUnitId: "ca-app-pub-3940256099942544/4411468910")
    }
}

struct PostWorkoutView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostWorkoutView(workout: .constant(Workout.sampleData[0]))
        }
    }
}
