//
//  Planet.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation

struct Planet: Codable {
    let name : String
    let rotationPeriod : String?
    let orbitalPeriod : String?
    let gravity : String?
    let surfaceWater : String?
    let population : String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case gravity
        case surfaceWater = "surface_water"
        case population
    }
}

extension Planet: Equatable { }

func == (lhs: Planet, rhs: Planet) -> Bool {
    return lhs.name == rhs.name
}
