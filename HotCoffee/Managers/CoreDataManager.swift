//
//  CoreDataManager.swift
//  HotCoffee
//
//  Created by Aybars Acar on 15/12/21.
//

import Foundation
import CoreData


///
/// To manage core data
///
class CoreDataManager {
  
  static let shared = CoreDataManager()
  
  // responsible for initialising the core data stack
  let persistentContainer: NSPersistentContainer
  
  init() {
    persistentContainer = NSPersistentContainer(name: "HotCoffee")
    persistentContainer.loadPersistentStores { (description, error) in
      
      if let error = error {
        fatalError("Core Data Store failed \(error.localizedDescription)")
      }
    }
  }
  
  
  func saveOrder(name: String, type: String) {
    
    let order = Order(context: persistentContainer.viewContext)
    
    order.name = name
    order.type = type
    
    do {
      try persistentContainer.viewContext.save()
    } catch {
      print("Failed to save teh order: \(error)")
    }
    
  }
  
  
  func getAllOrders() -> [Order] {
    
    let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
    
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  
  func getOrder(name: String) -> Order? {
    let request: NSFetchRequest<Order> = Order.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    
    var orders: [Order] = []
    
    do {
      orders = try persistentContainer.viewContext.fetch(request)
    } catch {
      print(error)
    }
    
    return orders.first
  }
  
  
  func deleteOrder(order: Order) {
    persistentContainer.viewContext.delete(order) // this marks it as deletion
    
    // we need to save the changes to actually delete it
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback() // if throws roll back the changes
      print("Unable to delete the order \(error)")
    }
  }
  
  
  func deleteOrderByName(_ name: String) {
    
    do {
      
      if let order = getOrder(name: name) {
        persistentContainer.viewContext.delete(order)
        
        try persistentContainer.viewContext.save()        
      }
      
    } catch {
     print(error)
   }
    
  }
  
}

