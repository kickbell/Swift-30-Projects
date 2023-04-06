//
//  RepositoryReactor.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation

import ReactorKit
import RxSwift
import RxCocoa

final class RepositoryReactor: Reactor {
  
  enum Action {
    case updateQuery(QueryItem)
    case loadNextPage
  }
  
  enum Mutation {
    case setQuery(QueryItem)
    case setRepos([Repository], nextPage: Int?)
    case appendRepos([Repository], nextPage: Int?)
    case setLoading(Bool)
  }
  
  struct State {
    var queryItem = QueryItem(query: "", sort: .default, order: .desc)
    var repos: [Repository] = []
    var nextPage: Int?
    var isLoading: Bool = false
  }
  
  let initialState = State()
  
  private let service: RepositorySearchService
  
  lazy var error: Observable<Error> = self.errorRelay.asObservable()
  
  private let errorRelay = PublishRelay<Error>()
  
  init(service: RepositorySearchService) {
    self.service = service
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .updateQuery(queryItem):
      return Observable.concat([
        Observable.just(Mutation.setLoading(true)),
        Observable.just(Mutation.setQuery(queryItem)),
        
        service.search(query: queryItem.query, page: 1, sort: queryItem.sort, order: queryItem.order)
          .do(onError: { [weak self] error in self?.errorRelay.accept(error) })
          .take(until: self.action.filter(Action.isUpdateQueryAction))
          .map { Mutation.setRepos($0, nextPage: $1)},
        
        Observable.just(Mutation.setLoading(false)),
      ])
    case .loadNextPage:
      guard self.currentState.isLoading == false else { return Observable.empty() }
      guard let page = self.currentState.nextPage else { return Observable.empty() }
      
      return Observable.concat([
        Observable.just(Mutation.setLoading(true)),
                
        service.search(
          query: self.currentState.queryItem.query,
          page: page, sort: self.currentState.queryItem.sort,
          order: self.currentState.queryItem.order
        )
        .do(onError: { [weak self] error in self?.errorRelay.accept(error) })
        .take(until: self.action.filter(Action.isUpdateQueryAction))
        .map { Mutation.appendRepos($0, nextPage: $1) },
        
        Observable.just(Mutation.setLoading(false)),
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    case let .setQuery(queryItem):
      var newState = state
      newState.queryItem = queryItem
      return newState
      
    case let .setRepos(repos, nextPage):
      var newState = state
      newState.repos = repos
      newState.nextPage = nextPage
      return newState
      
    case let .appendRepos(repos, nextPage):
      var newState = state
      newState.repos.append(contentsOf: repos)
      newState.nextPage = nextPage
      return newState
      
    case let .setLoading(isLoadingNextPage):
      var newState = state
      newState.isLoading = isLoadingNextPage
      return newState
    }
  }
  
}


extension RepositoryReactor.Action {
  static func isUpdateQueryAction(_ action: RepositoryReactor.Action) -> Bool {
    if case .updateQuery = action {
      return true
    } else {
      return false
    }
  }
}
