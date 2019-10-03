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
    
    
    
    private func decodeData<T: Codable>(data: Data, to structure: T.Type) -> T? {
        guard let decodedData = try? JSONDecoder().decode(structure.self, from: data) else {
            print("Something gone wrong while decoding...")
            return nil
        }
        return decodedData
    }
    
    func getComments(completion: @escaping ([Comment]) -> Void) {
        provider.request(.comments) { [weak self] result in
            guard let self = self else { return }
             switch result {
             case .success(let response):
                guard let decodedData = self.decodeData(data: response.data, to: [Comment].self) else { return }
                completion(decodedData)
             case .failure(let error):
                 print(error.errorDescription ?? "Something gone wrong...")
             }
        }
    }
    
    
    func createPost(title: String, body: String, userId: Int, completion: @escaping (String, Post) -> Void) {
        provider.request(.createPost(title: title, body: body, userId: userId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let decodedResponse = self.decodeData(data: response.data, to: Post.self) else { return }
                completion(response.description, decodedResponse)
            case .failure(let error):
                print(error.errorDescription ?? "Something gone wrong...")
            }
        }
    }
    
    
    func patchPost(id: Int, title: String?, body: String?, userId: Int?, completion: @escaping (String, Post) -> Void) {
        provider.request(.patchPost(id: id, title: title, body: body, userId: userId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let decodedResponse = self.decodeData(data: response.data, to: Post.self) else { return }
                completion(response.description, decodedResponse)
            case .failure(let error):
                print(error.errorDescription ?? "Something gone wrong...")
            }
        }
        
    }
    
}
