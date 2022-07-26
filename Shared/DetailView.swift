//
//  DetailView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 21/01/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var workout: Workout
    @Binding var settings: Settings
    
    @State private var data = Workout.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section() {
                NavigationLink(destination: TimerView(workout: $workout, settings: $settings)) {
                    Label("Start Workout", systemImage: "timer")    
                        .font(.headline)
                }
            }
            Section(header: Text("Workout Info")) {
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text(workout.lengthString)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("On", systemImage: "play.fill")
                    Spacer()
                    Text("\(workout.workTime) seconds")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Off", systemImage: "pause.fill")
                    Spacer()
                    Text("\(workout.restTime) seconds")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Rest", systemImage: "figure.stand")
                    Spacer()
                    Text("\(workout.restBetweenSets) seconds")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Sets", systemImage: "goforward")
                    Spacer()
                    Text("\(workout.sets)")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(workout.theme.name)
                        .padding(4)
                        .foregroundColor(workout.theme.accentColor)
                        .background(workout.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Exercises (\(workout.exercises.list.count))")) {
                List(workout.exercises.list) { exercise in
                    Label(exercise, systemImage: "figure.walk")
                }
            }
        }
        .navigationTitle(workout.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = workout.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(workout.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                workout.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(workout: .constant(Workout.sampleData[0]), settings: .constant(Settings()))
        }
    }
}
