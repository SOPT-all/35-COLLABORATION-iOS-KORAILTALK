//
//  TicketsAPI.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/29/24.
//

import Foundation

import Moya

enum TicketsAPI {
    case getMyTicket(ticketId: Int)
    case patchTicketing(body: TicketsRequestDTO)
}

extension TicketsAPI: BaseTargetType {

    var headerType: HeaderType { return .userIDHeader }
        
    var path: String {
        switch self {
        case .getMyTicket(let ticketId):
            return "/tickets/\(ticketId)"
        case .patchTicketing:
            return "/tickets"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyTicket:
            return .get
        case .patchTicketing:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyTicket:
            return .requestPlain
        case .patchTicketing(let body):
            return .requestJSONEncodable(body)
        }
    }
}
