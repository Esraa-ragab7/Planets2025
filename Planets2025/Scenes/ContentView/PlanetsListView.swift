//
//  ContentView.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import SwiftUI
import CoreData

struct PlanetsListView: View {
    @ObservedObject var viewModel: PlanetsListViewModel

    init(viewModel: PlanetsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                List(viewModel.planets, id: \.name) { planet in
                    Text(planet.name)
                        .font(.headline)
                        .padding()
                }
                .onAppear {
                    viewModel.fetchPlanets()
                }
                .navigationTitle("Planets List")
            }
        }
    }
}

#Preview {
    PlanetsListView(viewModel: PlanetsListViewModel(planetsListUseCase: PlanetsListUseCaseImplementation(planetsRepository: ApiPlanetsRepositoryImplementation(apiClient: ApiClientImplementation(urlSession: URLSession.shared)))))
}

