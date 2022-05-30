//
//  UserResponse.swift
//  VKNews
//
//  Created by lion on 26.05.22.
//

import Foundation

struct UserResponseWrapped: Codable {
    let response: [UserResponse]
}

struct UserResponse: Codable {
    let photo100: String?
}
