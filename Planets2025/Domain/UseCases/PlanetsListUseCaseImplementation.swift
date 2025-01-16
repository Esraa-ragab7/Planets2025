//
//  DisplayPlanetsUseCase.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Combine

class PlanetsListUseCaseImplementation: PlanetsListUseCase {
    
    let planetsRepository: PlanetsRepositoryType
    
    init(planetsRepository: PlanetsRepositoryType) {
        self.planetsRepository = planetsRepository
    }
    
    // MARK: - DisplayPlanetsUseCase
    func execute() -> AnyPublisher<[Planet], Error>{
        return planetsRepository.fetchPlanets()
    }
}
