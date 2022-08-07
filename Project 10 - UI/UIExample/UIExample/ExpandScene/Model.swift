//
//  Model.swift
//  UIExample
//
//  Created by jc.kim on 8/7/22.
//

import Foundation


struct BlockManager {
    let blockUser: [User]
    let nonBlolckUser: [User]
}

struct User: Identifiable {
    let id: String
    let profileImageUrl: String?
    let chanelName: String
    let isBlocked: Bool
}


