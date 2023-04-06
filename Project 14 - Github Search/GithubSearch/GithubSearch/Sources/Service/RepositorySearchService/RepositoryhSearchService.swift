//
//  RepositorySearchService.swift
//  GithubSearch
//
//  Created by jc.kim on 4/4/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol RepositorySearchService {
  func search(query: String, page: Int, sort: Sort, order: Order) -> Observable<(repos: [Repository], nextPage: Int?)>
}

final class RepositorySearchServiceImp: RepositorySearchService {
  
  private let network: Network
  
  init(network: Network) {
    self.network = network
  }
  
  func search(
    query: String,
    page: Int,
    sort: Sort = .default,
    order: Order = .desc
  ) -> Observable<(repos: [Repository], nextPage: Int?)> {
    let request = RepositorySearchRequest()
    let endpoint = RepositorySearchEndpoint.repositories(query: query, page: page, sort: sort, order: order)
    
    return network.send(request, endpoint)
      .map { (response: Response) -> (repos: [Repository], nextPage: Int?) in
        let repos = response.items
        let nextPage = response.incopmpleteResults == false ? page + 1 : page
        
        return (repos, nextPage)
      }
  }
  
}
