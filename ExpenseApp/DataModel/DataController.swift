//
//  DataController.swift
//  ExpenseApp
//
//  Created by Wilfredo Batucan on 1/4/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ExpenseModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        }
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Data saved !!!")
        } catch {
            print("Failed to saved !!!")
        }
    }
    
    func addItem(name: String, date: Date, value: Double, context: NSManagedObjectContext){
        let item = Item(context: context)
        item.id = UUID()
        item.name = name
        item.date = date
        item.value = value
        
        print(value)
        save(context: context)
    }
    
    func editItem(item: Item, name: String, date: Date, value: Double, context: NSManagedObjectContext){
        item.name = name
        item.date = date
        item.value = value
        
        save(context: context)
    }
    
    func deleteFood(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Data deleted !!!")
        } catch {
            print("Failed to delete !!!")
        }
    }
}
