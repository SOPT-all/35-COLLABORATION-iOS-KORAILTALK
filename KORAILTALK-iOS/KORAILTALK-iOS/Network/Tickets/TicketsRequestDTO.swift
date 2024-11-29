//
//  TicketsRequestDTO.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/29/24.
//

import Foundation

struct TicketsRequestDTO: Codable {
    let ticketId: Int
    let totalPrice: Int
    let usedPoint: Int
}
