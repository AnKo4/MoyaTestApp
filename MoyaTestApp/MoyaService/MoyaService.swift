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
    case createPost(title: String, body: String, userId: Int)
    case patchPost(id: Int, title: String?, body: String?, userId: Int?)
    case deletePost(id: Int)
}

extension MoyaService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .posts, .createPost:
            return "/posts"
        case .comments:
            return "/comments"
        case .postByID(let id), .patchPost(let id, _, _, _), .deletePost(let id):
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
        case .createPost:
            return .post
        case .patchPost:
            return .patch
        case .deletePost:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .posts, .comments, .postByID, .postsByUserID, .commentsByPostID, .deletePost:
            return .requestPlain
        case .createPost(let title, let body, let userId):
            return .requestParameters(parameters: ["title": title, "body": body, "userId": userId], encoding: JSONEncoding.default)
        case .patchPost(let id, let title, let body, let userId):
            var parameters = [String: Any]()
            parameters["id"] = id
            if title != nil { parameters["title"] = title }
            if body != nil { parameters["body"] = body }
            if userId != nil { parameters["userId"] = userId }
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    
}
