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
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel //투명한 종류의 레이블 색깔이라고함.
        
        //UIFontMetrics.default.scaledFont 이걸 쓰는 이유가. 그런거지.
        //다이내믹 폰트를 지원하고싶긴한데. forTextStyle 같은 쪽에선 한계가 있잖아. 이게. 종류가 10개정도밖에.
        //그러면 내맘대로 커스텀하기 쉽지가 않잖아. 그래서 그럴땐 이걸 쓰는듯.
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue //라이트, 다크모드에 따라 달라지는 파랑색
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        
        //스택뷰 왜쓸까..생각해봤는데. 오토레이아웃 코드를 엄청나게 줄여줄수가 있어. 그래서 쓰네 보니까. 
        let stackView = UIStackView(arrangedSubviews: [separator, tagline, name, subtitle, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(10, after: separator) //separator 밑에 10이라는 공간이 생김.
        stackView.setCustomSpacing(10, after: subtitle) //subtitle밑에만 10을 추가해주는건가본데..?
    }
    
    required init?(coder: NSCoder) {
        //이것도 한번 정리해야됨.. 사용자 지정 이니셜라이저를 구현했기떄문에 얘가 필요한건데. 정확히 왜그런건지.
        //정확히는 스토리보드에서 이 항목을 생성하는 것을 지원하지 않기위해 하는거다.
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with app: App) {
        tagline.text = app.tagline.uppercased()
        name.text = app.name
        subtitle.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
}








