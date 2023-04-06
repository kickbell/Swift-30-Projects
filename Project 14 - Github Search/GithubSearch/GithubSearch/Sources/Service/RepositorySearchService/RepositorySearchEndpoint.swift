//
//  RepositoryEndpoint.swift
//  GithubSearch
//
//  Created by jc.kim on 4/2/23.
//

import Foundation

enum RepositorySearchEndpoint {
  case repositories(
    query: String,
    page: Int,
    sort: Sort = .default,
    order: Order = .desc
  )
}

extension RepositorySearchEndpoint: EndPoint {
  
  var scheme: String {
    "https"
  }
  
  var host: String {
    "api.github.com"
  }
  
  var path: String {
    switch self {
    case .repositories: return "/search/repositories"
    }
  }
  
  var method: HttpMethod {
    switch self {
    case .repositories: return .get
    }
  }
  
  var header: [String : String]? {
    return nil
  }
  
  var body: [String : String]? {
    return nil
  }
  
  var queryItems: [URLQueryItem] {
    var queryItems: [URLQueryItem] = [
      URLQueryItem(name: "per_page", value: "30")
    ]
    
    switch self {
    case let .repositories(query, page, sort, order):
      queryItems.append(URLQueryItem(name: "q", value: query))
      queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
      queryItems.append(URLQueryItem(name: "sort", value: sort.rawValue))
      queryItems.append(URLQueryItem(name: "order", value: order.rawValue))
    }
    
    return queryItems
  }
  
}
