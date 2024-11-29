//
//  TimetableAPI.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/28/24.
//

import Foundation

import Moya

enum TimetableAPI {
    case getTimetables(date: String)
}

extension TimetableAPI: BaseTargetType {

    var headerType: HeaderType { return .userIDHeader }
    //TODO: 더미 들어오면 바꾸기
    var parameter: [String : Any]? {
        switch self {
        case .getTimetables(let date):
            return [
                "date": "2024.11.16",
                "departurePlace": "서울",
                "arrivalPlace": "부산"
            ]
        }
    }
        
    var path: String {
        switch self {
        case .getTimetables:
            return "/timetables"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTimetables:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTimetables:
            return .requestParameters(parameters: parameter ?? [:], encoding: URLEncoding.queryString)
        }
    }
}


