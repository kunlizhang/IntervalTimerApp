//
//  WorkoutsView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 21/01/22.
//

import SwiftUI

struct WorkoutsView: View {
    @Binding var workouts: [Workout]
    @Binding var settings: Settings
    @State var newSettings = Settings.Data()
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewWorkoutView = false
    @State private var isPresentingSettingsView = false
    @State private var newWorkoutData = Workout.Data()
    @State private var moveWorkouts: EditMode = .inactive
    let saveAction: () -> Void
    let settingsSaveAction: () -> Void
    
    var body: some View {
        List {
            Section {
                NavigationLink(
                    destination: NewQuickWorkoutView(settings: $settings)
                        .navigationTitle("New Quick Workout")
                ) {
                    Text("Quick Workout")
                        .font(.headline)
                }
            }
            Section(header: HStack {
                Text("Saved Workouts")
//                padding()
//                Button(action: {
//                    if moveWorkouts == .inactive {
//                        moveWorkouts = .active
//                    } else {
//                        moveWorkouts = .inactive
//                    }
//                }, label: {
//                    if moveWorkouts == .inactive {
//                        Text("Edit")
//                    } else {
//                        Text("Done")
//                    }
//                })
            }) {
                ForEach($workouts) { $workout in
                    NavigationLink(destination: DetailView(workout: $workout, settings: $settings) ) {
                        CardView(workout: workout)
                    }
                    .listRowBackground(workout.theme.mainColor)
                }
                .onDelete { offsets in
                    workouts.remove(atOffsets: offsets)
                    saveAction()
                }
                .onMove {
                    workouts.move(fromOffsets: $0, toOffset: $1)
                    saveAction()
                }
            }
//            Section {
//                HStack(alignment: .center) {
//                    Banner()
//                }
//            }
        }
        .sheet(isPresented: $isPresentingNewWorkoutView) {
            NavigationView {
                DetailEditView(data: $newWorkoutData)
                    .navigationTitle(Text("New Workout"))
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
                                saveAction()
                                isPresentingNewWorkoutView = false
                                newWorkoutData = Workout.Data()
                            }
                            .disabled(newWorkoutData.exercises.count == 0 || newWorkoutData.title == "")
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingSettingsView) {
            NavigationView {
                SettingsView(settingsData: $newSettings)
                    .navigationTitle(Text("Settings"))
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingSettingsView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                settings.update(from: newSettings)
                                settingsSaveAction()
                                isPresentingSettingsView = false
                            }
                        }
                    }
            }
            .onAppear {
                newSettings = settings.data
            }
        }
        .environment(\.editMode, $moveWorkouts)
        .navigationTitle("Workouts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingNewWorkoutView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Workout")
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isPresentingSettingsView = true
                }) {
                    Image(systemName: "gearshape.fill")
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
            WorkoutsView(workouts: .constant(Workout.sampleData), settings: .constant(Settings()), saveAction: {}, settingsSaveAction: {})
        }
    }
}
