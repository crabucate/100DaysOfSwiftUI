//
//  ContentView.swift
//  Moonshot
//
//  Created by Felix Leitenberger on 18.01.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
                VStack {
                    GeometryReader { geo in
                            Image("Example")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width)
                                .onAppear(perform: {
                                    print(geo)
                                })
                        
                    
                    }
                    ScrollView(.vertical) {
                        VStack(spacing: 10) {
                            ForEach(0..<100) {
                                Text("Item \($0)")
                                    .font(.title)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
