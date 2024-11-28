//
//  TimetableService.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/28/24.
//

import Foundation

import Moya

protocol TimetableServiceProtocol {
    func getTimetables(
        date: String,
        completion: @escaping (NetworkResult<TimetableResponseDTO>) -> ()
    )
}

final class TimetableService: BaseService, TimetableServiceProtocol {
    let provider = MoyaProvider<TimetableAPI>.init(plugins: [MoyaPlugin()])
    
    func getTimetables(
        date: String,
        completion: @escaping (NetworkResult<TimetableResponseDTO>) -> ()
    ) {
        provider.request(
            .getTimetables(
                date: date
            )
        ) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<TimetableResponseDTO> = self.fetchNetworkResult(
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
