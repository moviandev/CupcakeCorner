//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Matheus Viana on 01/03/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderData.type) {
                        ForEach(OrderData.types.indices, id: \.self) {
                            Text(OrderData.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.orderData.quantity)", value: $order.orderData.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.orderData.specialRequestEnabled.animation())
                    
                    if order.orderData.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderData.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.orderData.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
