//
//  ProductCell.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import SwiftUI

struct ProductCell: View {
    let product : Product
        
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: product.image)){ image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
            } placeholder : {
                ProgressView()
                    .frame(width: 100, height:100)
            }
            VStack(alignment: .leading){
                Text("\(product.title)")
                    .font(.title)
                    .foregroundStyle(.cyan)
            }
        }
    }
}
