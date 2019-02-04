//
//  PublicUserInfo.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/02/03.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import Foundation

struct PublicUserInfo : Codable {
    let memberships: [String?]
    let externalAccounts: [String?]
    let nickname: String
    let registered: Bool?
    let hasPassword: Bool?
    let affiliateProfile: [String?]
    let email: EmailParam?
    let lastName: String
    let firstName: String
    //let enrollments: [String?]
    //let guardInfo: Any?
    let socialAccounts: [String?]
    let cohortKeys: [String?]
    let employerSharing: Bool?
    let imageURL: String?
    let tags: [String?]
    let key: String?
    let badges: [String?]
    //let emailPreferences: Any?
    let principals: [String?]
    
    enum CodingKeys: String, CodingKey {
        case memberships = "_memberships"
        case externalAccounts = "external_accounts"
        case nickname = "nickname"
        case registered = "_registered"
        case hasPassword = "_has_password"
        case affiliateProfile = "_affiliate_profiles"
        case email = "email"
        case lastName = "last_name"
        case firstName = "first_name"
        //case enrollmetns = "_enrollments"
        //case guardInfo = "guard"
        case socialAccounts = "social_accounts"
        case cohortKeys = "_cohort_keys"
        case employerSharing = "employer_sharing"
        case imageURL = "_image_url"
        case tags = "tags"
        case key = "key"
        case badges = "_badges"
        //case emailPreferences = "email_preferences"
        case principals = "_principals"
    }
}

struct EmailParam: Codable {
    let verificationCodeSent: Bool?
    let address: String?
    let verified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case verificationCodeSent = "_verification_code_sent"
        case address = "address"
        case verified = "_verified"
    }
}

