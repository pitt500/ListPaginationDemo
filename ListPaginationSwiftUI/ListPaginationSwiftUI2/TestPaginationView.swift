//
//  TestPaginationView.swift
//  ListPaginationSwiftUI2
//
//  Created by projas on 5/29/20.
//  Copyright © 2020 Pedro Rojas. All rights reserved.
//

import SwiftUI

struct TestPaginationView: View {
  @ObservedObject var viewModel = ItemListViewModel()
  
  var body: some View {
    NavigationView {
      ListPagination(items: viewModel.items, offset: 8, pagination: viewModel.getData) { item in
        Text("Item #\(item)")
      }.onAppear {
        self.viewModel.getData()
      }
      .navigationBarTitle("Pagination Test")
    }
  }
}

struct TestPaginationView_Previews: PreviewProvider {
  static var previews: some View {
    TestPaginationView()
  }
}
