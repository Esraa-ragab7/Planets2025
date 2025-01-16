//
//  LocalPersistencePlanets.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation
import Combine
import CoreData

protocol LocalPersistencePlanetsRepository: PlanetsRepositoryType {
    func save(planets: [Planet])
}

class CoreDataPlanetsRepository: LocalPersistencePlanetsRepository {
    
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    // MARK: - PlanetsGateway
    func fetchPlanets() -> AnyPublisher<[Planet], Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(CoreError(message: "Self is nil")))
                return
            }
            
            // Attempt to retrieve planets from CoreData
            do {
                let coreDataPlanets = try self.viewContext.allEntities(withType: CoreDataPlanet.self)
                
                if coreDataPlanets.isEmpty {
                    promise(.failure(CoreError(message: "No planets found in the database")))
                } else {
                    // Map CoreDataPlanet to your model (Planet)
                    let planets = coreDataPlanets.map { $0.planet }
                    promise(.success(planets))
                }
            } catch {
                promise(.failure(CoreError(message: "Error accessing CoreData: \(error.localizedDescription)")))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - LocalPersistencePlanetsGateway
    
    func save(planets: [Planet]) {
        for planet in planets {
            guard let coreDataPlanet = viewContext.addEntity(withType: CoreDataPlanet.self) else {
                return
            }
            
            let predicate = NSPredicate(format: "name==%@", planet.name)

            if let coreDataPlanets = try? viewContext.allEntities(withType: CoreDataPlanet.self, predicate: predicate), let coreDataPlanet = coreDataPlanets.first {
                coreDataPlanet.populate(with: planet)
            } else {
                coreDataPlanet.populate(with: planet)
            }
            
            do {
                try viewContext.save()
            } catch {
                viewContext.delete(coreDataPlanet)
            }
        }
    }
}
