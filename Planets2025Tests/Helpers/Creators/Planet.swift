//
//  Planet.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets2025

extension Planet {
    static func createPlanetsArray(numberOfElements: Int = 2) -> [Planet] {
        var planets = [Planet]()
        
        for i in 0..<numberOfElements {
            let planet = createPlanet(index: i)
            planets.append(planet)
        }
        
        return planets
    }
    
    static func createPlanet(index: Int = 0) -> Planet {
        return Planet(name: "Planet \(index)", rotationPeriod: "rotationPeriod", orbitalPeriod: "orbitalPeriod", gravity: "gravity", surfaceWater: "surfaceWater", population: "population")
    }
}
