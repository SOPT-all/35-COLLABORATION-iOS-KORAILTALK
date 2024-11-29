//
//  TimetableResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/28/24.
//

import Foundation

struct TimetableResponseDTO: Decodable {
    let data: Timetables
}

struct Timetables: Decodable {
    let timetables: [TrainInformation]
}

struct TrainInformation: Decodable {
    let timetableId: Int
    let trainName: String
    let departureTime: String
    let arrivalTime: String
    let standardPrice: Int
    let premiumPrice: Int
    let isStandardSold: Bool
    let isPremiumSold: Bool
    let travelTime: Int
}
