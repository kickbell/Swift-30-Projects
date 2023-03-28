//
//  ListCell.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import Foundation
import UIKit

public final class UserCell: UITableViewCell {
  
  private let name: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = .label
    return label
  }()
  
  private let username: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .secondaryLabel
    label.numberOfLines = 2
    return label
  }()
  
  private let email: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .secondaryLabel
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupView()
  }
  
  private func setupView() {
    accessoryType = .disclosureIndicator
    stackView.addArrangedSubview(name)
    stackView.addArrangedSubview(username)
    stackView.addArrangedSubview(email)
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
    ])
  }
  
  func configure(with target: User) {
    name.text = "NAME : \(target.name)"
    username.text = "\(target.username)"
    email.text = "\(target.email)"
  }
  
}



