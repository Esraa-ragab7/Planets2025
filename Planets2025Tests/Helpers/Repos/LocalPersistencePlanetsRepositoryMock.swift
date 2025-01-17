//
//  LocalPersistencePlanetsGatewaySpy.swift
//  PlanetsTests
//
//  Created by Esraa Ragab on 17/01/2025.
//

import Foundation
@testable import Planets2025
import Combine

class LocalPersistencePlanetsRepositoryMock: LocalPersistencePlanetsRepository {
    var fetchPlanetsResultToBeReturned: Result<[Planet], Error>!
    var saveCalled = false
    var fetchPlanetsCalled = false

    func save(planets: [Planet]) {
        saveCalled = true
    }

    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        fetchPlanetsCalled = true
        return fetchPlanetsResultToBeReturned.publisher.eraseToAnyPublisher()
    }
}
