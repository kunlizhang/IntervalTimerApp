//
//  NewQuickWorkoutView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 31/01/22.
//

import SwiftUI

struct NewQuickWorkoutView: View {
    @State private var data = Workout.Data()
    @State private var exerciseCount = Double(0)
    @State private var workout = Workout(data: Workout.Data())
    @Binding var settings: Settings
    
    private var getSetsText: String {
        if data.sets == 1 {
            return "set"
        } else {
            return "sets"
        }
    }
    
    private var getExercisesText: String {
        if data.exercises.count == 1 {
            return "exercise"
        } else {
            return "exercises"
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Workout Info")) {
                VStack {
                    HStack {
                        Slider(value: $data.sets, in: 1...10, step: 1) {
                            Text("Number of sets")
                        }
                        .accessibilityValue("\(Int(data.sets)) \(getSetsText)")
                        Spacer()
                        Text("\(Int(data.sets)) \(getSetsText)")
                            .accessibilityHidden(true)
                    }
                    HStack {
                        Slider(value: $data.restBetweenSets, in: 0...120, step: 5) {
                            Text("Rest between sets")
                        }
                        .accessibilityValue("\(Int(data.restBetweenSets))s rest")
                        Spacer()
                        Text("\(Int(data.restBetweenSets))s rest")
                            .accessibilityHidden(true)
                    }
                }
            }
            Section(header: Text("For each set")) {
                HStack {
                    Slider(value: $data.workTime, in: 5...120, step: 5) {
                        Text("Work time")
                    }
                    .accessibilityValue("\(Int(data.workTime))s on")
                    Spacer()
                    Text("\(Int(data.workTime))s on")
                        .accessibilityHidden(true)
                }
                HStack {
                    Slider(value: $data.restTime, in: 0...120, step: 5) {
                        Text("Rest time")
                    }
                    .accessibilityValue("\(Int(data.restTime))s off")
                    Spacer()
                    Text("\(Int(data.restTime))s off")
                        .accessibilityHidden(true)
                }
                HStack {
                    Slider(value: Binding(
                        get: { self.exerciseCount },
                        set: { (newVal) in
                            data.exercises = []
                            for index in 1...Int(newVal) {
                                data.exercises.append(Workout.Exercise(name: "Exercise \(index)"))
                            }
                            workout.update(from: data)
                            self.exerciseCount = newVal
                        }), in: 1...20, step: 1) {
                        Text("Number of exercises")
                    }
                    Spacer()
                    Text("\(Int(self.exerciseCount)) \(getExercisesText)")
                }
            }
            Section(footer: Text("Set changes before starting the workout")) {
                Button(action: {
                    workout.update(from: data)
                }, label: {
                    Label("Set Changes", systemImage: "square.and.arrow.down")
                })
                .font(.headline)
                NavigationLink(destination: TimerView(workout: $workout, settings: $settings)) {
                    Label("Start Workout", systemImage: "timer")
                        .font(.headline)
                }
                .disabled(exerciseCount == 0)
            }
        }
    }
}

struct NewQuickWorkoutView_Preview: PreviewProvider {
    static var previews: some View {
        NewQuickWorkoutView(settings: .constant(Settings()))
    }
}
