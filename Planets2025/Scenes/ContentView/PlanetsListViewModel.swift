//
//  ContentViewModel.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import SwiftUI
import Combine

class PlanetsViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let planetsListUseCase: PlanetsListUseCase

    init(planetsListUseCase: PlanetsListUseCase) {
        self.planetsListUseCase = planetsListUseCase
    }

    func fetchPlanets() {
        planetsListUseCase.execute()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Error fetching planets: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] planets in
                self?.planets = planets
            })
            .store(in: &cancellables)
    }

}
