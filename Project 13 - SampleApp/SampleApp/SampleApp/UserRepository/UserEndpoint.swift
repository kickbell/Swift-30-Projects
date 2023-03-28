//
//  UserEndpoint.swift
//  SampleApp
//
//  Created by jc.kim on 3/28/23.
//

import Foundation
import Network

enum UserEndpoint {
  case user
}

extension UserEndpoint: Endpoint {
  var scheme: String {
    return "https"
  }
  
  var host: String {
    return "jsonplaceholder.typicode.com"
  }
  
  var path: String {
    switch self {
    case .user:
      return "/users"
    }
  }
  
  var method: HttpMethod {
    switch self {
    case .user: return .get
    }
  }
  
  var header: [String: String]? {
    return nil
  }
  
  var body: [String: String]? {
    return nil
  }
  
  var queryItems: [URLQueryItem] {
    return []
  }
}




