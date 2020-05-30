//
//  ListPagination.swift
//  ListPaginationSwiftUI2
//
//  Created by projas on 5/29/20.
//  Copyright © 2020 Pedro Rojas. All rights reserved.
//

import SwiftUI

public struct ListPagination<Item: Identifiable, Content: View>: View {
  
  private var items: [Item]
  var content: (_ item: Item) -> Content
  var pagination: ((() -> Void)?) -> Void
  @State var isLoading = false
  private var offset: Int
  
  public init (items: [Item], offset: Int = 5, pagination: @escaping (_ completion: (() -> Void)?) -> Void, @ViewBuilder content: @escaping (_ item: Item) -> Content) {
    self.items =  items
    self.content = content
    self.pagination = pagination
    self.offset = offset
  }
  
  public var body: some View {
    List {
      ForEach(items.indices, id: \.self) { index in
        VStack {
          self.content(self.items[index])
          if self.isLoading && self.isLastItem(index: index) {
            HStack(alignment: .center) {
              SpinnerView(isAnimating: self.$isLoading, style: .medium)
            }
          }
        }.onAppear {
          self.itemAppears(at: index)
        }
      }
    }
  }
}

extension ListPagination {
  
  private func isLastItem(index: Int) -> Bool {
    index == (items.count - 1)
  }
  
  private func isOffsetReached(at index: Int) -> Bool {
    index == (items.count - offset)
  }
  
  private func itemAppears(at index: Int) {
    if isOffsetReached(at: index) {
      isLoading = true
      
      pagination {
        self.isLoading = false
      }
    }
  }
}

