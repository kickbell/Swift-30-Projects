//
//  RepositoryCell.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit
import RxSwift

final class RepositoryCell: UITableViewCell {
  
  private let avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let avatarLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.textColor = .secondaryLabel
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .label
    return label
  }()
  
  private let desriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private let stargazersCountButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .secondaryLabel
    button.setTitleColor(.secondaryLabel, for: .normal)
    button.setImage(UIImage(systemName: "star"), for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
    button.isEnabled = false
    return button
  }()
  
  private let languageButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .secondaryLabel
    button.setTitleColor(.secondaryLabel, for: .normal)
    button.setImage(
      UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10)),
      for: .normal
    )
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
    button.isEnabled = false
    return button
  }()
  
  private let ownerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .leading
    stackView.spacing = 5
    return stackView
  }()
  
  private let starCountStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .leading
    stackView.spacing = 10
    return stackView
  }()
  
  private let vStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .leading
    stackView.spacing = 5
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
    ownerStackView.addArrangedSubview(avatarImageView)
    ownerStackView.addArrangedSubview(avatarLabel)
    
    starCountStackView.addArrangedSubview(stargazersCountButton)
    starCountStackView.addArrangedSubview(languageButton)
    
    vStackView.addArrangedSubview(ownerStackView)
    vStackView.addArrangedSubview(nameLabel)
    vStackView.addArrangedSubview(desriptionLabel)
    vStackView.addArrangedSubview(starCountStackView)
    
    addSubview(vStackView)
    
    NSLayoutConstraint.activate([
      vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      vStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      
      avatarImageView.widthAnchor.constraint(equalToConstant: 15),
      avatarImageView.heightAnchor.constraint(equalToConstant: 15),
    ])
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    avatarImageView.image = nil
  }
  
  var disposeBag = DisposeBag()
  
  func configure(with target: Repository) {
    let stargazersCount = Formatter.numberFormatter.string(from: NSNumber(value: target.stargazersCount)) ?? ""
    
    loadImage(urlString: target.owner.avatarUrl)
    avatarLabel.text = target.owner.login
    nameLabel.text = target.name
    desriptionLabel.text = target.description
    stargazersCountButton.setTitle(" \(stargazersCount)", for: .normal)
    languageButton.setTitle(" \(target.language ?? "")", for: .normal)
    languageButton.tintColor = Language.color(target.language ?? "")
  }
  
  private func loadImage(urlString: String) {
    guard let url = URL(string: urlString) else {
      print("invalid url: \(urlString)...")
      return
    }
    
    ImageCache.publicCache.load(url: url as NSURL)
      .withUnretained(self)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { cell, image in
        cell.avatarImageView.image = image
      })
      .disposed(by: disposeBag)
  }
  
}


