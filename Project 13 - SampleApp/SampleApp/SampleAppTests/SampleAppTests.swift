//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by jc.kim on 3/28/23.
//

import XCTest
import Network
import NetworkImp
import CommonUI
@testable import SampleApp

class SampleAppTests: XCTestCase {
  private let request = UserRequest()
  
  func test_유저_리퀘스트생성() throws {
    let urlRequest = try request.makeRequest(from: UserEndpoint.user)
    
    XCTAssertEqual(urlRequest.url?.path, UserEndpoint.user.path)
  }
  
  func test_유저_데이터파싱하기() throws {
    let usersData = [User].loadDataFromFile("Users.json", SampleAppTests.self)
    let users = try request.parseResponse(data: usersData)
    let firstUserName = users.first?.username ?? ""
    
    XCTAssertEqual(firstUserName, "Bret")
  }
  
  func test_웹사이트주소_잘열리는지() {
    let mockUIApplication = MockUIApplication(canOpen: true)
    let urlOpener = URLOpener(application: mockUIApplication)
    
    let expectation = expectation(description: "웹사이트가 열리지 않았습니다.")
    
    urlOpener.open(url: URL(string: "http://www.google.com")!) { open in
      expectation.fulfill()
      XCTAssert(open == true, "웹사이트 열기 실패")
    }
    
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  func test_전화앱_잘열리는지() {
    let mockUIApplication = MockUIApplication(canOpen: true)
    let urlOpener = URLOpener(application: mockUIApplication)
    
    let expectation = expectation(description: "전화 앱이 열리지 않았습니다.")
    
    urlOpener.open(url: URL(string: "tel://010-1234-1234")!) { open in
      expectation.fulfill()
      XCTAssert(open == true, "전화 열기 실패")
    }
    
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  func test_Mock프로토콜을통해_임시데이터주입() async throws {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    let network = NetworkImp(session: URLSession(configuration: config))
    
    let service = UserRepositoryImp(networkService: network)
    let jsonString =
    """
    [
      {
        "id": 1,
        "name": "Leanne Graham",
        "username": "Bret",
        "email": "Sincere@april.biz",
        "address": {
          "street": "Kulas Light",
          "suite": "Apt. 556",
          "city": "Gwenborough",
          "zipcode": "92998-3874",
          "geo": {
            "lat": "-37.3159",
            "lng": "81.1496"
          }
        },
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": {
          "name": "Romaguera-Crona",
          "catchPhrase": "Multi-layered client-server neural-net",
          "bs": "harness real-time e-markets"
        }
      }
    ]
    """
    
    let jsonData = Data(jsonString.utf8)
    MockURLProtocol.successMock = [
      "/users": (200, jsonData)
    ]
    
    let _ = try await service.users().get()
    
  }
  
}
