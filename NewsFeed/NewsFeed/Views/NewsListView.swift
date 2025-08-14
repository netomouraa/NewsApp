//
//  NewsListView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NewsRowView(item: item)
                }
            }
            .navigationTitle("Notícias")
            .refreshable {
                viewModel.refresh()
            }
            .onAppear {
                if viewModel.items.isEmpty {
                    viewModel.loadFeed()
                }
            }
        }
    }
}
