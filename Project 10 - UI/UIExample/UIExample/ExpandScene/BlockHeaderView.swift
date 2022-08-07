//
//  BlockHeaderView.swift
//  UIExample
//
//  Created by jc.kim on 8/7/22.
//

import UIKit

class BlockHeaderView: UIView {
    var title: UILabel = {
        let label = UILabel()
        label.text = "차단된 사용자"
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.up"), for: .selected)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
        button.isSelected = false
        return button
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(expandButton)
        return stack
    }()
    
    @objc func didTapExpand() {
        callBack?()
        expandButton.isSelected = !expandButton.isSelected
    }
    
    var callBack: (() -> ())?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
}
