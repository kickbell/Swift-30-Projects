//
//  Owner.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import Foundation

struct Owner {
  let login: String
  let avatarUrl: String
}

extension Owner: Decodable {
  enum CodingKeys: String, CodingKey {
    case login
    case avatarUrl = "avatar_url"
  }
}
