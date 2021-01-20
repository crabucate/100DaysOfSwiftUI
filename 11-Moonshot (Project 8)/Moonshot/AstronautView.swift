//
//  AstronautView.swift
//  Moonshot
//
//  Created by Felix Leitenberger on 19.01.21.
//

import SwiftUI

struct AstronautView: View {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: Astronaut
    
    var missionsOfAstronaut: [Mission] {
        var missionsOfAstronaut = [Mission]()
        for mission in missions {
            if let _ = mission.crew.first(where:{ $0.name == astronaut.id }) {
                missionsOfAstronaut.append(mission)
            }
        }
        return missionsOfAstronaut
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                    
                    
                    ForEach(missionsOfAstronaut) { mission in
                        HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                            }
                    }
                    
                    }
                    .padding(.leading)
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

        static var previews: some View {
            AstronautView(astronaut: astronauts[0])
        }
}
