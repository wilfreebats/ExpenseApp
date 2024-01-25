//
//  TestView.swift
//  ExpenseApp
//
//  Created by Wilfredo Batucan on 1/4/24.
//

import SwiftUI

struct ExpenseHomeView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    var item: FetchedResults<Item>
    
    @State private var showingAddExpense = false
    @State private var searchText = ""
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            item.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "name CONTAINS [cd]%@", newValue)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(item) { item in
                    NavigationLink(destination: EditExpenseView(item: item)) {
                        HStack {
                            Text(item.date!, format: .dateTime.month(.abbreviated).day())
                            Spacer()
                            Text(item.name!)
                            Spacer()
                            Text(item.value, format: .currency(code: "USD"))
                            
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Expense")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: query, prompt: "Search")
            .overlay {
                if item.isEmpty && searchText.isEmpty {
                    VStack {
                        Label("", systemImage: "list.bullet.clipboard.fill")
                            .font(.system(size: 45))
                            .padding()
                        Text("No items on the list")
                            .font(.system(size: 25))
                            .bold()
                            .padding()
                        Button("Add item") {
                            showingAddExpense.toggle()
                        }
                    }
                    
//                    #for iOS 17
//                    ContentUnavailableView(label: {
//                        Label("No Food", systemImage: "list.bullet.rectangle.portrait")
//                    }, description: {
//                        Text("Start adding food")
//                    })
                    
                }

                
            }
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddExpense.toggle()
                    } label: {
                        if (!item.isEmpty) {
                            Label("Add Food", systemImage: "plus.circle")
                        }
                    }
                }
                
                if (!item.isEmpty) {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddExpenseView()
                    .presentationDetents([.medium])
            })
        }
        .navigationViewStyle(.stack)
    }
    func deleteItem(offset: IndexSet) {
        withAnimation {
            offset.map { item[$0] }.forEach(managedObjContext.delete)
            DataController().deleteFood(context: managedObjContext)
        }
    }
}

#Preview {
    ExpenseHomeView()
}
