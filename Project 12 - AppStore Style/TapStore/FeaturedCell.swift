//
//  FeaturedCell.swift
//  TapStore
//
//  Created by jc.kim on 2/1/23.
//  Copyright © 2023 Hacking with Swift. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "FeaturedCell"
    
    let tagline = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue //라이트, 다크모드에 따라 달라지는 파랑색
        
    }
    
    func configure(with app: App) {
        
    }
    
    
}
