//
//  NetworkManagerDelegate.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate: class {
    func gotResponse(data: Data)
}
