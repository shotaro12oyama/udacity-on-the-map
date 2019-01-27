//
//  SessionInfoRequest.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/28.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import Foundation

struct SessionInfoRequest: Codable {
    
    let udacity: [String:String]
    let username: String
    let password: String
    
}
