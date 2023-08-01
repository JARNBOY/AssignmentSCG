//
//  DailyNewsViewModel.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import Foundation

//MARK: ViewModel Interface
protocol DailyNewsViewModelInterface {
    
    var rowStartIndex: Int { get }
    var rowEndIndex: Int { get }
    
    func requestNews(currentArticle: Article?) async
    func refreshNews() async
    func clearPage()
    func isShouldLoadMoreData(currentArticle: Article?) -> Bool
//    func combineRequest(endpoint: String)
    
}

//MARK: ViewModel - Property
@MainActor class DailyNewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var error: ErrorType? = nil
    
    private var service: NewsService
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    init(service: NewsService = DailyNewsService()) {
        self.service = service
    }
    
}

//MARK: ViewModel - Modify Interface
extension DailyNewsViewModel: DailyNewsViewModelInterface {
    var rowStartIndex: Int {
        return articles.isEmpty ? -1 : articles.startIndex
        
    }
    var rowEndIndex: Int {
        return articles.isEmpty ? -1 : articles.endIndex
    }
    
    func requestNews(currentArticle: Article?) async {
        
        
        do {
            
            if !isShouldLoadMoreData(currentArticle: currentArticle) {
                return
            }
            guard case let .ready(page) = loadStatus else {
                return
            }
            
            loadStatus = .loading(page: page)
            
            //request
            let newsData: NewsModel = try await service.requestNews(url: "https://newsapi.org/v2/top-headlines?\(countryParam)&\(apiKeyParam)&page=\(page)")
            
            //condition append new data
            guard  newsData.status == StatusType.ok.rawValue else {
                self.error = ErrorType.failedUnknown
                loadStatus = .done
                return
            }
            
            //initial set data value for update UI
            if self.articles.isEmpty {
                self.articles = newsData.articles
            } else {
                self.articles += newsData.articles
            }
            
            //set condition case infinite load by enum loadStatus
            if newsData.articles.isEmpty {
                loadStatus = .done
            } else {
                loadStatus = .ready(nextPage: page + 1)
            }
            
        } catch (let error) {
            loadStatus = .parseError
            if let err = error as? ErrorType {
                self.error = err
            } else {
                self.error = ErrorType.failedUnknown
            }
        }
    }
    
    func isShouldLoadMoreData(currentArticle: Article?) -> Bool {
        guard let currentArticle = currentArticle else {
            return true
        }
        
        return currentArticle.id == articles[rowEndIndex - 1].id
    }
    
    func refreshNews() async {
        clearPage()
        await requestNews(currentArticle: nil)
    }
    
    func clearPage() {
        self.articles = []
        self.loadStatus = LoadStatus.ready(nextPage: 1)
        self.error = nil
    }
    
    
    
//    func combineRequest(endpoint: String) {
//        guard let url = URL(string: endpoint) else {
//            self.error = ErrorType.failedInvalidURL
//            return
//        }
//
//        URLSession.shared
//            .dataTaskPublisher(for: url)
//            .receive(on: DispatchQueue.main)
//            .flatMap(maxPublishers: .max(1)) { data in
//
//            }
//            .decode(type: NewsModel.self, decoder: JSONDecoder())
//            .sink { res in
//
//                switch res {
//                case .failure(let error):
//                    self.error = ErrorType.custom(error: error)
//                default: break
//                }
//
//            } receiveValue: { [weak self] newsModel in
//                self?.news = newsModel
//            }
//
//    }
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

