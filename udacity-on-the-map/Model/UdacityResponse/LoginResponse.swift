//
//  File.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/15.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}

struct LoginResponse: Codable {
    
    let account: Account
    let session: Session
}
