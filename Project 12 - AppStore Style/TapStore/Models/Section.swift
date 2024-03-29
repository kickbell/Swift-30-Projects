//
//  Section.swift
//  TapStore
//
//  Created by Paul Hudson on 01/10/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
}

extension Section {
    enum AppType: String {
        case mediumTable
        case smallTable
        case featured
        case none
    }
    
    var appType: AppType {
        return AppType(rawValue: self.type) ?? .none
    }
}



