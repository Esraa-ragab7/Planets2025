//
//  DisplayPlanetsUseCaseSpy.swift
//  PlanetsTests
//
//  Created by Esraa Ragab on 17/01/2025.
//

import Foundation
import Combine
@testable import Planets2025

class PlanetsListUseCaseMock: PlanetsListUseCase {
    var resultToBeReturned: Result<[Planet], Error>!
    var executeCalled = false

    func execute() -> AnyPublisher<[Planet], Error> {
        executeCalled = true
        return resultToBeReturned.publisher.eraseToAnyPublisher()
    }
}
