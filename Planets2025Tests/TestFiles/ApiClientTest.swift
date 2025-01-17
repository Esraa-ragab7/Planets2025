//
//  ApiClientTest.swift
//  PlanetsTests
//
//  Created by Esraa Ragab on 17/01/2025.
//

import XCTest
import Combine
@testable import Planets2025

class ApiClientTests: XCTestCase {
    var sut: ApiClientImplementation!  // System Under Test
    var urlSessionMock: URLSessionMock!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        urlSessionMock = URLSessionMock()
        sut = ApiClientImplementation(urlSession: urlSessionMock)
        cancellables = []
    }

    override func tearDown() {
        urlSessionMock = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecuteReturnsSuccess() {
        // Given
        let expectedData = """
        {
            "key": "value"
        }
        """.data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        urlSessionMock.output = (expectedData, expectedResponse)
        let apiRequest = MockApiRequest(url: "https://example.com")

        // When
        let expectation = XCTestExpectation(description: "Execute API request successfully")
        var receivedResponse: ApiResponse<[String: String]>?
        var receivedError: Error?

        sut.execute(request: apiRequest)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
            }, receiveValue: { response in
                receivedResponse = response
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedResponse)
        XCTAssertNil(receivedError)
    }

    func testExecuteReturnsErrorForHTTPError() {
        // Given
        let expectedData = """
        {
            "error": "Something went wrong"
        }
        """.data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        urlSessionMock.output = (expectedData, expectedResponse)
        let apiRequest = MockApiRequest(url: "https://example.com")

        // When
        let expectation = XCTestExpectation(description: "Handle HTTP error response")
        var receivedResponse: ApiResponse<[String: String]>?
        var receivedError: Error?

        sut.execute(request: apiRequest)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                receivedResponse = response
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(receivedResponse)
        XCTAssertNotNil(receivedError)
    }
}
