//
//  NetworkServiceType.swift
//  TMDB
//
//  Created by jc.kim on 3/9/23.
//

import Foundation

public protocol Network: AnyObject {
  func load<T: APIRequest>(_ request: T, _ requestData: T.RequestDataType) async -> Result<T.ResponseDataType, NetworkError>
}

public enum NetworkError: Int, Error, CustomStringConvertible {
  case invalidURL
  case decode
  case badRequest = 400
  case needToken = 401
  case dataNotFound = 404
  case interalServerError = 500
  case unknown
  
  public var description: String {
    switch self {
    case .invalidURL: return "잘못된 주소입니다."
    case .decode: return "데이터를 찾을 수 없습니다."
    case .badRequest: return "잘못된 요청입니다."
    case .needToken: return "토큰이 필요합니다."
    case .dataNotFound: return "데이터를 찾을 수 없습니다."
    case .interalServerError: return "잠시만 기다려주세요."
    case .unknown: return "알 수 없는 오류입니다."
    }
  }
}
