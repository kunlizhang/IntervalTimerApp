//
//  Exercise.swift
//  Interval Timer | HIIT
//
//  Created by Kunli Zhang on 26/07/22.
//

import Foundation

struct Exercises: Identifiable, Codable {
    var id: UUID
    var list: [String]
    
    init(id: UUID = UUID(), list: [String]) {
        self.id = id
        self.list = list
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
