//
//  ProductsMVVMApp.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import SwiftUI
import CoreData

@main
struct ProductsMVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ProductsListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
