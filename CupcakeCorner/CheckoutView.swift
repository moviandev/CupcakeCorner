//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Matheus Viana on 01/03/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
