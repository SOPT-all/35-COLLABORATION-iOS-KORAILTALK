//
//  TicketsService.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/29/24.
//

import Foundation

import Moya

protocol TicketsServiceProtocol {
    func getMyTicket(ticketId: Int, completion: @escaping (NetworkResult<TicketsResponseDTO>) -> ())
}

final class TicketsService: BaseService, TicketsServiceProtocol {
    let provider = MoyaProvider<TicketsAPI>.init(plugins: [MoyaPlugin()])
    
    func getMyTicket(ticketId: Int, completion: @escaping (NetworkResult<TicketsResponseDTO>) -> ()) {
        provider.request(.getMyTicket(ticketId: ticketId)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<TicketsResponseDTO> = self.fetchNetworkResult(
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
