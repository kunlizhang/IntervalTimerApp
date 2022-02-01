//
//  WorkoutTimer.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 23/01/22.
//

import Foundation

class WorkoutTimer: ObservableObject {
    
    struct Exercise: Identifiable {
        let name: String
        let id = UUID()
    }
    
    @Published var currExercise = ""
    @Published var secondsElapsed = Double(0)
    @Published var secondsRemaining = Double(0)
    private(set) var exercises: [Exercise] = []
    
    private(set) var lengthInMinutes: Int
    
    /// A closure that is executed when the exercise changes
    var exerciseChangedAction: (() -> Void)?
    
    private var timer: Timer?
    private var frequency: TimeInterval { 1.0 / 60.0 }
    @Published var timerStopped = false
    private var workTime: Int
    private var restTime: Int
    private var restBetweenSets: Int
    private var sets: Int
    private var lengthInSeconds: Int {((self.workTime * self.exercises.count + self.restTime * (self.exercises.count - 1)) * (self.sets) + self.restBetweenSets * (self.sets - 1))}
    
    @Published var secondsElapsedForSection: Double = 0
    @Published var setIndex: Int = 0
    @Published var exerciseIndex: Int = 0
    @Published var isResting: Bool = false
    @Published var totalSectionTime: Double = 0
    private var startDate: Date?
    
    init(workTime: Int = 0, restTime: Int = 0, restBetweenSets: Int = 0, sets: Int = 1, exercises: [Workout.Exercise] = []) {
        self.workTime = workTime
        self.restTime = restTime
        self.restBetweenSets = restBetweenSets
        self.sets = sets
        self.exercises = exercises.exercises
        self.secondsRemaining = Double(((self.workTime * self.exercises.count + self.restTime * (self.exercises.count - 1)) * (self.sets) + self.restBetweenSets * (self.sets - 1)))
        self.lengthInMinutes =  ((self.workTime * self.exercises.count + self.restTime * (self.exercises.count - 1)) * (self.sets) + self.restBetweenSets * (self.sets - 1)) / 60
    }
    
    func startWorkout() {
        timerStopped = false
        self.exerciseIndex = 0
        self.setIndex = 0
        currExercise = "Ready?"
        totalSectionTime = 3
        self.isResting = true
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            self.secondsElapsedForSection += self.frequency
            if Int(floor(self.secondsElapsedForSection)) == 3 {
                timer.invalidate()
                self.changeToExercise(at: 0)
            }
        }
    }
    
    func stopWorkout() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }
    
    // Current implementation means that you must start from the first exercise
    private func changeToExercise(at index: Int) {
        isResting = false
        secondsElapsedForSection = 0
        totalSectionTime = Double(workTime)
        guard index < exercises.count else { return }
        exerciseIndex = index
        currExercise = exercises[exerciseIndex].name
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            self.secondsElapsedForSection += self.frequency
            self.secondsElapsed += self.frequency
            self.secondsRemaining -= self.frequency
            
            if Int(floor(self.secondsElapsedForSection)) == self.workTime {
                timer.invalidate()
                
                if self.exerciseIndex == self.exercises.count - 1 && self.setIndex < self.sets - 1 {
                    self.rest(length: self.restBetweenSets, post: {self.setIndex += 1; self.changeToExercise(at: 0)})
                    
                } else if self.exerciseIndex < self.exercises.count - 1 && self.setIndex < self.sets {
                    self.rest(length: self.restTime, post: {self.changeToExercise(at: self.exerciseIndex + 1)})
                } else {
                    self.stopWorkout()
                }
            }
        }
    }
    
    private func rest(length: Int,  post:@escaping () -> Void) {
        isResting = true
        currExercise = "Rest"
        secondsElapsedForSection = 0
        totalSectionTime = Double(length)
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            self.secondsElapsedForSection += self.frequency
            self.secondsElapsed += self.frequency
            self.secondsRemaining -= self.frequency
            if Int(floor(self.secondsElapsedForSection)) == length {
                timer.invalidate()
                post()
            }
        }
    }
    
    func reset(workTime: Int, restTime: Int, restBetweenSets: Int, sets: Int, exercises: [Workout.Exercise]) {
        self.workTime = workTime
        self.restTime = restTime
        self.restBetweenSets = restBetweenSets
        self.sets = sets
        self.exercises = exercises.exercises
        self.secondsRemaining = Double((self.workTime * self.exercises.count + self.restTime * (self.exercises.count - 1)) * (self.sets) + self.restBetweenSets * (self.sets - 1))
        self.lengthInMinutes =  ((self.workTime * self.exercises.count + self.restTime * (self.exercises.count - 1)) * (self.sets) + self.restBetweenSets * (self.sets - 1)) / 60
        currExercise = exercises[0].name
    }
    
    /*
    private func changeToExercise(at index: Int) {
        if index > 0 {
            let previousExerciseIndex = index - 1
            exercises[previousExerciseIndex].isCompleted = true
        }
        if index > self.exercises.count {
            self.currSetIndex += 1
        }
        secondsElapsedForExercise = 0
        guard currSetIndex < self.sets else { return }
        
        if index < exercises.count {
            exerciseIndex = index
        } else {
            exerciseIndex = 0
        }
        currExercise = exerciseText
        
        secondsElapsed = (self.workTime + self.restTime) * (self.currSetIndex) * (self.exercises.count - 1) + (self.workTime + self.restTime) * (self.exerciseIndex - 1) + self.restBetweenSets * (self.currSetIndex)
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
            }
        }
    }
    
    private func update(secondsElapsed: Int) {
        secondsElapsedForExercise = secondsElapsed
        self.secondsElapsed = (self.workTime + self.restTime) * (self.currSetIndex) * (self.exercises.count - 1) + (self.workTime + self.restTime) * (self.exerciseIndex - 1) + self.restBetweenSets * (self.currSetIndex) + secondsElapsedForExercise
        guard secondsElapsed <= workTime else {
            return
        }
        secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)
        
        guard !timerStopped else { return }
        
        if secondsElapsedForExercise >= workTime {
            if exerciseIndex >= exercises.count {
                rest(secondsElapsed: secondsElapsed, lengthOfRest: restBetweenSets)
            } else {
                rest(secondsElapsed: secondsElapsed, lengthOfRest: restTime)
            }
            changeToExercise(at: exerciseIndex + 1)
            exerciseChangedAction?()
        }
    }
    
    private func rest(secondsElapsed: Int, lengthOfRest: Int) {
        self.isResting = true
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                
            }
        
        }
    }
    */
}

extension Workout {
    var timer: WorkoutTimer {
        WorkoutTimer(workTime: workTime, restTime: restTime, restBetweenSets: restBetweenSets, sets: sets, exercises: exercises)
    }
}

extension Array where Element == Workout.Exercise {
    var exercises: [WorkoutTimer.Exercise] {
        if isEmpty {
            return [WorkoutTimer.Exercise(name: "Exercise 1")]
        } else {
            return map { WorkoutTimer.Exercise(name: $0.name)}
        }
    }
}
