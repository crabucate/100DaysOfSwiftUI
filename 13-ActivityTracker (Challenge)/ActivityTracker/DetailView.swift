//
//  DetailView.swift
//  ActivityTracker
//
//  Created by Felix Leitenberger on 25.01.21.
//

import SwiftUI

struct DetailView: View {
    
    var index: Int
    @ObservedObject var activities: Activities
    
    var body: some View {
        NavigationView {
            VStack {
            Text(activities.items[index].description)
                Spacer()
                
                Text("\(activities.items[index].amount)")
                    .font(.largeTitle)
                Spacer()
            Button {
                activities.items[index].amount += 1
            } label: {
                Text("+1")
            }
        }
        }.navigationTitle(activities.items[index].title)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 0, activities: Activities())
    }
}
