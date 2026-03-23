//
//  ViewModel.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import Foundation
import Combine


enum ProductListState{
    case loading
    case loaded([Product])
    case apiError(Error)
    case empty
}


final class ProductViewModel: ObservableObject {
    
    @Published var viewState: ProductListState = .loading

    let networkManager:Networking
    var cancellable = Set<AnyCancellable>()
        
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func fetchProducts(){
        viewState = .loading
        networkManager.fetchDataFromAPI(urlString: Constant.API_URL, modelType: [Product].self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    print("All tasks are done")
                case .failure(let error):
                    print("ERRROR")
                    print(error)

                    self?.viewState = .apiError(error)
                }
            } receiveValue: { [weak self] products in
                print(products)
                self?.viewState = .loaded(products)
            }.store(in: &cancellable)
    }
    
}
