//
//  NetworkService.swift
//  TMDB
//
//  Created by jc.kim on 3/9/23.
//

import Foundation
import Network

public final class NetworkImp: Network {
  
  private let session: URLSession
  
  public init(session: URLSession = .shared) {
    self.session = session
  }
  
  public func load<T: APIRequest>(_ request: T, _ requestData: T.RequestDataType) async -> Result<T.ResponseDataType, NetworkError> {
    do {
      let urlRequest = try request.makeRequest(from: requestData)
      
      let (data, response) = try await session.data(for: urlRequest, delegate: nil)
      guard let response = response as? HTTPURLResponse else {
        return .failure(.unknown)
      }
      switch response.statusCode {
      case 200...299:
        guard let parsedResponse = try? request.parseResponse(data: data) else {
          return .failure(.decode)
        }
        return .success(parsedResponse)
      case 400:
        return .failure(.badRequest)
      case 401:
        return .failure(.needToken)
      case 404:
        return .failure(.dataNotFound)
      case 500:
        return .failure(.interalServerError)
      default:
        return .failure(.unknown)
      }
    } catch {
      return .failure(.unknown)
    }
  }
  
}

