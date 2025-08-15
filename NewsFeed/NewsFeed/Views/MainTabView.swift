//
//  MainTabView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NewsListView(feedType: .g1)
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("G1")
                }
            
            NewsListView(feedType: .agronegocio)
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Agronegócio")
                }
            
            MenuView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Menu")
                }
        }
    }
}
