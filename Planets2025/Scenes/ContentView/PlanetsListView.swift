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
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(viewModel: PlanetsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        // Conditional layout based on orientation
        Group {
            VStack(spacing: 0) {
                header
                content
            }
        }
        .background(
            Image("Space")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
    
    // Header view for the title
    var header: some View {
        Text("Planets List")
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .none, alignment: .leading)
            .background(Color.headerColor)
    }
    
    // Main content (List of planets)
    var content: some View {
        Group {
            if let errorMessage = viewModel.errorMessage {
                // Display error message if exists
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            List(viewModel.planets, id: \.name) { planet in
                ListCellView(text: planet.name)
                    .frame(height: 70)
                    .background(Color.planetCellBackgroundColor)
                    .listRowBackground(Color.clear)
            }
            .padding(.all, 0)
            .listStyle(PlainListStyle())
//            .clipShape(Rectangle())
            .onAppear {
                viewModel.fetchPlanets()
            }
        }
    }
}

#Preview {
    PlanetsListView(viewModel: PlanetsListViewModel(planetsListUseCase: PlanetsListUseCaseImplementation(planetsRepository: ApiPlanetsRepositoryImplementation(apiClient: ApiClientImplementation(urlSession: URLSession.shared)))))
}
