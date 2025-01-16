//
//  ApiPlanetsRepository.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation
import Combine

// This protocol in not necessarily needed since it doesn't include any extra methods besides what PlanetsGateway already provides if there would be any extra methods
protocol ApiPlanetsRepository: PlanetsRepositoryType {
    
}

class ApiPlanetsRepositoryImplementation: ApiPlanetsRepository {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiPlanetsGateway
    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        let request = PlanetsApiRequest() // Assuming you have an ApiRequest called PlanetsApiRequest
        
        return apiClient.execute(request: request) // Execute the API request
            .map { (response: ApiResponse<ApiPlanetsResponse>) in
                // Map the API response to an array of planets
                return response.entity.planets
            }
            .eraseToAnyPublisher()  // Erase the publisher type for flexibility
    }

}
