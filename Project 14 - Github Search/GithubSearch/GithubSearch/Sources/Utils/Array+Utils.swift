//
//  Array+Utils.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}
