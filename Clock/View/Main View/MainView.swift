//
//  ContentView.swift
//  Clock
//
//  Created by Ronjie Diafante Man-on on 5/19/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("SwiftUI Canvas and TimelineView")
                .font(.title2)
                .bold()
            Spacer()
            DigitalClock()
            AnalogClock()
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
