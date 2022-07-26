//
//  TimerView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 21/01/22.
//

import SwiftUI

struct TimerView: View {
    @Binding var workout: Workout
    @Binding var settings: Settings
    @StateObject var workoutTimer = WorkoutTimer()
    private var working: Bool {
        !workoutTimer.timerStopped
    }
    private var nextText: String {
        if workoutTimer.exerciseIndex + 1 < workout.exercises.list.count && workoutTimer.setIndex <= workout.sets {
            return "Next exercise: \(workout.exercises.list[workoutTimer.exerciseIndex + 1])"
        } else if workoutTimer.setIndex < workout.sets {
            return "Next exercise: \(workout.exercises.list[0])"
        } else {
            return "Last exercise!"
        }
    }
    
    var body: some View {
        if working {
            VStack {
                TimerHeaderView(secondsElapsed: workoutTimer.secondsElapsed, secondsRemaining: workoutTimer.secondsRemaining, theme: workout.theme)
                TimerTimerView(exerciseName: workoutTimer.currExercise, timeElapsed: workoutTimer.secondsElapsedForSection, timeTotal: workoutTimer.totalSectionTime, isResting: workoutTimer.isResting, nextText: nextText, theme: workout.theme)
                TimerFooterView(currExercise: workoutTimer.exerciseIndex + 1, totalExercises: workout.exercises.list.count, currSet: workoutTimer.setIndex + 1, totalSets: workout.sets, theme: workout.theme)
            }
            .padding()
            .onAppear {
                workoutTimer.reset(workTime: workout.workTime, restTime: workout.restTime, restBetweenSets: workout.restBetweenSets, sets: workout.sets, exercises: workout.exercises, beepTime: settings.beepLength)
                workoutTimer.startWorkout()
            }
            .onDisappear {
                workoutTimer.stopWorkout()
            }
            .navigationBarTitleDisplayMode(.inline)
        } else {
            PostWorkoutView(workout: $workout)
        }
    }
}

struct TimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerView(workout: .constant(Workout.sampleData[0]), settings: .constant(Settings()))
    }
}
