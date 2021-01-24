//
//  ContentView.swift
//  Drawing
//
//  Created by Felix Leitenberger on 22.01.21.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("This app is following along Paul Hudsons (@twostraws) Tutorial on Drawing in SwiftUI.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .navigationTitle("Drawing")
                    .padding(.leading)
                List {
                    Section(header: Text("Tutorial")) {
                        NavigationLink("Path", destination: PathView())
                        NavigationLink("Path vs Shape", destination: PathVsShapeView())
                        NavigationLink("Insettable Shape", destination: InsettableShapeView())
                        NavigationLink("Transforming Shapes", destination: TransformingShapesView())
                        NavigationLink("Creative Borders", destination: CreativeBorderView())
                        NavigationLink("Metal Rendering", destination: MetalRenderingView())
                        NavigationLink("Blur and Blending", destination: BlurAndBlendingView())
                        NavigationLink("Animatable Data", destination: AnimatableDataView())
                        NavigationLink("Animatable Pair", destination: AnimatablePairView())
                        NavigationLink("Spirograph", destination: SpirographView())
                    }
                    Section(header: Text("Challenges")) {
                        NavigationLink("Arrow Shape", destination: ArrowShapeView())
                        NavigationLink("Color Cycling Rectangle", destination: ColorCyclingRectangleView())
                    }
                    }
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
