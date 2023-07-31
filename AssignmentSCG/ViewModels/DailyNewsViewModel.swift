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
}
@MainActor class DailyNewsViewModel: DailyNewsViewModelInterface, ObservableObject {
    @Published var news: NewsModel? = nil
    @Published var hasError = false
    @Published var error: ErrorType? = nil
    
    var service: NewsService
    
    
    init(service: NewsService = DailyNewsService()) {
        self.service = service
    }
    
    func requestNews() async {
        do {
            self.news = try await service.requestNews(url: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0bfb7217d29740c3a8ca13fda1c95a49&page=1")
        } catch (let error) {
            hasError = true
            if let err = error as? ErrorType {
                self.error = err
            } else {
                self.error = ErrorType.failedUnknown
            }
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

