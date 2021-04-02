//
//  DetailView.swift
//  Met someone
//
//  Created by Felix Leitenberger on 01.04.21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var personStore: PersonStore
    var person: Person

    var body: some View {
        NavigationView {
                VStack {
                    Image(uiImage: personStore.loadImage(with: person.imageUUID))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(person.name)
                        .font(.title)
                        .bold()
                }
            .navigationTitle("Details of \(person.name)")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(personStore: PersonStore(), person: Person(id: UUID(), name: "Hans", imageUUID: nil))
    }
}
