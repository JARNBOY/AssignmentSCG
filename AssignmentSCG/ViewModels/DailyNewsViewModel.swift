//
//  DailyNewsViewModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import Foundation

//MARK: ViewModel
protocol DailyNewsViewModelInterface {
    func requestNews() async
    func requestNextPageNews() async
    func refreshNews() async
    private func clearPage()
}
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

extension DailyNewsViewModel: DailyNewsViewModelInterface {
    func requestNews() async {
        do {
            
            hasError = false
            
            //request
            let newsData: NewsModel = try await service.requestNews(url: "https://newsapi.org/v2/top-headlines?\(countryParam)&\(apiKeyParam)&page=\(page)")
            
            //condition append new data
            if news != nil {
                if newsData.status == StatusType.ok.rawValue && !newsData.articles.isEmpty {
                    self.news?.articles += newsData.articles
                } else if newsData.status == StatusType.ok.rawValue && newsData.articles.isEmpty {
                    self.maxPage = page
                }
            } else {
                self.news = newsData
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
    
    internal func clearPage() {
        self.page = 1
        self.maxPage = nil
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
            print(responseNewsDisplay)
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

