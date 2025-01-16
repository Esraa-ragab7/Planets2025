//
//  Planets2025App.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import SwiftUI

@main
struct Planets2025App: App {
    let viewModel: PlanetsListViewModel
    
    init() {
        let apiClient = ApiClientImplementation(urlSession: URLSession.shared)
        let apiPlanetsRepository = ApiPlanetsRepositoryImplementation(apiClient: apiClient)
        let planetsListUseCase = PlanetsListUseCaseImplementation(planetsRepository: apiPlanetsRepository)
        self.viewModel = PlanetsListViewModel(planetsListUseCase: planetsListUseCase)
    }

    var body: some Scene {
        WindowGroup {
            PlanetsListView(viewModel: viewModel)
        }
    }
}
