//
//  NetworkManager.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation
import Combine


protocol NetworkingProtocol {
    func request<T: Decodable>(endPoint: EndPointType) -> AnyPublisher<T, Error>
}

enum NetworkingError: LocalizedError,Equatable {
    
    case badURLResponse
    case serverError(statusCode: Int)
    case decodingError
    case unknown

    
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

final class NetworkManager: NetworkingProtocol {
    
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endPoint: EndPointType) -> AnyPublisher<T, Error> {
        
        let request = buildRequest(from: endPoint)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                try NetworkManager.handleURLResponse(output: output)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkManager.mapError(error)
            }
            .eraseToAnyPublisher()
    }
    
    
    private func buildRequest(from route: EndPointType) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        request.httpBody = route.requestBody
        
        if route.task == .request {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}

extension NetworkManager {
    
    fileprivate  static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse else {
            throw NetworkingError.badURLResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return output.data
        case 300...400:
            throw NetworkingError.unknown
        default:
            throw NetworkingError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    fileprivate  static func mapError(_ error: Error) -> Error {
        
        if error is URLError {
               return NetworkingError.unknown
           }
        if error is DecodingError {
            return NetworkingError.decodingError
        }
           if let networkError = error as? NetworkingError {
               return networkError
           }

           return error
    }
}
