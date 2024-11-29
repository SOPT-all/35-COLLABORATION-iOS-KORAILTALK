//
//  SeatSelectionService.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/29/24.
//

import Foundation

import Moya

protocol SeatSelectionServiceProtocol {
    func getCoaches(timetableId: Int, completion: @escaping (NetworkResult<SeatsResponseDTO>) -> Void)
    func selectSeat(request: SeatSelectionRequestDTO, completion: @escaping (NetworkResult<SeatSelectionResponseDTO>) -> Void)
}

final class SeatSelectionService: BaseService, SeatSelectionServiceProtocol {
    let provider = MoyaProvider<SeatSelectionAPI>(plugins: [MoyaPlugin()])
    
    func getCoaches(timetableId: Int, completion: @escaping (NetworkResult<SeatsResponseDTO>) -> Void) {
        provider.request(.getCoaches(timetableId: timetableId)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<SeatsResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func selectSeat(request: SeatSelectionRequestDTO, completion: @escaping (NetworkResult<SeatSelectionResponseDTO>) -> Void) {
        provider.request(.selectSeat(request)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<SeatSelectionResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
