//
//  CachePlanetsRepositoryTests.swift
//  Planets2025
//
//  Created by Esraa Ragab on 17/01/2025.
//

import XCTest
import Combine
@testable import Planets2025

class CachePlanetsRepositoryTests: XCTestCase {
    var sut: CachePlanetsRepository! // System Under Test
    var apiRepositoryMock: ApiPlanetsRepositoryMock!
    var localRepositoryMock: LocalPersistencePlanetsRepositoryMock!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        apiRepositoryMock = ApiPlanetsRepositoryMock()
        localRepositoryMock = LocalPersistencePlanetsRepositoryMock()
        sut = CachePlanetsRepository(apiPlanetsRepository: apiRepositoryMock, localPersistencePlanetsRepository: localRepositoryMock)
        cancellables = []
    }

    override func tearDown() {
        apiRepositoryMock = nil
        localRepositoryMock = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchPlanetsFromApiSuccess() {
        // Given
        let expectedPlanets = Planet.createPlanetsArray()
        apiRepositoryMock.fetchPlanetsResultToBeReturned = .success(expectedPlanets)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch planets from API successfully")
        var receivedPlanets: [Planet]?
        var receivedError: Error?

        sut.fetchPlanets()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
            }, receiveValue: { planets in
                receivedPlanets = planets
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedPlanets, expectedPlanets)
        XCTAssertNil(receivedError)
        XCTAssertTrue(apiRepositoryMock.fetchPlanetsCalled)
        XCTAssertTrue(localRepositoryMock.saveCalled)
    }

    func testFetchPlanetsFromApiFailureAndLocalSuccess() {
        // Given
        let apiError = NSError(domain: "APIError", code: 1, userInfo: nil)
        let expectedPlanets = Planet.createPlanetsArray()
        apiRepositoryMock.fetchPlanetsResultToBeReturned = .failure(apiError)
        localRepositoryMock.fetchPlanetsResultToBeReturned = .success(expectedPlanets)

        // When
        let expectation = XCTestExpectation(description: "Fetch planets from local persistence after API failure")
        var receivedPlanets: [Planet]?
        var receivedError: Error?

        sut.fetchPlanets()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
            }, receiveValue: { planets in
                receivedPlanets = planets
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedPlanets, expectedPlanets)
        XCTAssertNil(receivedError)
        XCTAssertTrue(apiRepositoryMock.fetchPlanetsCalled)
        XCTAssertTrue(localRepositoryMock.fetchPlanetsCalled)
    }

    func testFetchPlanetsFromApiFailureAndLocalFailure() {
        // Given
        let apiError = NSError(domain: "APIError", code: 1, userInfo: nil)
        let localError = NSError(domain: "LocalError", code: 2, userInfo: nil)
        apiRepositoryMock.fetchPlanetsResultToBeReturned = .failure(apiError)
        localRepositoryMock.fetchPlanetsResultToBeReturned = .failure(localError)

        // When
        let expectation = XCTestExpectation(description: "Handle failure from both API and local persistence")
        var receivedPlanets: [Planet]?
        var receivedError: Error?

        sut.fetchPlanets()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            }, receiveValue: { planets in
                receivedPlanets = planets
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(receivedPlanets)
        XCTAssertNotNil(receivedError)
        XCTAssertTrue(apiRepositoryMock.fetchPlanetsCalled)
        XCTAssertTrue(localRepositoryMock.fetchPlanetsCalled)
    }
}
