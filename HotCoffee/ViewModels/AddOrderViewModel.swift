//
//  AddOrderViewModel.swift
//  HotCoffee
//
//  Created by Aybars Acar on 16/12/21.
//

import Foundation


///
/// Add order screen view model
///
class AddOrderViewModel : ObservableObject {
  
  @Published var name: String = ""
  @Published var type: String = ""
  
  
  func saveOrder() {
    CoreDataManager.shared.saveOrder(name: self.name, type: self.type)
  }
}
