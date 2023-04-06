//
//  URLOpener.swift
//  SampleApp
//
//  Created by jc.kim on 3/28/23.
//

import UIKit

protocol URLOpenerProtocol {
  func canOpenURL(_ url: URL) -> Bool
  func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpenerProtocol { }


struct URLOpener {
  private let application: URLOpenerProtocol
  
  init(application: URLOpenerProtocol = UIApplication.shared) {
    self.application = application
  }
  
  func open(url: URL, completion: ((Bool) -> Swift.Void)?) {
    if application.canOpenURL(url) {
      application.open(url, options: [:], completionHandler: completion)
    } else {
      completion?(false)
    }
  }
  
}


