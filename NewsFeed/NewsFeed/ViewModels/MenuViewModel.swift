//
//  MenuViewModel.swift
//  NewsFeed
//
//  Created by Neto Moura on 15/08/25.
//

import Foundation

@MainActor
class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    
    init() {
        loadMenuItems()
    }
    
    private func loadMenuItems() {
        menuItems = [
            MenuItem(title: "agro", url: "http://g1.globo.com/economia/agronegocios/"),
            MenuItem(title: "bem estar", url: "https://g1.globo.com/bemestar/"),
            MenuItem(title: "carros", url: "http://g1.globo.com/carros/"),
            MenuItem(title: "ciência e saúde", url: "http://g1.globo.com/ciencia-e-saude/"),
            MenuItem(title: "economia", url: "http://g1.globo.com/economia/"),
            MenuItem(title: "educação", url: "http://g1.globo.com/educacao/"),
            MenuItem(title: "fato ou fake", url: "https://g1.globo.com/fato-ou-fake/")
        ]
    }
}
