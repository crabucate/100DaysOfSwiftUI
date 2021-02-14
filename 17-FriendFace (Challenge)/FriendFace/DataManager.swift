//
//  NetworkManager.swift
//  FriendFace
//
//  Created by Felix Leitenberger on 10.02.21.
//

import CoreData

class DataManager {
    static let shared = DataManager()
    
    let context = PersistenceController.shared.container.viewContext
    let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
    
    private init() {
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
    
    func getUsers(completed: @escaping (Result<[User], Error>) -> Void) {
        
        if let result = try? context.fetch(fetchRequest) {

        if result.isEmpty {
            print("Empty, let's get some data from the internet and save it to CoreData.")

            if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") {

                let request = URLRequest(url: url)

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {

                        DispatchQueue.main.async {
                            let oneAndOnlyUserData = CDUser(context: self.context)
                            oneAndOnlyUserData.usersData = data
                            
                            if self.context.hasChanges {
                                try? self.context.save()
                        }
                        

                        }
                        if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                            completed(.success(decodedUsers))
                        }
                    }
                }.resume()
            }
        } else {
            print("Already data there. Let's fetch.")
            
            if let decodedUsers = try? JSONDecoder().decode([User].self, from: result.first!.usersData!) {
                completed(.success(decodedUsers))
            }
            
        }
        }

        
    }
}
