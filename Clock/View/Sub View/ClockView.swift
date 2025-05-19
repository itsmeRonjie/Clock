//
//  ClockView.swift
//  Clock
//
//  Created by Ronjie Diafante Man-on on 5/19/25.
//

import SwiftUI

struct ClockView: View {
    let date: Date
    let circleRadius: CGFloat = 3.0

    var body: some View {
        Canvas {
            context,
            size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let calendar = Calendar.current
            
            let seconds = calendar.component(.second, from: date)
            let minutes = calendar.component(.minute, from: date)
            let hours = calendar.component(.hour, from: date) % 12
            
            func angle(for value: Int, unit: Int) -> Angle{
                .degrees(Double(value) / Double(unit) * 360 - 90)
            }
            
            let secondsAngle = angle(for: seconds, unit: 60)
            let minutesAngle = angle(for: minutes, unit: 60 )
            let hoursAngle = angle(for: hours * 5 + minutes / 12, unit: 60)
            
            func hand(at angle: Angle, length: CGFloat, color: Color) {
                var path = Path()
                let angleRadians: Double = angle.radians
                
                path.move(to: center)
                let end = CGPoint(
                    x: center.x + cos(Double(angleRadians)) * length,
                    y: center.y + sin(angleRadians) * length
                )
                
                path.addLine(to: end)
                context
                    .stroke(path, with: .color(color), lineWidth: 2)
            }
            
            hand(at: hoursAngle, length: size.width * 0.25, color: .primary)
            hand(at: minutesAngle, length: size.width * 0.35, color: .primary)
            hand(at: secondsAngle, length: size.width * 0.4, color: .red)

            let centerCircle = Path(
                ellipseIn: CGRect(
                    x: center.x - circleRadius,
                    y: center.y - circleRadius,
                    width: 2 * circleRadius,
                    height: 2 * circleRadius
                )
            )
            
            context
                .fill(centerCircle, with: .color(.black))
        }
    }
}

#Preview {
    ClockView(date: .now)
}
