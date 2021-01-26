//
//  AddView.swift
//  ActivityTracker
//
//  Created by Felix Leitenberger on 25.01.21.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activities: Activities
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Button {
                    let newItem = Activity(title: title, description: description)
                    activities.items.append(newItem)
                    dpresentationMode.wrappedValue.dismiss()
                    
                } label: {
                    ZStack {
                        HStack {
                            Image(systemName: "plus.square.fill")
                                .imageScale(.large)
                            Text("Add item")
                        }
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 44)
                            .foregroundColor(.clear)
                    }
                }
            }.navigationTitle("Add a new Activity...")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
