//
//  RepositoriesResponse.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import Foundation

struct Response {
  let items: [Repository]
  let totalCount: Int
  let incopmpleteResults: Bool
}

extension Response: Decodable {
  enum CodingKeys: String, CodingKey {
    case items
    case totalCount = "total_count"
    case incopmpleteResults = "incomplete_results"
  }
}
