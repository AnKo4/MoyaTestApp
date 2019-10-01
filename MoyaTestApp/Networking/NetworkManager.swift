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
    
    func getComments() {
        provider.request(.comments) { [delegate] result in
            
            
        }
    }
}
