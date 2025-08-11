//
//  NewsListView.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import Foundation
import SwiftUI

struct NewsListView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Carregando notícias do G1...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage, viewModel.articles.isEmpty {
                    ErrorView(message: errorMessage) {
                        viewModel.loadNews()
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.articles) { article in
                                NavigationLink(destination: ArticleDetailView(article: article)) {
                                    ArticleCardView(article: article)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        viewModel.loadNews()
                    }
                }
            }
            .navigationTitle("G1 Notícias")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
