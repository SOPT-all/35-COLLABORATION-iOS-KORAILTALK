//
//  UserAPI.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/28/24.
//

import Foundation

import Moya

enum UserAPI {
    case getUserLPoint(parameter: Int)
}

extension UserAPI: BaseTargetType {

    var headerType: HeaderType { return .userIDHeader }
    
    var parameter: [String : Any]? {
        switch self {
        case .getUserLPoint(let pointPassword):
            return ["pointPassword":pointPassword]
        }
    }
        
    var path: String {
        switch self {
        case .getUserLPoint:
            return "/users/points"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserLPoint:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserLPoint:
            return .requestParameters(parameters: parameter ?? [:], encoding: URLEncoding.queryString)
        }
    }
}


