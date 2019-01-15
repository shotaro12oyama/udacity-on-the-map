//
//  File.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/15.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable {
    let statusCode: Int
    let userName: String
    let password: String
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case userName
        case password
        case statusMessage = "status_message"
    }
}

extension UdacityResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
