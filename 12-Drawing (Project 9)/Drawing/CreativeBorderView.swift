//
//  CreativeBorderView.swift
//  Drawing
//
//  Created by Felix Leitenberger on 23.01.21.
//

import SwiftUI

struct CreativeBorderView: View {
    var body: some View {
        
        VStack {
            Text("Usable as border...")
                .frame(width: 300, height: 300)
                .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
        .navigationTitle("Creative Borders")
    }
}

struct CreativeBorderView_Previews: PreviewProvider {
    static var previews: some View {
        CreativeBorderView()
    }
}
