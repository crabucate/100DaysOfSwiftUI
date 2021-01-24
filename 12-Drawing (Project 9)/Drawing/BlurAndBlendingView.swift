//
//  BlurAndBlending.swift
//  Drawing
//
//  Created by Felix Leitenberger on 23.01.21.
//

import SwiftUI

struct BlurAndBlendingView: View {
    
    @State private var amount: CGFloat = 0.0
    
    var body: some View {
        VStack {
            Image("crabucateLogo")
                .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .saturation(Double(amount))
                    .blur(radius: (1 - amount) * 20)
            
            VStack {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 200 * amount)
                                .offset(x: -50, y: -80)
                                .blendMode(.screen)

                            Circle()
                                .fill(Color.green)
                                .frame(width: 200 * amount)
                                .offset(x: 50, y: -80)
                                .blendMode(.screen)

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 200 * amount)
                                .blendMode(.screen)
                        }
                        .frame(width: 300, height: 300)

                        Slider(value: $amount)
                            .padding()
                    }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Blur and Blending")
                    
                }
        }
    


struct BlurAndBlending_Previews: PreviewProvider {
    static var previews: some View {
        BlurAndBlendingView()
    }
}
