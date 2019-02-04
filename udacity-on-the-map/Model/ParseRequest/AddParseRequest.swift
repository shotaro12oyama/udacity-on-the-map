//
//  addParseRequest.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/02/04.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation

struct AddParseRequest : Codable{
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}

