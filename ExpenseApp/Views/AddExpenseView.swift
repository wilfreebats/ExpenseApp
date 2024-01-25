//
//  AddExpense.swift
//  ExpenseApp
//
//  Created by Wilfredo Batucan on 1/4/24.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var expense: String = ""
    @State private var date: Date = .now
    @State private var val: Double = 0
    @State private var isShowAlert = false
    
    @ObservedObject var input = NumbersOnly()
    
    
    var body: some View {
        NavigationStack {
            Form(content: {
                Section {
                    TextField("Item", text: $expense)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Price", value: $val, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Create expense")
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button {
                            if expense.isEmpty {
                                isShowAlert = true
                            } else {
                                DataController().addItem(
                                    name: expense, date: date, value: val, context: managedObjContext)
                                dismiss()
                            }
                        } label: {
                            Text("Submit")
                                
                        }
                        .disabled(expense.isEmpty)
                        Spacer()
                            
                    }

                }
                
                .alert(isPresented: $isShowAlert, content: {
                    Alert(title: Text("Required Field"),
                          message: Text("You must enter a item"),
                          dismissButton: .default(Text("OK"))
                    )
                })
            })
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.borderless)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        if expense.isEmpty {
                            isShowAlert = true
                        } else {
                            DataController().addItem(
                                name: expense, date: date, value: val, context: managedObjContext)
                            dismiss()
                        }
                    }
                    .disabled(expense.isEmpty)
                }
            }
            
            
        }
        
    }
}

#Preview {
    AddExpenseView()
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
