//
//  ContentView.swift
//  ExpenseApp
//
//  Created by Wilfredo Batucan on 1/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAddExpense = false
    
    var body: some View {
        ExpenseHomeView()
    }
}

#Preview {
    ContentView()
}
