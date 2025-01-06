//
//  EndPoints.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation

// Protocol that defines the requirements for creating an API endpoint
protocol EndPointType {
    var baseURL: URL { get } // The base URL for the API
    var path: String { get }
    var httpMethod: HTTPMethod { get } // The specific path for the API endpoint
    var task: HTTPTask { get } // The HTTP method to be used for the request
    var headers: HTTPHeaders? { get }   // Any additional headers to be included in the HTTP request
    var requestBody: Data? { get }  // The body of the HTTP request used for POST or PUT requests
}

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
}

// Enum for type of HTTP task to be performed
public enum HTTPTask {
    case request
}

public typealias HTTPHeaders = [String:String]

