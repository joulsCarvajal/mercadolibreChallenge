//
//  ProductDetailTwo.swift
//  mercadolibreChallenge
//
//  Created by Julian Carvajal on 5/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetail: View {
    let product: ApiNetWork.Product
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
                    WebImage(url: URL(string: product.thumbnail))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .cornerRadius(16)
                    
                    Text(product.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Tienda: \(product.domainId)")
                        .font(.subheadline)
                    
                    Text("Precio: $\(String(format: "%.2f", product.price))")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding()
                .navigationTitle("Detalle del Producto")
    }
}

//#Preview {
//    ProductDetailTwo()
//}
