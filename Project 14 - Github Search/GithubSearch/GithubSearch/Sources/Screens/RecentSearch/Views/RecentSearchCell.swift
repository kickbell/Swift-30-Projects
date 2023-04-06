//
//  RecentSearchCell.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit

final class RecentSearchCell: UITableViewCell {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .label
    return label
  }()
  
  let removeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.tintColor = .label
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
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private func setupViews() {
    contentView.backgroundColor = .secondarySystemBackground
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(removeButton)
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
    ])
  }
  
  func configure(with target: String) {
    self.titleLabel.text = target
  }
  
}


