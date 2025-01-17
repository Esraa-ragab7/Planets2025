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
    let coreDataStack = CoreDataStackImplementation.sharedInstance
    @Environment(\.scenePhase) private var scenePhase

    
    init() {
        let apiClient = ApiClientImplementation(urlSession: URLSession.shared)
        let apiPlanetsRepository = ApiPlanetsRepositoryImplementation(apiClient: apiClient)
        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let coreDataPlanetsRepository = CoreDataPlanetsRepository(viewContext: viewContext)
        let cachePlanetsGateway = CachePlanetsRepository(apiPlanetsRepository: apiPlanetsRepository, localPersistencePlanetsRepository: coreDataPlanetsRepository)
        let planetsListUseCase = PlanetsListUseCaseImplementation(planetsRepository: cachePlanetsGateway)
        self.viewModel = PlanetsListViewModel(planetsListUseCase: planetsListUseCase)
    }

    var body: some Scene {
        WindowGroup {
            PlanetsListView(viewModel: viewModel)
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                coreDataStack.saveContext()
            default:
                break
            }
        }
    }
}
