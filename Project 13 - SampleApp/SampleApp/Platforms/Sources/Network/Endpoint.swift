//
//  Endpoint.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

public protocol Endpoint {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: HttpMethod { get }
  var header: [String: String]? { get }
  var body: [String: String]? { get }
  var queryItems: [URLQueryItem] { get }
}


