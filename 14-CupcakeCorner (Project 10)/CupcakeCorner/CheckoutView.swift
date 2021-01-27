//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Felix Leitenberger on 27.01.21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingConnectionError = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.order.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showingConfirmation, content: {
                print("Alerto")
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            })
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        
        
        
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Enter data tastk")
            guard error == nil else {
                showingConnectionError = true
                print("Error case")
                return
            }
            print("Passed errror")
            
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            print("Passed data")
            
            if let decodedOrder = try? JSONDecoder().decode(OrderItem.self, from: data) {
                print("Decoding \(decodedOrder)")
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderItem.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order(order: OrderItem()))
    }
}
