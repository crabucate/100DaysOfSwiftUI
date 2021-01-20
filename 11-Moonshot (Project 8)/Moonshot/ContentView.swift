//
//  ContentView.swift
//  Moonshot
//
//  Created by Felix Leitenberger on 18.01.21.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isShowingCrewName = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if isShowingCrewName {
                            Text(mission.crewNames)
                        } else {
                        
                        Text(mission.formattedLaunchDate)
                        }
                        }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button("Toggle") {
                isShowingCrewName.toggle()
                print("Toggling")
                
            })
        }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
