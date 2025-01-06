//
//  NetworkManager.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation
import Combine


// Protocol for a networking layer that defines a generic request function
// to handle API calls and return decoded data as a publisher.

protocol NetworkingProtocol {
    // Generic function that takes an endpoint conforming to EndPointType
    // and returns a publisher with a decoded response or an error.
    func request<T: Decodable>(endPoint: EndPointType) -> AnyPublisher<T, Error>
}

// Enume for various networking errors
enum NetworkingError: LocalizedError, Equatable {
    
    case badURLResponse          // Indicates an invalid server response.
    case serverError(statusCode: Int) // Represents a server error with the status code.
    case decodingError           // Indicates an error while decoding the response data.
    case unknown                 // Represents an unknown error (e.g., connectivity issue).

    // Provides readable description of the errors.
    var errorDescription: String? {
        switch self {
        case .badURLResponse:
            return "Bad response from the server."
        case .serverError(let statusCode):
            return "Server error: \(statusCode)"
        case .decodingError:
            return "Decoding Error."
        case .unknown:
            return "Connection Issue."
        }
    }
}

// An implementation of the NetworkingProtocol using URLSession
// to handle HTTP requests and responses.
final class NetworkManager: NetworkingProtocol {
    
    // URLSession instance used to perform network requests.
    private let session: URLSession
    
    // Initializer with an optional parameter to inject a custom URLSession.
    // Defaults to the shared session.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Implements the request method from NetworkingProtocol.
    // Builds a request, performs the network call, processes the response,
    // decodes the data, and maps errors.
    func request<T: Decodable>(endPoint: EndPointType) -> AnyPublisher<T, Error> {
        
        // Builds the URLRequest from the provided endpoint.
        let request = buildRequest(from: endPoint)
        
        // Uses Combine's dataTaskPublisher to perform the request.
        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                // Processes the HTTP response and extracts data.
                try NetworkManager.handleURLResponse(output: output)
            }
            .decode(type: T.self, decoder: JSONDecoder()) // Decodes the response into the specified type.
            .mapError { error in
                // Maps errors to custom `NetworkingError` or other relevant errors.
                NetworkManager.mapError(error)
            }
            .eraseToAnyPublisher() // Erases the publisher type for flexibility in usage.
    }
    
    // MARK: Private method to build a URLRequest from an EndPointType.
    private func buildRequest(from route: EndPointType) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue // Sets the HTTP method (e.g., GET, POST).
        request.httpBody = route.requestBody // Sets the HTTP body for POST/PUT requests.
        
        // Adds default headers if the task is `.request`.
        if route.task == .request {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}

// Extension containing static helper methods for the NetworkManager.
extension NetworkManager {
    
    // MARK: Static function to handle the HTTP response.
    // Throws an error if the response is invalid or if the status code indicates a failure.
    fileprivate static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse else {
            throw NetworkingError.badURLResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            // Return data for successful status codes.
            return output.data
        case 300...400:
            // Handle client-side errors
            throw NetworkingError.unknown
        default:
            // Handle server-side errors with the status code.
            throw NetworkingError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    // MARK: Static method to map an error to a NetworkingError or other error types.
    fileprivate static func mapError(_ error: Error) -> Error {
        if error is URLError {
            return NetworkingError.unknown // Maps URL errors to `unknown`.
        }
        if error is DecodingError {
            return NetworkingError.decodingError // Maps decoding errors.
        }
        if let networkError = error as? NetworkingError {
            return networkError // Returns the existing `NetworkingError` if applicable.
        }

        return error // Returns the original error if not mapped.
    }
}
