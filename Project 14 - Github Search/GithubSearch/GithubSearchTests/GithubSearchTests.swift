//
//  GithubSearchTests.swift
//  GithubSearchTests
//
//  Created by jc.kim on 4/5/23.
//

import XCTest
import RxSwift
@testable import GithubSearch

class GithubSearchTests: XCTestCase {
  
  var disposeBag = DisposeBag()
  
  func test_레포지토리_리퀘스트_생성() throws {
    //given
    let request = RepositorySearchRequest()
    let endpoint = RepositorySearchEndpoint.repositories(query: "Swift", page: 1, sort: .default, order: .desc)
    
    //when
    let urlRequest = try request.makeRequest(from: endpoint)
    
    //then
    XCTAssertEqual(urlRequest.url?.path, endpoint.path)
  }
  
  func test_레포지토리_데이터_파싱() throws {
    //given
    let request = RepositorySearchRequest()
    let data = Response.loadDataFromFile("repositories.json", type(of: self))
    
    //when
    let responds = try request.parseResponse(data: data)
    
    //then
    XCTAssertEqual(responds.items.first?.name, "swift")
  }
  
  func test_MockURLProtocol으로_데이터주입() throws {
    //given
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: config)
    let network = NetworkImp(session: session)
    let service = RepositorySearchServiceImp(network: network)
    let data = Response.loadDataFromFile("repositories.json", type(of: self))
    
    //when
    MockURLProtocol.successMock = [
      "/search/repositories": (200, data)
    ]
    
    //then
    service.search(query: "Swift", page: 1, sort: .default, order: .desc)
      .subscribe()
      .disposed(by: disposeBag)
  }
}
