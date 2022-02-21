//
//  Settings.swift
//  Interval Timer | HIIT
//
//  Created by Kunli Zhang on 20/02/22.
//

import Foundation

struct Settings: Codable {
    enum BeepLength: Codable {
        case threeSec
        case fiveSec
    }
    var beepLength: BeepLength
    
    init(beepLength: BeepLength = .threeSec) {
        self.beepLength = beepLength
    }
}
