//
//  NewsModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct NewsModel: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article] = []
}

struct Article: Decodable, Equatable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
}
