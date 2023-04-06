//
//  RecentSearchReactor.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation
import ReactorKit
import RxSwift

final class RecentSearchReactor: Reactor {
  
  enum Action {
    case insertQuery(String)
    case updateQuery(String)
    case removeQuery(String)
    case removeAll
  }
  
  enum Mutation {
    case setQuery(String)
    case setRecentSearch([String])
  }
  
  struct State {
    var recentSearches: [String] = []
  }
  
  let initialState = State()
  
  private let service: RecentSearchService
  
  init(service: RecentSearchService) {
    self.service = service
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .updateQuery(query):
      return Observable.concat([
        Observable.just(Mutation.setRecentSearch(
            service.read()
              .filter { query == "" ? true : $0.contains(query) })
        )
      ])
    case let .insertQuery(title):
      return Observable.concat([
        Observable.just(Mutation.setQuery(service.create(title: title)))
      ])
    case let .removeQuery(title):
      return Observable.concat([
        Observable.just(Mutation.setRecentSearch(service.remove(title: title)))
      ])
    case .removeAll:
      return Observable.concat([
        Observable.just(Mutation.setRecentSearch(service.removeAll()))
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    case let .setQuery(title):
      var newState = state
      newState.recentSearches.insert(title, at: 0)
      return newState
      
    case let .setRecentSearch(recentSearches):
      var newState = state
      newState.recentSearches = recentSearches
      return newState
    }
  }
  
}
