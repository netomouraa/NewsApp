//
//  NewsRowView.swift
//  NewsFeed
//
//  Created by Neto Moura on 14/08/25.
//

import SwiftUI

struct NewsRowView: View {
    let item: NewsItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let chapeu = item.content?.chapeu?.label {
                Text(chapeu.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }

            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: item.content?.image?.url ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 60)
                        .clipped()
                        .cornerRadius(6)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 60)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.content?.title ?? "")
                        .font(.headline)
                        .lineLimit(2)
                    
                    if let summary = item.content?.summary, !summary.isEmpty {
                        Text(summary)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    
                    if let metadata = item.metadata {
                        Text(metadata)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}
