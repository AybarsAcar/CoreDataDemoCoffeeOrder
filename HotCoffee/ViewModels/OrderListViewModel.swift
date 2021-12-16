//
//  OrderListViewModel.swift
//  HotCoffee
//
//  Created by Aybars Acar on 16/12/21.
//

import Foundation
import CoreData
import SwiftUI
import Combine


class OrderListViewModel : ObservableObject {
 
  @Published var orders = [OrderViewModel]()
  
  init() {
    fetchAllOrders()
  }
  
  func fetchAllOrders() {
    orders = CoreDataManager.shared.getAllOrders().map(OrderViewModel.init)
  }
  
  func deleteOrder(_ orderViewModel: OrderViewModel) {
    CoreDataManager.shared.deleteOrderByName(orderViewModel.name)
    fetchAllOrders()
  }
}


class OrderViewModel {
  var name: String = ""
  var type: String = ""
  
  init(order: Order) {
    name = order.name!
    type = order.type!
  }
}
