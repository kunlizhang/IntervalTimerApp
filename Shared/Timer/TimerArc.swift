//
//  TimerArc.swift
//  IntervalTimer
//
//  Created by Kunli Zhang on 27/01/22.
//

import SwiftUI

struct TimerArc: Shape {
    let timeElapsed: Double
    let timeTotal: Double
    
    private var endAngle: Angle {
        Angle(degrees: 360.0 * timeElapsed / timeTotal)
    }
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: endAngle, clockwise: false)
        }
    }
}
