//
//  CachePlanetsGateway.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation
import Combine

class CachePlanetsRepository: PlanetsRepositoryType {
    let apiPlanetsRepository: ApiPlanetsRepository
    let localPersistencePlanetsRepository: LocalPersistencePlanetsRepository
    
    init(apiPlanetsRepository: ApiPlanetsRepository, localPersistencePlanetsRepository: LocalPersistencePlanetsRepository) {
        self.apiPlanetsRepository = apiPlanetsRepository
        self.localPersistencePlanetsRepository = localPersistencePlanetsRepository
    }
    
    // MARK: - Planets Gateway
    
    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        // Call the API repository to fetch planets
        return apiPlanetsRepository.fetchPlanets()
            .map { planets in
                return Result<[Planet], Error>.success(planets)
            }
            .catch { error in
                return Just(Result<[Planet], Error>.failure(error))
                    .eraseToAnyPublisher()
            }
            .flatMap { [weak self] result -> AnyPublisher<[Planet], Error> in
                guard let self = self else {
                    return Fail(error: CoreError(message: "Self is nil")).eraseToAnyPublisher()
                }
                
                // Wrap the result into a Result type before passing to handleFetchPlanetsApiResult
                return self.handleFetchPlanetsApiResult(result)
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private functions
    private func handleFetchPlanetsApiResult(_ result: Result<[Planet], Error>) -> AnyPublisher<[Planet], Error> {
        switch result {
        case .success(let planets):
            // Return the planets array as a publisher
            localPersistencePlanetsRepository.save(planets: planets)
            return Just(planets)
                .setFailureType(to: Error.self)  // Convert Just to AnyPublisher
                .eraseToAnyPublisher()
        
        case .failure(let error):
            // If API call fails, fetch from local persistence
            return localPersistencePlanetsRepository.fetchPlanets()
                .catch { (localError: Error) -> AnyPublisher<[Planet], Error> in
                    // Handle local persistence errors if needed
                    Fail(error: localError).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }

}
