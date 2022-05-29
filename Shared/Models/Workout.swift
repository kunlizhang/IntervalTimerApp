//
//  Workout.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 20/01/22.
//

import Foundation

struct Workout: Identifiable, Codable {
    let id: UUID
    var title: String
    var exercises: [Exercise]
    var workTime: Int
    var restTime: Int
    var sets: Int
    var restBetweenSets: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, exercises: [String], workTime: Int, restTime: Int, sets: Int, restBetweenSets: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.exercises = exercises.map { Exercise(name: $0) }
        self.workTime = workTime
        self.restTime = restTime
        self.sets = sets
        self.restBetweenSets = restBetweenSets
        self.theme = theme
    }
    
    public var lengthString: String {
        let timeInSeconds = ((self.workTime * self.exercises.count + self.restTime * (self.exercises.count - 1)) * (self.sets) + self.restBetweenSets * (self.sets - 1))
        var seconds: String
        if timeInSeconds % 60 < 10 {
            seconds = "0\(timeInSeconds % 60)"
        } else {
            seconds = "\(timeInSeconds % 60)"
        }
        return "\(timeInSeconds/60):" + seconds
    }
}

extension Workout {
    struct Exercise: Identifiable, Codable{
        var id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var exercises: [Exercise] = []
        var workTime: Double = 30
        var restTime: Double = 30
        var sets: Double = 1
        var restBetweenSets: Double = 60
        var theme: Theme = Theme.allCases.randomElement()!
        
    }
    
    var data: Data {
        Data(title: title, exercises: exercises, workTime: Double(workTime), restTime: Double(restTime), sets: Double(sets), restBetweenSets: Double(restBetweenSets), theme: theme)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        exercises = data.exercises
        workTime = Int(data.workTime)
        restTime = Int(data.restTime)
        sets = Int(data.sets)
        restBetweenSets = Int(data.restBetweenSets)
        theme = data.theme
    }
    
    init(data: Data) {
        self.id = UUID()
        self.title = data.title
        self.exercises = data.exercises
        self.workTime = Int(data.workTime)
        self.restTime = Int(data.restTime)
        self.sets = Int(data.sets)
        self.restBetweenSets = Int(data.restBetweenSets)
        self.theme = Theme.allCases.randomElement()!
    }
}

extension Workout {
    static let sampleData: [Workout] = [
        Workout(title: "Core", exercises: ["Situps", "Pushups", "Plank"], workTime: 45, restTime: 15, sets: 2, restBetweenSets: 60, theme: .bubblegum),
        Workout(title: "Arms", exercises: ["Pullups", "Lateral raises"], workTime: 50, restTime: 15, sets: 3, restBetweenSets: 30, theme: .seafoam),
        Workout(title: "Cardio", exercises: ["Burpbees", "Starjumps", "Squats"], workTime: 50, restTime: 10, sets: 5, restBetweenSets: 10, theme: .yellow),
        Workout(title: "Tester", exercises: ["Hello", "World"], workTime: 5, restTime: 2, sets: 3, restBetweenSets: 4, theme: .lavender)
    ]
}
