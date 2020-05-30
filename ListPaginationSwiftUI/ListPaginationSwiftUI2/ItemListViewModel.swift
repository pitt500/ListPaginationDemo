//
//  ItemListViewModel.swift
//  ListPaginationSwiftUI2
//
//  Created by projas on 5/29/20.
//  Copyright © 2020 Pedro Rojas. All rights reserved.
//

import Foundation

class ItemListViewModel: ObservableObject {
  @Published var items: [Int] = []
  static private var itemsPerPage = 25
  private var start = -ItemListViewModel.itemsPerPage
  private var stop = -1
  private let maxData = 250
  
  private func incrementPaginationIndices() {
    start += ItemListViewModel.itemsPerPage
    stop += ItemListViewModel.itemsPerPage
    
    stop = min(maxData, stop)
  }
  
  private func retrieveDataFromAPI(completion: (() -> Void)? = nil) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
      guard let self = self else { return }
      
      let newData = Array(self.start...self.stop)
      self.items.append(contentsOf: newData)
      completion?()
    }
  }
  
  func getData(completion: (() -> Void)? = nil) {
    
    if start > maxData {
      completion?()
      return
    }
    
    incrementPaginationIndices()
    retrieveDataFromAPI(completion: completion)
  }
}

extension Int: Identifiable {
  public var id: Int {
    return self
  }
}
