//
//  CommentsViewModel.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class CommentsViewModel {
    
    weak var delegate: ViewModelDelegate?

    var networkManager: NetworkManager
    var data: [Comment]
    
    init() {
        self.data = []
        self.networkManager = NetworkManager()
        self.networkManager.delegate = self
        networkManager.sendRequest(endpoint: .comments)
    }
}

extension CommentsViewModel: NetworkManagerDelegate {
    
    func gotResponse(data: Data) {
        guard let comments = try? JSONDecoder().decode([Comment].self, from: data) else {
            print("Something gone wrong while decoding...")
            return
        }
        self.data = comments
        delegate?.refreshScreen()
    }
}

