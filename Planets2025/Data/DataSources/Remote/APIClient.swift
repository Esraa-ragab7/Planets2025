//
//  APIClient.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation
import Combine

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest) -> AnyPublisher<ApiResponse<T>, Error>
}

protocol URLSessionProtocol {
    func customDataTaskPublisher(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error>
}

extension URLSession: URLSessionProtocol {
    func customDataTaskPublisher(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        return dataTaskPublisher(for: request)
            .mapError { error in
                error as Error  // Map URLError to the general Error type
            }
            .eraseToAnyPublisher()  // Return the generic publisher
    }
}

class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - ApiClient
    func execute<T>(request: ApiRequest) -> AnyPublisher<ApiResponse<T>, Error> {
        return urlSession.customDataTaskPublisher(for: request.urlRequest)
            .tryMap { (data, response) -> ApiResponse<T> in
                // Handle the response and data here
                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    throw NetworkRequestError(error: nil)
                }
                
                let successRange = 200...299
                if successRange.contains(httpUrlResponse.statusCode) {
                    // Parse and return the response as ApiResponse
                    return try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                } else {
                    throw ApiError(data: data, httpUrlResponse: httpUrlResponse)
                }
            }
            .eraseToAnyPublisher()  // Return the publisher of type AnyPublisher<ApiResponse<T>, Error>
    }
}
