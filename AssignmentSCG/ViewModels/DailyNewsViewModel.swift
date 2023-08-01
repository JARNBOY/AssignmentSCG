//
//  DailyNewsViewModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import Foundation

//MARK: ViewModel Interface
protocol DailyNewsViewModelInterface {
    func requestNews() async
    func requestNextPageNews() async
    func refreshNews() async
    func clearPage()
    func isLastArticlesRow(currentArticle: Article) -> Bool
}

//MARK: ViewModel - Property
@MainActor class DailyNewsViewModel: ObservableObject {
    @Published var news: NewsModel? = nil
    @Published var hasError = false
    @Published var error: ErrorType? = nil
    
    private var service: NewsService
    private var page: Int = 1
    private var maxPage: Int? = nil
    
    init(service: NewsService = DailyNewsService()) {
        self.service = service
    }
    
}

//MARK: ViewModel - Modify Interface
extension DailyNewsViewModel: DailyNewsViewModelInterface {
    
    func requestNews() async {
        do {
            
            hasError = false
            
            //request
            let newsData: NewsModel = try await service.requestNews(url: "https://newsapi.org/v2/top-headlines?\(countryParam)&\(apiKeyParam)&page=\(page)")
            
            //condition append new data
            guard  newsData.status == StatusType.ok.rawValue else {
                self.error = ErrorType.failedUnknown
                return
            }
            
            guard var news = news else {
                self.news = newsData
                return
            }
            
            if newsData.articles.isEmpty {
                self.maxPage = page
            } else {
                news.articles += newsData.articles
            }
            
        } catch (let error) {
            hasError = true
            if let err = error as? ErrorType {
                self.error = err
            } else {
                self.error = ErrorType.failedUnknown
            }
        }
    }
    
    func requestNextPageNews() async  {
        //check 'newsData.status == StatusType.ok.rawValue && newsData.articles.isEmpty'
        if let maxPage = self.maxPage {
            if page == maxPage {
                return
            }
        }
        
        //request next
        self.page += 1
        await requestNews()
    }
    
    func refreshNews() async {
        clearPage()
        await requestNews()
    }
    
    func clearPage() {
        self.page = 1
        self.maxPage = nil
    }
    
    func isLastArticlesRow(currentArticle: Article) -> Bool {
        if let news = news {
            let articles = news.articles
            guard let index = articles.lastIndex(where: { $0.title == currentArticle.title }) else {
              return false
            }
            return index == articles.count - 1
        } else {
            return false
        }
    }
}

//MARK: Service
protocol NewsService {
    func requestNews(url: String) async throws -> NewsModel
}

class DailyNewsService: NewsService {
    
    func requestNews(url: String) async throws -> NewsModel {
        let data = try await APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil)
        
        do {
            let responseNewsDisplay = try JSONDecoder().decode(NewsModel.self, from: data)
            print("ResponseNewsDisplay : \(responseNewsDisplay)")
            return responseNewsDisplay
        } catch (let error) {
            print("Error decoding JSON: \(error)")
            if let err = error as? ErrorType {
                throw err
            } else {
                throw ErrorType.custom(error: error)
            }
        }
    }
}

