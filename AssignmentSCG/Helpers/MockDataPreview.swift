//
//  MockDataPreview.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

let dataArticleMock:Article = Article(
    title: "Box Office: ‘Haunted Mansion’ Spooked, ‘Barbie’ Scores Record $93M Second Weekend - Hollywood Reporter",
    description: "'Haunted Mansion' has started off with a lackluster $24.2 million in another summer bummer for Disney. Elsewhere, 'Oppenheimer' earned a stellar $46.2 million in its sophomore outing.",
    urlToImage: "https://www.hollywoodreporter.com/wp-content/uploads/2023/07/Haunted-Mansion-Barbie-and-Oppenheimer-Split-H-2023.jpg?w=1024",
    publishedAt: "2023-07-30T16:30:00Z")

let dataNewsMock: NewsModel = NewsModel(
    status: "ok",
    totalResults: 38,
    articles: [
        Article(
            title: "Box Office: ‘Haunted Mansion’ Spooked, ‘Barbie’ Scores Record $93M Second Weekend - Hollywood Reporter",
            description: "'Haunted Mansion' has started off with a lackluster $24.2 million in another summer bummer for Disney. Elsewhere, 'Oppenheimer' earned a stellar $46.2 million in its sophomore outing.",
            urlToImage: "https://www.hollywoodreporter.com/wp-content/uploads/2023/07/Haunted-Mansion-Barbie-and-Oppenheimer-Split-H-2023.jpg?w=1024",
            publishedAt: "2023-07-30T16:30:00Z"),
        Article(
            title: "Box Office: ‘Haunted Mansion’ Spooked, ‘Barbie’ Scores Record $93M Second Weekend - Hollywood Reporter",
            description: "'Haunted Mansion' has started off with a lackluster $24.2 million in another summer bummer for Disney. Elsewhere, 'Oppenheimer' earned a stellar $46.2 million in its sophomore outing.",
            urlToImage: "https://www.hollywoodreporter.com/wp-content/uploads/2023/07/Haunted-Mansion-Barbie-and-Oppenheimer-Split-H-2023.jpg?w=1024",
            publishedAt: "2023-07-30T16:30:00Z"),
        Article(
            title: "Box Office: ‘Haunted Mansion’ Spooked, ‘Barbie’ Scores Record $93M Second Weekend - Hollywood Reporter",
            description: "'Haunted Mansion' has started off with a lackluster $24.2 million in another summer bummer for Disney. Elsewhere, 'Oppenheimer' earned a stellar $46.2 million in its sophomore outing.",
            urlToImage: "https://www.hollywoodreporter.com/wp-content/uploads/2023/07/Haunted-Mansion-Barbie-and-Oppenheimer-Split-H-2023.jpg?w=1024",
            publishedAt: "2023-07-30T16:30:00Z"),
        Article(
            title: "Box Office: ‘Haunted Mansion’ Spooked, ‘Barbie’ Scores Record $93M Second Weekend - Hollywood Reporter",
            description: "'Haunted Mansion' has started off with a lackluster $24.2 million in another summer bummer for Disney. Elsewhere, 'Oppenheimer' earned a stellar $46.2 million in its sophomore outing.",
            urlToImage: "https://www.hollywoodreporter.com/wp-content/uploads/2023/07/Haunted-Mansion-Barbie-and-Oppenheimer-Split-H-2023.jpg?w=1024",
            publishedAt: "2023-07-30T16:30:00Z"),
        Article(
            title: "Box Office: ‘Haunted Mansion’ Spooked, ‘Barbie’ Scores Record $93M Second Weekend - Hollywood Reporter",
            description: "'Haunted Mansion' has started off with a lackluster $24.2 million in another summer bummer for Disney. Elsewhere, 'Oppenheimer' earned a stellar $46.2 million in its sophomore outing.",
            urlToImage: "https://www.hollywoodreporter.com/wp-content/uploads/2023/07/Haunted-Mansion-Barbie-and-Oppenheimer-Split-H-2023.jpg?w=1024",
            publishedAt: "2023-07-30T16:30:00Z")
    ]
)

let imageURLMock = "https://media.cnn.com/api/v1/images/stellar/prod/230729202313-02-moscow-city-drone-attack-0730.jpg?c=16x9&q=w_800,c_fill"

let errorLimitResponseMock = """
{
    "status": "error",
    "code": "rateLimited",
    "message": "You have made too many requests recently. Developer accounts are limited to 100 requests over a 24 hour period (50 requests available every 12 hours). Please upgrade to a paid plan if you need more requests."
}
"""
