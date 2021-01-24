//
//  InsettableShapeView.swift
//  Drawing
//
//  Created by Felix Leitenberger on 23.01.21.
//

import SwiftUI

struct InsettableShapeView: View {
    var body: some View {
        VStack {
            Text("This circle uses a strokeBorder, which is insettable:")
                .padding()
            Circle()
                .strokeBorder(Color.blue, lineWidth: 40)
            
            Text("This arc was made insettable:")
            
            Spacer()
            
            ArcSecond(startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: true)
                .strokeBorder(Color.blue, lineWidth: 40)
                .frame(width: 200, height: 200, alignment: .center)
                .border(Color.black, width: 1)
        }
        .navigationTitle("Insettable Shapes")
    }
}


struct ArcSecond: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct InsettableShapeView_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShapeView()
    }
}
