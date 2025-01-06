//
//  UserRequest.swift
//  PublicisSapientAssignment
//
//  Created by Darshana Nagekar on 03/01/25.
//

import Foundation

public enum UserApi {
    case users
}

extension UserApi: EndPointType {
    
    var requestBody: Data? {
            switch self {
            case .users:
                return nil
            }
        }
    
    var baseURL: URL {
        guard  let url = URL(string: NetworkConstant.baseUrl)  else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }

    var path: String {
        switch self {
        case .users:
            return NetworkConstant.users
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .users:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}

 
