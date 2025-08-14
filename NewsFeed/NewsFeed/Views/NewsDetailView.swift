//
//  NewsDetailView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI
import WebKit

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

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
