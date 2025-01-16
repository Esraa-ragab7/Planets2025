//
//  DisplayPlanets.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation

typealias DisplayPlanetsUseCaseCompletionHandler = (_ planets: Result<[Planet]>) -> Void

protocol PlanetsUseCase {
    func displayPlanets(completionHandler: @escaping DisplayPlanetsUseCaseCompletionHandler)
}
