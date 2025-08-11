//
//  ContentView.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import SwiftUI

// MARK: - Views
struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NewsListView()
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
