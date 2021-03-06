//
//  ArrowShapeView.swift
//  Drawing
//
//  Created by Felix Leitenberger on 24.01.21.
//

import SwiftUI

struct ArrowShapeView: View {
    
    @State private var lineWidth: CGFloat = 10
    
    var body: some View {
        Arrow()
            .stroke(Color.red, lineWidth: lineWidth)
            .navigationTitle("Arrow Shape")
            .onTapGesture {
                withAnimation {
                    lineWidth += 10
                }
            }
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            path.addLines( [
                CGPoint(x: width * 0.4, y: height),
                CGPoint(x: width * 0.4, y: height * 0.4),
                CGPoint(x: width * 0.2, y: height * 0.4),
                CGPoint(x: width * 0.5, y: height * 0.1),
                CGPoint(x: width * 0.8, y: height * 0.4),
                CGPoint(x: width * 0.6, y: height * 0.4),
                CGPoint(x: width * 0.6, y: height)
            ])
            
            path.closeSubpath()
        }
    }
}

struct ArrowShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowShapeView()
    }
}
