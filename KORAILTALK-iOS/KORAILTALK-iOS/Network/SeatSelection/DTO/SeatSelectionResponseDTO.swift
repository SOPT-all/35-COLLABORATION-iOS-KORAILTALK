//
//  SeatSelectionResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/29/24.
//

import Foundation

struct SeatSelectionResponseDTO: Decodable {
    let data: TicketData
}

struct TicketData: Decodable {
    let ticketId: Int
}
