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
    
    static let mock: TrainData = TrainData(coaches: [
            Coach(
                coachId: 1,
                leftSeats: 10,
                seats: [
                    Seat(seatId: 1, seatName: "1A", direction: false, isSold: false),
                    Seat(seatId: 2, seatName: "1B", direction: false, isSold: false),
                    Seat(seatId: 3, seatName: "1C", direction: false, isSold: true),
                    Seat(seatId: 4, seatName: "1D", direction: false, isSold: false),
                    Seat(seatId: 5, seatName: "1E", direction: true, isSold: false),
                    Seat(seatId: 6, seatName: "1F", direction: true, isSold: false),
                    Seat(seatId: 7, seatName: "1G", direction: true, isSold: true),
                    Seat(seatId: 8, seatName: "1H", direction: true, isSold: false)
                ]
            ),
            Coach(
                coachId: 2,
                leftSeats: 15,
                seats: [
                    Seat(seatId: 9, seatName: "2A", direction: false, isSold: false),
                    Seat(seatId: 10, seatName: "2B", direction: false, isSold: false),
                    Seat(seatId: 11, seatName: "2C", direction: true, isSold: false),
                    Seat(seatId: 12, seatName: "2D", direction: true, isSold: false),
                    Seat(seatId: 13, seatName: "2E", direction: false, isSold: true),
                    Seat(seatId: 14, seatName: "2F", direction: true, isSold: false),
                    Seat(seatId: 15, seatName: "2G", direction: false, isSold: false),
                    Seat(seatId: 16, seatName: "2H", direction: true, isSold: false)
                ]
            ),
            Coach(
                coachId: 3,
                leftSeats: 12,
                seats: [
                    Seat(seatId: 17, seatName: "3A", direction: false, isSold: true),
                    Seat(seatId: 18, seatName: "3B", direction: false, isSold: false),
                    Seat(seatId: 19, seatName: "3C", direction: true, isSold: false),
                    Seat(seatId: 20, seatName: "3D", direction: true, isSold: false),
                    Seat(seatId: 21, seatName: "3E", direction: false, isSold: false),
                    Seat(seatId: 22, seatName: "3F", direction: true, isSold: true),
                    Seat(seatId: 23, seatName: "3G", direction: true, isSold: false),
                    Seat(seatId: 24, seatName: "3H", direction: false, isSold: false)
                ]
            ),
            Coach(
                coachId: 4,
                leftSeats: 18,
                seats: [
                    Seat(seatId: 25, seatName: "4A", direction: false, isSold: false),
                    Seat(seatId: 26, seatName: "4B", direction: true, isSold: true),
                    Seat(seatId: 27, seatName: "4C", direction: true, isSold: false),
                    Seat(seatId: 28, seatName: "4D", direction: true, isSold: false),
                    Seat(seatId: 29, seatName: "4E", direction: false, isSold: false),
                    Seat(seatId: 30, seatName: "4F", direction: true, isSold: true),
                    Seat(seatId: 31, seatName: "4G", direction: false, isSold: false),
                    Seat(seatId: 32, seatName: "4H", direction: true, isSold: false)
                ]
            ),
            Coach(
                coachId: 5,
                leftSeats: 8,
                seats: [
                    Seat(seatId: 33, seatName: "5A", direction: true, isSold: false),
                    Seat(seatId: 34, seatName: "5B", direction: true, isSold: true),
                    Seat(seatId: 35, seatName: "5C", direction: false, isSold: false),
                    Seat(seatId: 36, seatName: "5D", direction: true, isSold: false),
                    Seat(seatId: 37, seatName: "5E", direction: false, isSold: false),
                    Seat(seatId: 38, seatName: "5F", direction: false, isSold: false),
                    Seat(seatId: 39, seatName: "5G", direction: true, isSold: true),
                    Seat(seatId: 40, seatName: "5H", direction: true, isSold: false)
                ]
            )
        ])
    
}

struct Coach: Decodable, Hashable {
    
    let coachId: Int
    let leftSeats: Int
    let seats: [Seat]
    
    static let mock: Coach = Coach(
        coachId: 1,
        leftSeats: 10,
        seats: [
            Seat(seatId: 1, seatName: "1A", direction: false, isSold: false),
            Seat(seatId: 2, seatName: "1B", direction: true, isSold: false),
            Seat(seatId: 3, seatName: "1C", direction: false, isSold: true),
            Seat(seatId: 4, seatName: "1D", direction: true, isSold: false),
            Seat(seatId: 5, seatName: "1E", direction: false, isSold: false),
            Seat(seatId: 6, seatName: "1F", direction: true, isSold: false),
            Seat(seatId: 7, seatName: "1G", direction: false, isSold: true),
            Seat(seatId: 8, seatName: "1H", direction: true, isSold: false),
            Seat(seatId: 9, seatName: "2A", direction: false, isSold: false),
            Seat(seatId: 10, seatName: "2B", direction: true, isSold: true),
            Seat(seatId: 11, seatName: "2C", direction: false, isSold: false),
            Seat(seatId: 12, seatName: "2D", direction: true, isSold: false),
            Seat(seatId: 13, seatName: "2E", direction: false, isSold: true),
            Seat(seatId: 14, seatName: "2F", direction: true, isSold: false),
            Seat(seatId: 15, seatName: "2G", direction: false, isSold: false),
            Seat(seatId: 16, seatName: "2H", direction: true, isSold: false),
            Seat(seatId: 17, seatName: "3A", direction: false, isSold: true),
            Seat(seatId: 18, seatName: "3B", direction: true, isSold: false),
            Seat(seatId: 19, seatName: "3C", direction: false, isSold: false),
            Seat(seatId: 20, seatName: "3D", direction: true, isSold: true),
            Seat(seatId: 21, seatName: "3E", direction: false, isSold: false),
            Seat(seatId: 22, seatName: "3F", direction: true, isSold: false),
            Seat(seatId: 23, seatName: "3G", direction: false, isSold: true),
            Seat(seatId: 24, seatName: "3H", direction: true, isSold: false),
            Seat(seatId: 25, seatName: "4A", direction: false, isSold: false),
            Seat(seatId: 26, seatName: "4B", direction: true, isSold: true),
            Seat(seatId: 27, seatName: "4C", direction: false, isSold: false),
            Seat(seatId: 28, seatName: "4D", direction: true, isSold: false),
            Seat(seatId: 29, seatName: "4E", direction: false, isSold: true),
            Seat(seatId: 30, seatName: "4F", direction: true, isSold: false),
            Seat(seatId: 31, seatName: "4G", direction: false, isSold: false),
            Seat(seatId: 32, seatName: "4H", direction: true, isSold: false)
        ]
    )
}

struct Seat: Decodable, Hashable {
    
    let seatId: Int
    let seatName: String
    let direction: Bool
    let isSold: Bool
    
}
