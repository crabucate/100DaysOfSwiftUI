//
//  FriendDetail.swift
//  FriendFace
//
//  Created by Felix Leitenberger on 12.02.21.
//

import SwiftUI

struct FriendDetail: View {
    
    @Binding var users: [User]
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(user.isActive ? .green : .red)
                        .frame(width: 100, height: 30)
                    Text(user.isActive ? "active" : "not active")
                        .padding()
                    
                }.padding(.leading)
                
                List {
                    Group {
                    Section(header: Text("Age")) {
                        Text(String(user.age))
                    }
                    
                    Section(header: Text("Company")) {
                        Text(user.company)
                    }
                    
                    Section(header: Text("Email")) {
                        Text(String(user.email))
                    }
                    
                    Section(header: Text("Address")) {
                        Text(user.address)
                    }
                    
                    Section(header: Text("About")) {
                        Text(user.about)
                    }
                    
                    Section(header: Text("Registered")) {
                        Text(user.registered)
                    }
                    
                    Section(header: Text("Tags")) {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                        }
                    }
                    
                    Section(header: Text("Friends")) {
                        
                        ForEach(user.friends, id: \.self) { friend in
                            if let index = users.firstIndex(where: { $0.name == friend.name }) {
                                NavigationLink(friend.name,
                                               destination: FriendDetail(users: $users, user: users[index]))
                            }
                        }
                    }
                }
                .listStyle(InsetListStyle())
            }
        .navigationTitle(user.name)
        
        
    }
}
}

struct FriendDetail_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetail(users: .constant([User]()), user: User(id: "DummyID", isActive: true, name: "Dummy Name", age: 21, company: "Rainbow Company", email: "xxx@gmx.net", address: "Schwanseestr. 8", about: "Meet me at the bar.", registered: "2010-09", tags: ["Power Rangers", "Snoopy"], friends: [User.Friend(id: "", name: "")]))
    }
}
