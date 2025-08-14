//
//  NewsFeedView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NewsFeedRowView(item: item)
                }
            }
            .navigationTitle("Notícias")
            .onAppear {
                if viewModel.items.isEmpty {
                    viewModel.loadFeed()
                }
            }
        }
    }
}
