//
//  NewsService.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 1/8/2566 BE.
//

import Foundation
//MARK: Service
protocol NewsService {
    func requestNews(url: String) async throws -> NewsModel
    func requestSearchNews(url: String) async throws -> NewsModel
}

class DailyNewsService: NewsService {
    
    func requestNews(url: String) async throws -> NewsModel {
        let data = try await APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil)
        
        do {
            let responseNewsDisplay = try JSONDecoder().decode(NewsModel.self, from: data)
            print("Response NewsDisplay : \(responseNewsDisplay)")
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
    
    func requestSearchNews(url: String) async throws -> NewsModel {
        let data = try await APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil)
        
        do {
            let responseSearchNewsDisplay = try JSONDecoder().decode(NewsModel.self, from: data)
            print("Response SearchNewsDisplay : \(responseSearchNewsDisplay)")
            return responseSearchNewsDisplay
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
