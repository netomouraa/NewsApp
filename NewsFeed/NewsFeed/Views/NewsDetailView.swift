//
//  NewsDetailView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI

struct NewsDetailView: View {
    let item: NewsItem
    
    var body: some View {
        if let urlString = item.content?.url,
           let url = URL(string: urlString) {
            WebView(url: url)
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("URL não disponível")
        }
    }
}
