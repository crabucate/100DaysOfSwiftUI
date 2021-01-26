//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Felix Leitenberger on 25.01.21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    
    @State private var addViewIsShowing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items.indices, id: \.self) { index in
                    NavigationLink(destination: DetailView(index: index, activities: self.activities), label: {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(activities.items[index].title)
                                .font(.headline)
                            Text(activities.items[index].description)
                        }
                        Spacer()
                        Text("\(activities.items[index].amount)")
                    }}
                        )
                    
                }
                .onDelete(perform: removeItems)
            }
            
            .sheet(isPresented: $addViewIsShowing) {
                AddView(activities: activities)
            }
            .navigationTitle("Activity Tracker")
            .navigationBarItems(trailing:
                                    Button {
                                        addViewIsShowing = true
                                    } label: {
                                        Image(systemName: "plus.square.fill")
                                            .imageScale(.large)
                                    })
            
        }
        
    }
    
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
