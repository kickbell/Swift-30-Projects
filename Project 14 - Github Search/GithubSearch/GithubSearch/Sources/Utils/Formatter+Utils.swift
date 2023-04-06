//
//  Formatter+Utils.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import Foundation
import UIKit

struct Formatter {
  static let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}
