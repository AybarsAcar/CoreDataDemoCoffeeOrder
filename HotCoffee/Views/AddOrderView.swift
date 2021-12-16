//
//  AddOrderView.swift
//  HotCoffee
//
//  Created by Aybars Acar on 16/12/21.
//

import SwiftUI


struct AddOrderView: View {
  
  @ObservedObject var addOrderViewModel = AddOrderViewModel()
  
  @Binding var isDisplayed: Bool
  var callback: () -> Void
  
  var body: some View {
    
    NavigationView {
      VStack {
        TextField("Enter name", text: $addOrderViewModel.name)
          .padding()
        
        Picker(
          selection: $addOrderViewModel.type,
          content: {
            Text("Cappucino").tag("cap")
            Text("Regular").tag("reg")
            Text("Espresso").tag("esp")
          },
          label: {
            
          }
        )
          .pickerStyle(.segmented)
          .padding()
        
        Button(action: {
          addOrderViewModel.saveOrder()
          isDisplayed = false
          callback()
        }, label: {
          Text("Place Order")
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
        })
        .padding(8)
        .foregroundColor(.white)
        .background(Color.green)
        .cornerRadius(10)
        
      }
      .padding(.horizontal, 20)
      .navigationTitle("Add Order")
    }
    
  }
}



struct AddOrderView_Previews: PreviewProvider {
  static var previews: some View {
    AddOrderView(isDisplayed: .constant(true)) { }
  }
}
