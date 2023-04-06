//
//  RecentSearchHeaderView.swift
//  GithubSearch
//
//  Created by jc.kim on 3/31/23.
//

import Foundation
import UIKit

final class RecentSearchHeaderView: UITableViewHeaderFooterView {
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Recent searches"
    label.textColor = .label
    label.font = UIFont.preferredFont(forTextStyle: .title3, weight: .bold)
    return label
  }()
  
  let clearButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitle("Clear", for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    return button
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    return stackView
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private func setupViews() {
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(clearButton)
    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
    ])
  }

}
