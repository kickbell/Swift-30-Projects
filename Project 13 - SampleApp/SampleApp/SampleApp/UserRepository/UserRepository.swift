//
//  UserRepository.swift
//  SampleApp
//
//  Created by jc.kim on 3/28/23.
//

import Foundation
import Network
import NetworkImp

protocol UserRepository: AnyObject {
  func users() async -> Result<[User], NetworkError>
}

final class UserRepositoryImp: UserRepository {
  
  private let networkService: Network
  
  init(networkService: Network) {
    self.networkService = networkService
  }
  
  func users() async -> Result<[User], NetworkError> {
      return await networkService.load(UserRequest(), UserEndpoint.user)
  }
  
}
