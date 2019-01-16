//
//  File.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/15.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation

struct UdacityUser: Codable {
    let userName: String
    let password: String
}

struct UdacityResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let udacityUser: UdacityUser
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case statusMessage = "status_message"
        case udacityUser
        
    }
}

extension UdacityResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
