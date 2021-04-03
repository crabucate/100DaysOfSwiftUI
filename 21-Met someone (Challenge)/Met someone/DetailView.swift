//
//  DetailView.swift
//  Met someone
//
//  Created by Felix Leitenberger on 01.04.21.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @ObservedObject var personStore: PersonStore
    var person: Person
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        NavigationView {
                VStack {
                    Image(uiImage: personStore.loadImage(with: person.imageUUID))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(person.name)
                        .font(.title)
                        .bold()
                    Map(coordinateRegion: $region, interactionModes: [], showsUserLocation: false, userTrackingMode: .none)
                    
                }
                .navigationTitle("Details of \(person.name)")
                .onAppear(perform: {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude ?? 51, longitude: person.longitude ?? -0.1), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    print(person)

        })
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(personStore: PersonStore(), person: Person(id: UUID(), name: "Hans", imageUUID: nil, latitude: 10, longitude: 10))
    }
}
