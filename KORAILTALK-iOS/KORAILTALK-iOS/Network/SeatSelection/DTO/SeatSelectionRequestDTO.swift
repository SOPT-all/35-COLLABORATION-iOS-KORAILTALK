//
//  SeatSelectionRequestDTO.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/29/24.
//

import Foundation

struct SeatSelectionRequestDTO: Encodable {
    let isAuto: Bool
    let timetableId: Int
    let coachId: Int
    let seatId: Int?
    let price: Int
}
