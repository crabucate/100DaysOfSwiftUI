//
//  1Path.swift
//  Drawing
//
//  Created by Felix Leitenberger on 23.01.21.
//

import SwiftUI

struct PathView: View {
    var body: some View {
        ZStack {
        Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
            }
        .fill(Color.blue)
        
            NavigationLink("Path with a stroke", destination: StrokeModifier())
        }
        .navigationTitle("Path with a fill")
    }
}


struct StrokeModifier: View {
    var body: some View {
        Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
            }
        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
        .navigationTitle("Path with a stroke")
    }
}

struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        PathView()
    }
}
