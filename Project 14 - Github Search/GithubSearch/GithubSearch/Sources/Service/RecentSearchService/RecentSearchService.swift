//
//  SearchService.swift
//  GithubSearch
//
//  Created by jc.kim on 4/1/23.
//

import Foundation

protocol RecentSearchService {
  func read() -> [String]
  func create(title: String) -> String
  func remove(title: String) -> [String]
  func removeAll() -> [String]
}

class RecentSearchServiceImp: RecentSearchService {

  private let repository: UserDefaultService
    
  init(repository: UserDefaultService) {
    self.repository = repository
  }
  
  func read() -> [String] {
    repository.read()
  }
  
  func create(title: String) -> String {
    var newItems = repository.read()
    newItems.insert(title, at: 0)
    repository.save(todos: newItems)
    return title
  }
  
  func remove(title: String) -> [String] {
    let newItems = repository.read().filter { $0 != title }
    repository.save(todos: [])
    repository.save(todos: newItems)
    return newItems
  }
  
  func removeAll() -> [String] {
    repository.save(todos: [])
    return []
  }
  
}
