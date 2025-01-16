//
//  ContentView.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import SwiftUI
import CoreData

struct PlanetsListView: View {
    @ObservedObject var viewModel: PlanetsViewModel

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
                
                List(viewModel.planets, id: \.id) { planet in
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
    
    func textView(user: User) -> some View {
        Text(user.login)
            .font(.headline)
    }
}

#Preview {
    viewModel: ContentViewModel(fetchUsersUseCase: FetchUsersUseCase(repository: ContentRepository(service: ContentService())))
}
