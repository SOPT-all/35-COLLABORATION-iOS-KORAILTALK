//
//  SeatsResponse.swift
//  KorailTalkSample
//
//  Created by 조호근 on 11/18/24.
//

import Foundation

struct SeatsResponse: Decodable {
    
    let data: TrainData
    
}

struct TrainData: Decodable {
    
    let coaches: [Coach]
    
}

struct Coach: Decodable, Hashable {
    
    let coachId: Int
    let leftSeats: Int
    let seats: [Seat]
    
    static let mock: Coach = Coach(
        coachId: 1,
        leftSeats: 10,
        seats: [
            Seat(seatId: 1, seatName: "1A", direction: true, isSold: false),
            Seat(seatId: 2, seatName: "1B", direction: true, isSold: false),
            Seat(seatId: 3, seatName: "1C", direction: true, isSold: true),
            Seat(seatId: 4, seatName: "1D", direction: true, isSold: false),
            Seat(seatId: 5, seatName: "1E", direction: true, isSold: false),
            Seat(seatId: 6, seatName: "1F", direction: true, isSold: false),
            Seat(seatId: 7, seatName: "1G", direction: true, isSold: true),
            Seat(seatId: 8, seatName: "1H", direction: true, isSold: false)
        ]
    )
}

struct Seat: Decodable, Hashable {
    
    let seatId: Int
    let seatName: String
    let direction: Bool
    let isSold: Bool
    
}
