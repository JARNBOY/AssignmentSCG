//
//  DailyNewsViewModelTests.swift
//  AssignmentSCGTests
//
//  Created by Papon Supamongkonchai on 2/8/2566 BE.
//

import XCTest
@testable import AssignmentSCG

class MockDailyNewsService: NewsService {
    
    var isSuccess = false
    var error: ErrorType = .failedUnknown
    
    func requestNews(url: String) async throws -> NewsModel {
        let data = try await APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil)
        
        if isSuccess {
            return dataNewsMock
        } else {
            throw error
        }
    }
    
    func requestSearchNews(url: String) async throws -> NewsModel {
        let data = try await APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil)
        
        if isSuccess {
            return dataNewsMock
        } else {
            throw error
        }
    }
}
class DailyNewsViewModelTests: XCTestCase {
    
    var serviceMock: MockDailyNewsService!
    var viewModel: DailyNewsViewModel!

    @MainActor override func setUp() {
        serviceMock = MockDailyNewsService()
        viewModel = DailyNewsViewModel(service: serviceMock)
    }

    func testSearchNews_EmptySearchText_request_success() async throws {
        // Given
        let expectation = expectation(description: "Search News Success Expectation")
        let searchText = ""
        // When
        serviceMock.isSuccess = true
        await viewModel.searchNews(searchText: searchText)
        
        // Then
        let articles = await viewModel.articles
        let error = await viewModel.error
        let isEmptyNewsData = await viewModel.isEmptyNewsData
        XCTAssertTrue(articles.count > 0, "Articles should not be empty")
        XCTAssertNil(error, "Error should be nil")
        XCTAssertFalse(isEmptyNewsData, "isEmptyNewsData should be false")
        expectation.fulfill()
        await(fulfillment(of: [expectation]))
        
    }
    
    func testSearchNews_WithSearchText_request_success() async throws {
        // Given
        let expectation = expectation(description: "Search News Success Expectation")
        let searchText = "Apple"

        // When
        serviceMock.isSuccess = true
        await viewModel.searchNews(searchText: searchText)

        // Then
        let articles = await viewModel.articles
        let error = await viewModel.error
        let isEmptyNewsData = await viewModel.isEmptyNewsData
        XCTAssertTrue(articles.count > 0, "Articles should not be empty")
        XCTAssertNil(error, "Error should be nil")
        XCTAssertFalse(isEmptyNewsData, "isEmptyNewsData should be false")
        expectation.fulfill()
        await(fulfillment(of: [expectation]))
    }
    
    func testSearchNews_request_failedInvalidURL() async throws {
        // Given
        let expectation = expectation(description: "Search News Fail Expectation")
        let searchText = ""
        // When
        serviceMock.isSuccess = false
        serviceMock.error = .failedInvalidURL
        await viewModel.searchNews(searchText: searchText)
        
        // Then
        let articles = await viewModel.articles
        let error = await viewModel.error ?? .failedUnknown
        let isEmptyNewsData = await viewModel.isEmptyNewsData
        XCTAssertFalse(articles.count > 0, "Articles should not be empty")
        XCTAssertTrue(error == ErrorType.failedInvalidURL, "Error failedInvalidURL")
        expectation.fulfill()
        await(fulfillment(of: [expectation]))
        
    }
    

    func testRefreshNews_request_success() async throws {
        // Given
        let expectation = expectation(description: "Refresh News Success Expectation")

        // When
        serviceMock.isSuccess = true
        await viewModel.refreshNews()

        // Then
        let articles = await viewModel.articles
        let error = await viewModel.error
        let isEmptyNewsData = await viewModel.isEmptyNewsData
        XCTAssertTrue(articles.count > 0, "Articles should not be empty")
        XCTAssertNil(error, "Error should be nil")
        XCTAssertFalse(isEmptyNewsData, "isEmptyNewsData should be false")
        expectation.fulfill()
        await(fulfillment(of: [expectation]))
    }
    
    func testRefreshNews_request_failedInvalidURL() async throws {
        // Given
        let expectation = expectation(description: "Refresh News Success Expectation")

        // When
        serviceMock.isSuccess = false
        serviceMock.error = .failedInvalidURL
        await viewModel.refreshNews()

        // Then
        let articles = await viewModel.articles
        let error = await viewModel.error ?? .failedUnknown
        XCTAssertFalse(articles.count > 0, "Articles should not be empty")
        XCTAssertTrue(error == ErrorType.failedInvalidURL, "Error failedInvalidURL")
        expectation.fulfill()
        await(fulfillment(of: [expectation]))
        
    }

    // Add more test cases as needed for other functions in the DailyNewsViewModel

}

