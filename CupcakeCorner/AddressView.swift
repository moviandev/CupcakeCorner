//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Matheus Viana on 01/03/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderData.name)
                TextField("Street Name", text: $order.orderData.streetAddress)
                TextField("City", text: $order.orderData.city)
                TextField("Zip", text: $order.orderData.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.orderData.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        AddressView(order: order)
    }
}
