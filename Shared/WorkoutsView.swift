//
//  WorkoutsView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 21/01/22.
//

import SwiftUI

struct WorkoutsView: View {
    @Binding var workouts: [Workout]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewWorkoutView = false
    @State private var newWorkoutData = Workout.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($workouts) { $workout in
                NavigationLink(destination: DetailView(workout: $workout) ) {
                    CardView(workout: workout)
                }
                .listRowBackground(workout.theme.mainColor)
            }
            .onDelete { offsets in
                workouts.remove(atOffsets: offsets)
            }
        }
        .navigationTitle("Workouts")
        .toolbar {
            Button(action: {
                isPresentingNewWorkoutView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Workout")
        }
        .sheet(isPresented: $isPresentingNewWorkoutView) {
            NavigationView {
                DetailEditView(data: $newWorkoutData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingNewWorkoutView = false
                                newWorkoutData = Workout.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newWorkout = Workout(data: newWorkoutData)
                                workouts.append(newWorkout)
                                isPresentingNewWorkoutView = false
                                newWorkoutData = Workout.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}



struct WorkoutsView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsView(workouts: .constant(Workout.sampleData), saveAction: {})
        }
    }
}
