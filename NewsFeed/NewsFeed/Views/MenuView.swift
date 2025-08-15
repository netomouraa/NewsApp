//
//  MenuView.swift
//  NewsFeed
//
//  Created by Neto Moura on 15/08/25.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.menuItems) { item in
                if let url = URL(string: item.url) {
                    NavigationLink(destination: WebView(url: url)
                        .navigationTitle(item.title.capitalized)
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        Text(item.title.capitalized)
                    }
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
