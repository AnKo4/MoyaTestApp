//
//  APIClient.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {
    let provider = MoyaProvider<MoyaService>()
    
    
    
    weak var delegate: NetworkManagerDelegate?
    
    func sendRequest(endpoint: MoyaService) {
        provider.request(endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.delegate?.gotResponse(data: response.data)
            case .failure(let error):
                print(error.errorDescription ?? "Something gone wrong...")
            }
        }
    }
    
    
    
    private func decodeData<T: Codable>(data: Data, to structure: T.Type) -> T {
        guard let decodedData = try? JSONDecoder().decode(structure.self, from: data) else {
            print("Something gone wrong while decoding...")
            return structure as! T // Это ДИЧАЙШИЙ костыль! Надо исправить
        }
        return decodedData
    }
    
    func getComments<T: Codable>(to structure: T.Type, completion: @escaping (T) -> Void) {
        provider.request(.comments) { [weak self] result in
            guard let self = self else { return }
             switch result {
             case .success(let response):
                completion(self.decodeData(data: response.data, to: structure))
             case .failure(let error):
                 print(error.errorDescription ?? "Something gone wrong...")
             }
        }
    }
}
