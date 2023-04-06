//
//  Repository.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import Foundation

struct Repository {
  let name: String?
  let stargazersCount: Int
  let language: String?
  let description: String?
  let htmlUrl: String?
  let owner: Owner
}

extension Repository: Decodable {
  enum CodingKeys: String, CodingKey {
    case name
    case stargazersCount = "stargazers_count"
    case language
    case description
    case htmlUrl = "html_url"
    case owner
  }
}


