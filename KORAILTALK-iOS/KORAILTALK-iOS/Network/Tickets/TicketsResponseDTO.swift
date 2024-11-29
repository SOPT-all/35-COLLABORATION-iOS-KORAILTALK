//
//  TicketsResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/29/24.
//

import Foundation

struct TicketsResponseDTO: Decodable {
    let data: Ticket
}

struct Ticket: Decodable {
    let departurePlace: String
    let arrivalPlace: String
    let date: String
    let trainName: String
    let departureTime: String
    let arrivalTime: String
    let seatName: String
    let ticketPrice: Int
    let limitPaymentTime: String
    let coachesNumber: Int
}
