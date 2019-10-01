//
//  MoyaService.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import Moya

enum MoyaService {
    case posts
    case comments
    case postByID(id: Int)
    case postsByUserID(id: Int)
    case commentsByPostID(id: Int)
}

extension MoyaService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .comments:
            return "/comments"
        case .postByID(let id):
            return "/posts/\(id)"
        case .postsByUserID(let id):
            return "/posts?userId=\(id)"
        case .commentsByPostID(let id):
            return "/comments?postId=\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .posts, .comments, .postByID, .postsByUserID, .commentsByPostID:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .posts, .comments, .postByID, .postsByUserID, .commentsByPostID:
        return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    
}
