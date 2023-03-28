//
//  MockUIApplication.swift
//  SampleAppTests
//
//  Created by jc.kim on 3/28/23.
//

import Foundation
import UIKit
@testable import SampleApp

struct MockUIApplication: URLOpenerProtocol {
  var canOpen: Bool
  
  func canOpenURL(_ url: URL) -> Bool {
    return canOpen
  }
  
  func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
    if canOpen {
      completion?(true)
    }
  }
}


