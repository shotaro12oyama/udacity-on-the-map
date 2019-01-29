//
//  LoginInfo.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/29.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation


struct UserInfo: Codable {
    let username: String?
    let password: String?
}

struct LoginInfo: Codable {
    let udacity: UserInfo
}
