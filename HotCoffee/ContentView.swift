//
//  ContentView.swift
//  HotCoffee
//
//  Created by Aybars Acar on 15/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
  @ObservedObject var viewModel: OrderListViewModel = OrderListViewModel()
  
  @State var isAddOrderDisplayed: Bool = false
  
  var body: some View {
    
    NavigationView {
      List {
        ForEach(viewModel.orders, id: \.name) { order in
          
          HStack {
            Image(order.type)
              .resizable()
              .frame(width: 100, height: 100, alignment: .center)
              .cornerRadius(10)
            
            Text(order.name)
              .font(.title3)
              .padding(.leading, 8)
          }
        }
        .onDelete { indexSet in
          indexSet.forEach { i in
            let orderVM = viewModel.orders[i]
            viewModel.deleteOrder(orderVM)
          }
        }
      }
      .navigationTitle("Orders")
      .toolbar {
        Button(action: {
          isAddOrderDisplayed = true
          
        }, label: {
          Image(systemName: "plus")
            .foregroundColor(.primary)
        })
      }
      
    }
    .sheet(isPresented: $isAddOrderDisplayed, onDismiss: {
      isAddOrderDisplayed = false
    }, content: {
      AddOrderView(isDisplayed: $isAddOrderDisplayed) {
        viewModel.fetchAllOrders()
      }
    })
    
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
