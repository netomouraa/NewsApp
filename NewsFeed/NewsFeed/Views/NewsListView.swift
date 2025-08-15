//
//  NewsListView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel: NewsViewModel
    let feedType: FeedType
    
    init(feedType: FeedType) {
        self.feedType = feedType
        self._viewModel = StateObject(wrappedValue: NewsViewModel(feedType: feedType))
//        self._viewModel = StateObject(wrappedValue: NewsViewModel(feedType: feedType, service: MockNewsService.shared))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: NewsDetailView(item: item)) {
                        NewsRowView(item: item)
                    }
                    .onAppear {
                        viewModel.loadMoreIfNeeded(currentItem: item)
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
            .navigationTitle(feedType.title)
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
