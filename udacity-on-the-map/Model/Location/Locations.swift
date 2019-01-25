//
//  Locations.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/25.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation

struct Locations : Codable{
    let objectId: String
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float?
    let createdAt: String
    let updatedAt: String
}
