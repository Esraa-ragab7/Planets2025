//
//  MockApiRequest.swift
//  Planets2025
//
//  Created by Esraa Ragab on 17/01/2025.
//
import Foundation
@testable import Planets2025

struct MockApiRequest: ApiRequest {
    let url: String

    var urlRequest: URLRequest {
        return URLRequest(url: URL(string: url)!)
    }
}
