//
//  ProductDetails.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import SwiftUI

struct ProductDetails: View {
    
    let product : Product
    
    var body: some View {
        
        VStack(alignment: .center){
            
            
            Text("\(product.title)")
                .font(.title)
            AsyncImage(url: URL(string: product.image)){ image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
            } placeholder : {
                ProgressView()
                    .frame(width: 100, height:100)
            }
            
            Text("Price: $\(String(format: "%.2f", product.price))")
                .font(.subheadline)
            
            Text("Rating: \(String(format: "%.2f", product.rating.rate)) / Reviews: \(product.rating.count)")

            
            VStack(alignment: .leading){
                
                Text("Product id: \(product.id)")
                    .font(.caption)
               
                Text("Description: \n\(product.description)")
                    .font(.body)
                Text("Category: \(product.category)")
                    .font(Font.body.bold())
            }
        }
        
    }
}
