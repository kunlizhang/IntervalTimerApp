//
//  IntervalTimerApp.swift
//  Shared
//
//  Created by Kunli Zhang on 20/01/22.
//

import SwiftUI

@main
struct IntervalTimerApp: App {
    @StateObject private var store = WorkoutStore()
    @StateObject private var settingsStore = SettingsStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsView(workouts: $store.workouts, settings: $settingsStore.settings, saveAction: {
                    Task {
                        do {
                            try await WorkoutStore.save(workouts: store.workouts)
                        } catch {
                            fatalError("Error saving workouts.")
                        }
                    }
                }, settingsSaveAction: {
                    Task {
                        do {
                            try await SettingsStore.save(settings: settingsStore.settings)
                        } catch {
                            fatalError("Error saving settings.")
                        }
                    }
                })
            }
            .task {
                do {
                    store.workouts = try await WorkoutStore.load()
                } catch {
                    fatalError("Error loading workouts.")
                }
            }
            .task {
                do {
                    settingsStore.settings = try await SettingsStore.load()
                } catch {
                    fatalError("Error loading settings.")
                }
            }
        }
    }
}
