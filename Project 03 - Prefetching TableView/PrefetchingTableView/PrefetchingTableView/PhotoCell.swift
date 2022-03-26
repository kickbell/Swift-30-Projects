//
//  PhotoCell.swift
//  PrefetchingTableView
//
//  Created by jc.kim on 3/27/22.
//

import Foundation
import UIKit

class PhotoCell: UITableViewCell {
  
  private let photo: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(photo)
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photo.image = nil
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      photo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  func configure(with viewModel: ViewModel) {
    viewModel.downloadImage { [weak self] image in
      DispatchQueue.main.async {
        self?.photo.image = image
      }
    }
  }
}
