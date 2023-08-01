//
//  NewsModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let publishedAt: String
}
