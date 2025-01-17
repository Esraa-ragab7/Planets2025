//
//  URLSessionSpy.swift
//  PlanetsTests
//
//  Created by Esraa Ragab on 17/01/2025.
//

import Foundation
import Combine
@testable import Planets2025

class URLSessionMock: URLSessionProtocol {
    var output: (data: Data, response: URLResponse)?
    var error: Error?

    func customDataTaskPublisher(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        guard let output = output else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        return Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
