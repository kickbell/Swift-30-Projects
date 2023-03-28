//
//  UserRequest.swift
//  SampleApp
//
//  Created by jc.kim on 3/28/23.
//

import Foundation
import Network

struct UserRequest: APIRequest {
  
  func makeRequest(from endpoint: UserEndpoint) throws -> URLRequest {
    var urlComponents = URLComponents()
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.host
    urlComponents.path = endpoint.path
    urlComponents.queryItems = endpoint.queryItems
    
    guard let url = urlComponents.url else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.header
    
    if let body = endpoint.body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    return request
  }
  
  func parseResponse(data: Data) throws -> [User] {
    return try JSONDecoder().decode([User].self, from: data)
  }
  
}
