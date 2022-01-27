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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(workout.theme.mainColor)
            VStack {
                TimerHeaderView(secondsElapsed: workoutTimer.secondsElapsed, secondsRemaining: workoutTimer.secondsRemaining, theme: workout.theme)
                TimerTimerView(exercise: workoutTimer.currExercise, theme: workout.theme)
                TimerFooterView(currExercise: workoutTimer.exerciseIndex + 1, totalExercises: workout.exercises.count, currSet: workoutTimer.setIndex + 1, totalSets: workout.sets, theme: workout.theme)
            }
        }
        .padding()
        .foregroundColor(workout.theme.accentColor)
        .onAppear {
            workoutTimer.reset(workTime: workout.workTime, restTime: workout.restTime, restBetweenSets: workout.restBetweenSets, sets: workout.sets, exercises: workout.exercises)
            workoutTimer.startWorkout()
        }
        .onDisappear {
            workoutTimer.stopWorkout()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TimerView_Preview: PreviewProvider {
    static var previews: some View {
        TimerView(workout: .constant(Workout.sampleData[0]))
    }
}
