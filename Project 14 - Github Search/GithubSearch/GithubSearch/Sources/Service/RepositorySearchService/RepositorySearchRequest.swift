//
//  SearchRequest.swift
//  GithubSearch
//
//  Created by jc.kim on 4/2/23.
//

import Foundation

struct RepositorySearchRequest: Request {
  
  func makeRequest(from endpoint: RepositorySearchEndpoint) throws -> URLRequest {
    var urlComponents = URLComponents()
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.host
    urlComponents.path = endpoint.path
    urlComponents.queryItems = endpoint.queryItems
    
    guard let url = urlComponents.url else {
      throw NetworkError.invalidURL(url: urlComponents.url?.absoluteString)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.header
    
    if let body = endpoint.body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    return request
  }
  
  func parseResponse(data: Data) throws -> Response {
    return try JSONDecoder().decode(Response.self, from: data)
  }
  
}
