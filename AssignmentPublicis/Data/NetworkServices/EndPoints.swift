//
//  EndPoints.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var requestBody: Data? { get }
}

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
}

public enum HTTPTask {
    case request
}

public typealias HTTPHeaders = [String:String]

