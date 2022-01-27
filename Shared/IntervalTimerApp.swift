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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsView(workouts: $store.workouts) {
                    Task {
                        do {
                            try await WorkoutStore.save(workouts: store.workouts)
                        } catch {
                            fatalError("Error saving workouts.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.workouts = try await WorkoutStore.load()
                } catch {
                    fatalError("Error loading workouts.")
                }
            }
        }
    }
}
