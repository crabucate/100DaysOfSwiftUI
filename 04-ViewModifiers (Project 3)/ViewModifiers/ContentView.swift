//
//  ContentView.swift
//  ViewModifiers
//
//  Created by Felix Leitenberger on 02.01.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("View Modifier!")
                    .niceTitleStyle()
                
                NavigationLink(
                    destination: GridView(),
                    label: {
                        Text("Let's create a grid.\n A custom container")
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                    })
        }
    }
}
}

struct NiceTitleWith: ViewModifier {
    
    let caption: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .font(.system(size: 80, weight: .black, design: .monospaced))
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
            Text(caption)
                .font(.caption)
                .italic()
        }
        .padding(40)
    }
}


extension View {
    func niceTitleStyle() -> some View {
        self.modifier(NiceTitleWith(caption: "Styled by a custom ViewModifier.\n Even this caption."))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
