//
//  SelfConfiguringCell.swift
//  TapStore
//
//  Created by jc.kim on 2/1/23.
//  Copyright © 2023 Hacking with Swift. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: App)
}
