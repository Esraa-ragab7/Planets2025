//
//  CoreDataPlanet.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation
import CoreData

extension CoreDataPlanet {
    var planet: Planet {
        return Planet(name: name ?? "",
                      rotationPeriod: rotationPeriod,
                      orbitalPeriod: orbitalPeriod,
                      gravity: gravity,
                      surfaceWater: surfaceWater,
                      population: population)
    }
    
    func populate(with planet: Planet) {
        name = planet.name
        rotationPeriod = planet.rotationPeriod
        orbitalPeriod = planet.orbitalPeriod
        gravity = planet.gravity
        surfaceWater = planet.surfaceWater
        population = planet.population
    }
    
}
