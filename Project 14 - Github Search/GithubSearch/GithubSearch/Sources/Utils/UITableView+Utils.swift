//
//  UITableView+Utils.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import UIKit

public protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

public extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}

extension UITableViewHeaderFooterView: Reusable {}

public extension UITableView {
  
  func register<T: UITableViewCell>(cellType: T.Type) {
    self.register(cellType, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func register<T: UITableViewHeaderFooterView>(headerFooterType: T.Type) {
    self.register(headerFooterType, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier )
  }
  
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue reusable cell")
    }
    return cell
  }
  
  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for indexPath: IndexPath) -> T {
    guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
      fatalError("Failed to dequeue reusable view")
    }
    return view
  }
  
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .label
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
    messageLabel.sizeToFit()
    
    self.backgroundView = messageLabel
    self.separatorStyle = .none
  }
  
}
