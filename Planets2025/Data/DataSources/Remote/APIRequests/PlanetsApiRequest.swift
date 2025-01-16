//
//  PlanetsApiRequest.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation

struct PlanetsApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let path = "planets"
        let url: URL! = URL(string: "\(ProductionServer.baseURL)\(path)")
        var request = URLRequest(url: url)
                
        request.httpMethod = "GET"
        
        return request
    }
}
