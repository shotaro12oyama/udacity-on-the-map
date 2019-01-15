//
//  File.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/15.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable {
    let username: String
    let password: String
    let udacity: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension UdacityResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
