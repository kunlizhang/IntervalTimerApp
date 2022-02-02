//
//  DetailEditView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 21/01/22.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: Workout.Data
    @State private var newExerciseName = ""
    @State private var editExercises: EditMode = .inactive
    
    private var getSetsText: String {
        if (data.sets == 1) {
            return "set"
        } else {
            return "sets"
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Workout Info")) {
                TextField("Title", text: $data.title)
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
            }
            Section(
                header: Text("Exercises (\(data.exercises.count))"),
                footer: Text("Press and hold to rearrange exercises")
            ) {
                ForEach(data.exercises) { exercise in
                    Text(exercise.name)
                }
                .onDelete { indices in
                    data.exercises.remove(atOffsets: indices)
                }
                .onMove {
                    data.exercises.move(fromOffsets: $0, toOffset: $1)
                }
                .onLongPressGesture {
                    if editExercises == .active {
                        editExercises = .inactive
                    } else {
                        editExercises = .active
                    }
                }
                HStack {
                    TextField("New Exercise", text: $newExerciseName)
                    Button(action: {
                        withAnimation {
                            let exercise = Workout.Exercise(name: newExerciseName)
                            data.exercises.append(exercise)
                            newExerciseName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add exercise")
                    }
                    .disabled(newExerciseName.isEmpty)
                }
            }
        }
        .environment(\.editMode, $editExercises)
    }
}

struct DetailEditView_Preview: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(Workout.sampleData[0].data))
    }
}
