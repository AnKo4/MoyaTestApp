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

    var networkManager = NetworkManager()
    var data = [Comment]()
    
    func configure(completion: @escaping () -> Void) {
        self.data = []
        networkManager.getComments() { [weak self] result in
            guard let self = self else { return }
            self.data = result
            completion()
        }
    }
}
