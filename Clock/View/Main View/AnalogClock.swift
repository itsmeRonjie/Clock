//
//  AnalogClock.swift
//  Clock
//
//  Created by Ronjie Diafante Man-on on 5/19/25.
//

import SwiftUI

struct AnalogClock: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let date = timeline.date
            
            ClockView(date: date)
        }
    }
}

#Preview {
    AnalogClock()
}
