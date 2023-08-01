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
    var lastRowArticle: Article { get }
    
    
    func requestNews(currentArticle: Article?) async
    func searchNews(searchText: String?) async
    func refreshNews() async
    func clearPage()
    func isShouldLoadMoreData(currentArticle: Article?) -> Bool
    func isScrollNearLastRow(currentOffsetY: CGFloat) -> Bool
//    func combineRequest(endpoint: String)
    
}

//MARK: ViewModel - Property
@MainActor class DailyNewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var error: ErrorType? = nil
    @Published var isEmptyNewsData: Bool = false
    
    private var service: NewsService
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    init(service: NewsService = DailyNewsService()) {
        self.service = service
    }
    
}

//MARK: ViewModel - Modify Extension Interface
extension DailyNewsViewModel: DailyNewsViewModelInterface {
    var rowStartIndex: Int {
        return articles.isEmpty ? -1 : articles.startIndex
        
    }
    var rowEndIndex: Int {
        return articles.isEmpty ? -1 : articles.endIndex - 1
    }
    
    var lastRowArticle: Article {
        return articles[rowEndIndex]
    }
    
    func searchNews(searchText: String?) async {
        
        do {
            
            guard let searchText = searchText , !searchText.isEmpty else {
                await refreshNews()
                return
            }
            
            //request
            let newsData: NewsModel = try await service.requestNews(url: "https://newsapi.org/v2/top-headlines?\(countryParam)&\(apiKeyParam)&q=\(searchText)")
            
            //condition append new data
            guard  newsData.status == StatusType.ok.rawValue else {
                if newsData.status == StatusType.error.rawValue {
                    self.error = ErrorType.failedLimitRequest
                } else {
                    self.error = ErrorType.failedUnknown
                }
                loadStatus = .done
                return
            }
            
            
            //initial set data value for update UI alway new data
            self.articles = newsData.articles
            
            //set condition case infinite load by enum loadStatus
            loadStatus = .done
            
            //set case is Empty when call first time (case apiKey is over limit or empty response)
            isEmptyNewsData = self.articles.isEmpty
            
            
        } catch (let error) {
            loadStatus = .parseError
            if let err = error as? ErrorType {
                self.error = err
            } else {
                self.error = ErrorType.failedUnknown
            }
        }
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
                if newsData.status == StatusType.error.rawValue {
                    self.error = ErrorType.failedLimitRequest
                } else {
                    self.error = ErrorType.failedUnknown
                }
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
            
            //set case is Empty when call first time (case apiKey is over limit or empty response)
            isEmptyNewsData = self.articles.isEmpty
            
            
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
        
        return currentArticle.id == articles[rowEndIndex].id
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
    
    func isScrollNearLastRow(currentOffsetY: CGFloat) -> Bool {
        if articles.isEmpty {
            return false
        } else {
            let allHeightSize = articles.count * heightFrameRowNews
            let diffSpace = 1000
            let minusHeigh = -(allHeightSize - diffSpace)
//            print("scrollPosition: \(allHeightSize), minusHeigh: \(minusHeigh) \n \(currentOffsetY) < \(CGFloat(minusHeigh))")
            return currentOffsetY < CGFloat(minusHeigh)
        }
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



