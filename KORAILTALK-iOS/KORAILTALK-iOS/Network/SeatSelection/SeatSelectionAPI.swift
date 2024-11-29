//
//  SeatSelectionAPI.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/29/24.
//

import Foundation

import Moya

enum SeatSelectionAPI {
    case getCoaches(timetableId: Int)
    case selectSeat(SeatSelectionRequestDTO)
}

extension SeatSelectionAPI: BaseTargetType {
    
    var headerType: HeaderType { return .userIDHeader }
    
    var path: String {
        switch self {
        case .getCoaches(let timetableId):
            return "/coaches/\(timetableId)"
        case .selectSeat:
            return "/seats"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCoaches:
            return .get
        case .selectSeat:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCoaches:
            return .requestPlain
        case .selectSeat(let dto):
            return .requestJSONEncodable(dto)
        }
    }
}
