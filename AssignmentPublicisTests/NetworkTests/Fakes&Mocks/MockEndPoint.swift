//
//  MockEndPoint.swift
//  PublicisSapientAssignmentTests
//
//  Created by Darshana Nagekar on 04/01/25.
//

import Foundation
@testable import AssignmentPublicis

class MockEndPoint: EndPointType {
    var baseURL: URL {
        return URL(string: "https://mockapi.com")!
    }
    
    var path: String {
        return "/users"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var requestBody: Data? {
        return nil
    }
}

