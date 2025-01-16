//
//  DisplayPlanetsUseCase.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

class PlanetsListUseCaseImplementation: PlanetsUseCase {
    let planetsRepository: PlanetsRepositoryType
    
    init(planetsRepository: PlanetsRepositoryType) {
        self.planetsRepository = planetsRepository
    }
    
    // MARK: - DisplayPlanetsUseCase
    
    func displayPlanets(completionHandler: @escaping (Result<[Planet]>) -> Void) {
        self.planetsRepository.fetchPlanets { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
