//
//  ContentView.swift
//  Met someone
//
//  Created by Felix Leitenberger on 27.03.21.
//

import SwiftUI

struct ListView: View {

    @StateObject var personStore = PersonStore()
    @State var showEdit = false

    var body: some View {
        NavigationView {
            Group {
                if personStore.persons.isEmpty {
                    EmptyList()
                } else {
                    List {
                        ForEach(personStore.persons) { person in
                            NavigationLink(destination: DetailView(personStore: personStore, person: person)) {
                                ListItem(personStore: personStore, person: person)
                            }

                        }.onDelete(perform: removeItems)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { showEdit = true } label: { Label("Add", systemImage: "plus") }
                }
                ToolbarItem(placement: .cancellationAction) {
                    EditButton()
                }
            }
            .navigationTitle("Met someone")
        }
        .sheet(isPresented: $showEdit, content: {
            AddView(personStore: personStore, isPresented: $showEdit)
        })
    }

    func removeItems(at offsets: IndexSet) {
        personStore.persons.remove(atOffsets: offsets)
    }
}

struct ListItem: View {

    @ObservedObject var personStore: PersonStore
    var person: Person

    var body: some View {
        HStack {
            Image(uiImage: personStore.loadImage(with: person.imageUUID))
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
            Text(person.name)
        }
    }
}

struct EmptyList: View {
    var body: some View {
        VStack {
            Image(systemName: "bookmark.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(.secondary)
                .padding(20)
            Text("Nothing to see here. Add a person.")
                .font(.title2)
                .foregroundColor(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
