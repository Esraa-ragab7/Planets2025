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
                      diameter: diameter,
                      climate: climate,
                      gravity: gravity,
                      terrain: terrain,
                      surfaceWater: surfaceWater,
                      population: population,
                      residents: residents,
                      films: films,
                      created: created,
                      edited: edited,
                      url: url)
    }
    
    func populate(with planet: Planet) {
        name = planet.name
        rotationPeriod = planet.rotationPeriod
        orbitalPeriod = planet.orbitalPeriod
        diameter = planet.diameter
        climate = planet.climate
        gravity = planet.gravity
        terrain = planet.terrain
        surfaceWater = planet.surfaceWater
        population = planet.population
        residents = planet.residents
        films = planet.films
        created = planet.created
        edited = planet.edited
        url = planet.url
    }
    
}
