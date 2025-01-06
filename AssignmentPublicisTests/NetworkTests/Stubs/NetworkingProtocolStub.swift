//
//  NetworkingProtocolStub.swift
//  PublicisSapientAssignmentTests
//
//  Created by Darshana Nagekar on 04/01/25.
//

import XCTest
import Combine
@testable import AssignmentPublicis

final class NetworkManagerStub: NetworkingProtocol {

    var result: AnyPublisher<Data, NetworkingError>!
    
    init(result: AnyPublisher<Data, NetworkingError>) {
        self.result = result
    }
    
    func request<T: Decodable>(endPoint: EndPointType) -> AnyPublisher<T, Error> {
       // let request = buildRequest(from: endPoint as! MockEndPoint)
        return result
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                self.mapError(error)
            }
            .eraseToAnyPublisher()
    }

    func buildRequest(from route: MockEndPoint) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        request.httpBody = route.requestBody
        
        if route.task == .request {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let headers = route.headers {
            headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        }
        return request
    }

     func mapError(_ error: Error) -> Error {
      
         // Check for URL errors
        if error is URLError {
            return NetworkingError.unknown
        }
        
        // Check for decoding errors
        if error is DecodingError {
            return NetworkingError.decodingError
        }

        // Check for other NetworkingError types
        if let networkError = error as? NetworkingError {
            return networkError
        }

        return error
    }
}
