//
//  TimerView.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 21/01/22.
//

import SwiftUI

struct TimerView: View {
    @Binding var workout: Workout
    @StateObject var workoutTimer = WorkoutTimer()
    private var working: Bool {
        !workoutTimer.timerStopped
    }
    
    var body: some View {
        if working {
            VStack {
                TimerHeaderView(secondsElapsed: workoutTimer.secondsElapsed, secondsRemaining: workoutTimer.secondsRemaining, theme: workout.theme)
                TimerTimerView(exerciseName: workoutTimer.currExercise, timeElapsed: workoutTimer.secondsElapsedForSection, timeTotal: workoutTimer.totalSectionTime, isResting: workoutTimer.isResting, theme: workout.theme)
                TimerFooterView(currExercise: workoutTimer.exerciseIndex + 1, totalExercises: workout.exercises.count, currSet: workoutTimer.setIndex + 1, totalSets: workout.sets, exercises: workout.exercises, theme: workout.theme)
            }
            .padding()
            .onAppear {
                workoutTimer.reset(workTime: workout.workTime, restTime: workout.restTime, restBetweenSets: workout.restBetweenSets, sets: workout.sets, exercises: workout.exercises)
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
        TimerView(workout: .constant(Workout.sampleData[0]))
    }
}
