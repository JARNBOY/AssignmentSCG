//
//  NewsModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct News: Codable, Identifiable {
    var id: UUID = UUID()
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let description: String
    let urlToImage: String
    let publishedAt: String
}
