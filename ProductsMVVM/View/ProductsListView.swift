//
//  ProductsListView.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import SwiftUI

struct ProductsListView: View {
    
    @State var searchText = ""
    @AppStorage("isDarkMode") private var isDarkMode = false

    @StateObject var personViewModel = ProductViewModel(networkManager: NetworkManager())
    
    var filteredProducts: [Product] = []
    
    
    var body: some View {
        NavigationStack{
            
            VStack{
                Toggle("Dark Mode", isOn: $isDarkMode)
                .padding(10)
                
                TextField("Search product", text: $searchText)
                    .padding(10)
                    .onChange(of: searchText){ oldText, newText in
                        UserDefaults.standard.set(newText, forKey: "lastSearchedText")
                    }
                Text("Last searched: \(UserDefaults.standard.string(forKey: "lastSearchedText") ?? "Nothing") ")
            }
            
            VStack {
                switch personViewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded(let productsList):
                    
                    var filteredProducts: [Product] {
                        if searchText.isEmpty {
                            productsList
                        } else{
                            productsList.filter{
                                $0.title.contains(searchText)
                            }
                        }
                    }
                    
                    loadList(products: filteredProducts)

                    
                case .apiError(let error):
                    Text(error.localizedDescription)
                        .accessibilityIdentifier("person_list_error_text")
                case .empty:
                    EmptyView()
                }
            }
            .task(){
                personViewModel.fetchProducts()
            }
            .refreshable{
                personViewModel.fetchProducts()
            }.preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

@ViewBuilder
func loadList(products:[Product]) -> some View {
    
    @State var searchText = ""
    @State var isDarkMode = false
    
    
    List(products){ product in
        NavigationLink {
            ProductDetails(product: product)
        } label: {
            ProductCell(product: product)
                .accessibilityIdentifier("product_cell_\(product.id)")
        }
    }.accessibilityIdentifier("products_list")
}


#Preview {
    ProductsListView()
}
