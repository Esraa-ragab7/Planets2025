//
//  DisplayPlanets.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation
import Combine

protocol PlanetsListUseCase {
    func execute() -> AnyPublisher<[Planet], Error>
}
