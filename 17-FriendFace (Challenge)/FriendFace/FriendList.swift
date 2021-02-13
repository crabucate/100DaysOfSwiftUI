//
//  ContentView.swift
//  FriendFace
//
//  Created by Felix Leitenberger on 09.02.21.
//

import SwiftUI

struct FriendList: View {
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink(
                        destination: FriendDetail(users: $users, user: user),
                        label: {
                            FriendCell(user: user)
                        })
                }
            }   .navigationTitle("FriendFace")
            .onAppear(perform: getUsers)
        }
    }
    
    func getUsers() {
        NetworkManager.shared.getUsers { result in
            switch result {
            case .success(let users):
                self.users = users
                
            case .failure:
                print("Network Request failed for unknown reason. Error handling not implemented.")
            }
            
        }
    }
}


struct FriendCell: View {
    
    var user: User
    var body: some View {
        VStack(alignment: .leading) {
        
            Label(user.name, systemImage: "person.crop.circle")
                .font(.title)
                .foregroundColor(user.isActive ? .green : .red)
            
            Spacer()
           
            Label(user.company, systemImage: "building.columns")
                .font(.body)
                .foregroundColor(.secondary)
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FriendList()
    }
}
