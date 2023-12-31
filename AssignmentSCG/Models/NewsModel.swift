//
//  NewsModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct NewsModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article] = []
}

struct Article: Codable, Equatable, Identifiable {
    var id = UUID()
    
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description, urlToImage, publishedAt
    }
}
