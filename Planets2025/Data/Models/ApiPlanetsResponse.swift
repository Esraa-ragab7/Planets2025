//
//  ApiPlanetsResponse.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation

struct ApiPlanetsResponse: Codable {
    let count : Int
    let next : String?
    let previous : String?
    let planets : [Planet]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case planets = "results"
    }
}
