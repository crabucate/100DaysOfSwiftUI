//
//  ContentView.swift
//  iExpenses
//
//  Created by Felix Leitenberger on 17.01.21.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text("$\(item.amount)")
                                .foregroundColor(item.amount <= 10 ? .green : item.amount <= 100 && item.amount > 10 ? .yellow : .red)
                        }
                } .onDelete(perform: removeItems)
            } .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            } .navigationBarTitle(Text("iExpense"))
            .navigationBarItems(leading: EditButton(),
                                trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.title)
                                    })
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
