//
//  APIManager.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

class APIManager {
    static let shared = APIManager()
    
    func request(endpoint: String, method: HTTPMethod , headers: [String: String]?, body: Data?) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw ErrorType.failedInvalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let session = URLSession.shared
        
        let (data, response) = try await session.data(for: request)
        
        print("Request : \(request)")
        print("Data : \(data)")
        print("Response : \(response)")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorType.failedToResponse
        }
        
        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            return data
        } else {
            throw ErrorType.failedRequest(httpResponse: httpResponse)
        }
    }

}

enum LoadStatus: Equatable {
    case ready (nextPage: Int)
    case loading
    case parseError
    case done
}

enum ErrorType: LocalizedError, Equatable {
    case custom(error: Error)
    case failedToResponse
    case failedToDecode
    case failedInvalidURL
    case failedNilData
    case failedUnknown
    case failedLimitRequest
    case failedRequest(httpResponse: HTTPURLResponse)
    
    var errorDescription: String? {
        switch self {
            
        case .custom(error: let error):
            return error.localizedDescription
        case .failedToDecode:
            return "Failed to decode response"
        case .failedInvalidURL:
            return "Failed to Invalid URL"
        case .failedToResponse:
            return "Failed to response"
        case .failedRequest(httpResponse: let httpResponse):
            return "Failed to request API request failed with status code \(httpResponse.statusCode) : \(httpResponse.description)"
        case .failedNilData:
            return "Response is nil data"
        case .failedUnknown:
            return "Failed Unknown"
        case .failedLimitRequest:
            return "Failed Limited Request"
        }
    }
    
    static func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}

enum StatusType: String {
    case ok = "ok"
    case error = "error"
}
