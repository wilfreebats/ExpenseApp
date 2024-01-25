//
//  ExpenseAppApp.swift
//  ExpenseApp
//
//  Created by Wilfredo Batucan on 1/1/24.
//

import SwiftUI

@main
struct ExpenseApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
