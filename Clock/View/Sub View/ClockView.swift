//
//  ClockView.swift
//  Clock
//
//  Created by Ronjie Diafante Man-on on 5/19/25.
//

import SwiftUI

struct ClockView: View {
    let date: Date
    let centerPointRadius: CGFloat = 3.0
    let circleInset = 10.0
    
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
            let radius = min(size.width, size.height) / 2 - circleInset
            
            let circleRect = CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: 2 * radius,
                height: 2 * radius
            )
            
            let circlePath = Path(ellipseIn: circleRect)
            context
                .stroke(circlePath, with: .color(.gray), lineWidth: 3)
            
            func hand(at angle: Angle, length: CGFloat, color: Color) {
                var path = Path()
                
                path.move(to: center)
                let end = toPolar(
                    center: center,
                    angle: angle.radians,
                    radius: length
                )
                
                path.addLine(to: end)
                context
                    .stroke(path, with: .color(color), lineWidth: 2)
            }
            
            hand(at: hoursAngle, length: size.width * 0.25, color: .primary)
            hand(at: minutesAngle, length: size.width * 0.35, color: .primary)
            hand(at: secondsAngle, length: size.width * 0.4, color: .red)
            
            for hour in 1...12 {
                let angle = Angle.degrees(Double(hour) / 12 * 360 - 90)
                let text = Text("\(hour)")
                    .font(.system(size: 12).bold())
                let textSize = context
                    .resolve(text)
                    .measure(in: CGSize(width: 100, height: 100))
                let textRadius = radius * 0.8
                
                let textXY = toPolar(
                    center: center,
                    angle: angle.radians,
                    radius: textRadius,
                    translation: CGPoint(
                        x: -textSize.width / 2,
                        y: -textSize.height / 2
                    )
                )
                
                
                context
                    .draw(
                        text,
                        at: CGPoint(
                            x: textXY.x + textSize.width / 2,
                            y: textXY.y + textSize.height / 2
                        )
                    )
            }
            
            let centerCircle = Path(
                ellipseIn: CGRect(
                    x: center.x - centerPointRadius,
                    y: center.y - centerPointRadius,
                    width: 2 * centerPointRadius,
                    height: 2 * centerPointRadius
                )
            )
            
            context
                .fill(centerCircle, with: .color(.black))
            
            for i in 0..<60 {
                let angle = Angle.degrees(Double(i) / 60 * 360 - 90)
                let isHourTick = i.isMultiple(of: 5)
                let tickLength: CGFloat =  isHourTick ? 10 : 4
                let lineWidth: CGFloat = isHourTick ? 2 : 1
                
                let outer = toPolar(
                    center: center,
                    angle: angle.radians,
                    radius: radius
                )
                
                let inner = toPolar(
                    center: center,
                    angle: angle.radians,
                    radius: radius - tickLength
                )
                
                var path = Path()
                
                path
                    .move(to: outer)
                
                path
                    .addLine(to: inner)
                
                context
                    .stroke(path, with: .color(.gray ), lineWidth: lineWidth)
            }
        }
    }
    
    func toPolar(
        center: CGPoint,
        angle: CGFloat,
        radius: CGFloat,
        translation: CGPoint = .zero
    ) -> CGPoint {
        CGPoint(
            x: center.x + cos(Double(angle)) * radius + translation.x,
            y: center.y + sin(Double(angle)) * radius + translation.y
        )
    }
}

#Preview {
    ClockView(date: .now)
}
