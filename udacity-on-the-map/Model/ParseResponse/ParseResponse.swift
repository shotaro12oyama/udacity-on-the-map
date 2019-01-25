//
//  ParseClient.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/24.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import Foundation

struct ParseResponse : Codable{
    let objectId: String
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String
    let mediaURL: String
    let latitude: Double?
    let longitude: Double?
    let createdAt: String
    let updatedAt: String
}

struct ParseResults : Codable {
    let results: [ParseResponse]
}
