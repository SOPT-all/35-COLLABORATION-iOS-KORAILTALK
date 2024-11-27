//
//  UserService.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/28/24.
//

import Foundation

import Moya

protocol UserServiceProtocol {
    func getUserLPoint(parameter: Int, completion: @escaping (NetworkResult<LPointResponseDTO>) -> ())
}

final class UserService: BaseService, UserServiceProtocol {
    let provider = MoyaProvider<UserAPI>.init(plugins: [MoyaPlugin()])
    
    func getUserLPoint(parameter: Int, completion: @escaping (NetworkResult<LPointResponseDTO>) -> ()) {
        provider.request(.getUserLPoint(parameter: parameter)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<LPointResponseDTO> = self.fetchNetworkResult(
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
