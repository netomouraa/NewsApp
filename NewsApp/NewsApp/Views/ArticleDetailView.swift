//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Neto Moura on 11/08/25.
//

import Foundation
import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageURL = article.imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(height: 200)
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(article.displaySection)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .fontWeight(.medium)
                    
                    Text(article.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if !article.displayTime.isEmpty {
                        Text(article.displayTime)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    if let summary = article.summary {
                        Text(summary)
                            .font(.body)
                            .lineSpacing(4)
                    }
                    
                    Button(action: {
                        if let url = URL(string: article.url) {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Ler matéria completa no G1")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.up.right")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
