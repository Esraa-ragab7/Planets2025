//
//  Untitled.swift
//  Planets2025
//
//  Created by Esraa Ragab on 17/01/2025.
//

import XCTest
import Combine
@testable import Planets2025

class PlanetsListViewModelTests: XCTestCase {
    var sut: PlanetsListViewModel! // System Under Test
    var useCaseMock: PlanetsListUseCaseMock!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        useCaseMock = PlanetsListUseCaseMock()
        sut = PlanetsListViewModel(planetsListUseCase: useCaseMock)
        cancellables = []
    }

    override func tearDown() {
        useCaseMock = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchPlanetsSuccess() {
        // Given
        let expectedPlanets = Planet.createPlanetsArray()
        useCaseMock.resultToBeReturned = .success(expectedPlanets)

        // When
        let expectation = XCTestExpectation(description: "Fetch planets successfully")
        sut.$planets
            .dropFirst() // Skip the initial empty array
            .sink { planets in
                XCTAssertEqual(planets, expectedPlanets, "Fetched planets should match the expected ones")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.fetchPlanets()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(sut.errorMessage, "Error message should be nil on success")
    }

    func testFetchPlanetsFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "API failure"])
        useCaseMock.resultToBeReturned = .failure(expectedError)

        // When
        let expectation = XCTestExpectation(description: "Handle fetch planets failure")
        sut.$errorMessage
            .dropFirst() // Skip the initial nil value
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Error fetching planets: API failure", "Error message should match the error description")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.fetchPlanets()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(sut.planets.isEmpty, "Planets array should remain empty on failure")
    }
}
