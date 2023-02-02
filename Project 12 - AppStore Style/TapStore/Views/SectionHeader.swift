//
//  SectionHeader.swift
//  TapStore
//
//  Created by jc.kim on 2/2/23.
//  Copyright © 2023 Hacking with Swift. All rights reserved.
//

import UIKit

//섹션의 헤더. 스크롤링해도 안움직임. UICollectionReusableView
class SectionHeader: UICollectionReusableView {
    static var reuseIdentifier: String = "SectionHeader"
    
    let title = UILabel()
    let subtitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        subtitle.textColor = .secondaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [separator, title, subtitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        
        //contentView.addSubview처럼 안해주고 이건 그냥 바로 addSubview 해준다.
        //앵커 잡을때도 마찬가지이다. UICollectionReusableView의 특징 중에 하나.
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10) //이거 왜 -10 하지? 
        ])
        
        stackView.setCustomSpacing(10, after: separator)
    }
        
    required init?(coder: NSCoder) {
        //그니까 override init(frame: CGRect)  를 오버라이드한다는 거 자체가 코더로 뭔가 레이아웃을 잡아준다는거야.
        //그니까 coder 이거는 스토리보드꺼라 그걸 막는 그런거.
        fatalError("init(coder:) has not been implemented")
    }
}
