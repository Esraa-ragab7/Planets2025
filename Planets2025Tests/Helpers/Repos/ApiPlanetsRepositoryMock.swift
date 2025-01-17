//
//  ApiPlanetsGatewaySpy.swift
//  PlanetsTests
//
//  Created by Esraa Ragab on 17/01/2025.
//

import Foundation
@testable import Planets2025
import Combine

class ApiPlanetsRepositoryMock: ApiPlanetsRepository {
    var fetchPlanetsResultToBeReturned: Result<[Planet], Error>!
    var fetchPlanetsCalled = false

    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        fetchPlanetsCalled = true
        return fetchPlanetsResultToBeReturned.publisher.eraseToAnyPublisher()
    }
}
