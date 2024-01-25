//
//  EditExpenseView.swift
//  ExpenseApp
//
//  Created by Wilfredo Batucan on 1/4/24.
//

import SwiftUI

struct EditExpenseView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    var item: FetchedResults<Item>.Element
    
    @State private var expense: String = ""
    @State private var date: Date = .now
    @State private var val: Double = 0
    @State private var isShowAlert = false
    
    var body: some View {
//        HStack {
//            VStack(alignment: .leading, content: {
//                Text("Update item")
//                    .font(.title.bold())
//            })
//            Spacer()
//        }
//        .padding(20)
        NavigationStack {
            Form {
                Section() {
                    TextField("Item", text: $expense)
                        .onAppear(perform: {
                            expense = item.name!
                            date = item.date!
                            val = item.value
                        })
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Value", value: $val, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                          
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Update") {
                            if expense.isEmpty {
                                isShowAlert = true
                            } else {
                              DataController().editItem(item: item, name: expense, date: date, value: val, context: managedObjContext)
                                dismiss()
                            }
                        }
                        .disabled(expense.isEmpty)

                        
                        Spacer()
                    }
                }
                
                .alert(isPresented: $isShowAlert, content: {
                    Alert(title: Text("Required Field"),
                          message: Text("Item must not be emptied !!!"),
                          dismissButton: .default(Text("OK"))
                    )
                })
            }
        }
        .navigationTitle("Update item")
        .navigationBarTitleDisplayMode(.large)
  
    }
}

//#Preview {
//    EditExpenseView()
//}
