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
                    NavigationLink(destination: NewsDetailView(item: item)) {
                        NewsRowView(item: item)
                    }
                    .onAppear {
                        if item.id == viewModel.items.last?.id {
                            viewModel.loadMore()
                        }
                    }
                }
                
                if viewModel.isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
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
