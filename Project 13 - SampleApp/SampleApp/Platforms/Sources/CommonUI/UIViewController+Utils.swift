//
//  UIViewController+Utils.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import UIKit

public extension UIViewController {
  func alert(title: String = "알림", message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
