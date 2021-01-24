//
//  PathVsShapeView.swift
//  Drawing
//
//  Created by Felix Leitenberger on 23.01.21.
//

import SwiftUI

struct PathVsShapeView: View {
    var body: some View {
        VStack {
        Text("Shapes automatically take all available space. This is a shape with a frame: ")
            .padding()
            Spacer()
        Triangle()
            .fill(Color.red)
                .frame(width: 200, height: 200)
            Spacer()
            Text("This is an arc. The startAngle is corrected to be 'South'. Then the angle is 110° clockwise. ")
            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
        }
        
        .navigationTitle("Path vs Shapes")
        }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}

struct PathVsShapeView_Previews: PreviewProvider {
    static var previews: some View {
        PathVsShapeView()
    }
}
