//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Matheus Viana on 01/03/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var alertMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                
                Text("Your total is \(order.orderData.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                       await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertMessage, isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message:  {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.orderData) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderData.self, from: data)
            
            alertMessage = "Thank you ❤️"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderData.types[decodedOrder.type].lowercased()) cupacakes is on the way!"
            
            showingConfirmation = true
             
        } catch {
            alertMessage = "Oops... Something is wrong"
            confirmationMessage = "Failed to order your cupcakes, please contact us +1 xxx xxxx-xxxx"
            
            showingConfirmation = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
