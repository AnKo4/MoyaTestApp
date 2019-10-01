//
//  PostsViewModel.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class PostsViewModel {
    
    weak var delegate: ViewModelDelegate?

    var networkManager = NetworkManager()
    var data = [Post]()
    
    init() {
        networkManager.delegate = self
        networkManager.sendRequest(endpoint: .posts)
    }
}

extension PostsViewModel: NetworkManagerDelegate {
    
    func gotResponse(data: Data) {
        guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {
            print("Something gone wrong while decoding...")
            return
        }
        self.data = posts
        delegate?.refreshScreen()
    }
}
