//
//  loginRequest.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/21.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let udacity: [String:String]
    let username: String
    let password: String
    
}

//"{\"udacity\": {\"username\": \"shotaro.oyama@sumitomocorp.com\", \"password\": \"ooyy1954\"}}"
