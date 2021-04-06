//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Felix Leitenberger on 04.04.21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {

    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortAlert = false

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        if filter == .none {
                            Spacer()
                            Image(systemName: prospect.isContacted ? "checkmark.circle" : "questionmark.diamond")
                        }
                    }
                    .actionSheet(isPresented: $isShowingSortAlert) {
                        ActionSheet(title: Text("Sort"), message: Text("Select a sorting-method:"), buttons: [
                            .default(Text("by name")) { prospects.sort(by: .name) },
                            .default(Text("by adding-date")) { prospects.sort(by: .addedAt) },
                                .cancel()
                            ])
                    }

                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            
            .navigationBarTitle(title)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.isShowingSortAlert = true
                                    }, label: {
                                        Image(systemName: "arrow.up.arrow.down")
                                        Text("Sort")
                                    })

                                ,trailing: Button(action: {
                                    self.isShowingScanner = true
                                }) {
                                    Image(systemName: "qrcode.viewfinder")
                                    Text("Scan")
                                })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }

        }
    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed, \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none).environmentObject(Prospects())
    }
}
