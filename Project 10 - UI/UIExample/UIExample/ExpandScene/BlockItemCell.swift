//
//  BlockItemCell.swift
//  UIExample
//
//  Created by jc.kim on 8/7/22.
//

import UIKit


// FIXME: - 버그만 잡자.
//누른상태로 드래그하면 (계속 ishighlgited 가 불리는거지 tranfrom 되거나 혹은 origin 값으로 계속 이동함.
// blackButtonDidTap 에서 touchupinsside 로 작업을해주고 있는데 여기서 무슨 작업을 해주면 되지않으까.
// pre 의 값을 바꿔주던지?
class myButton: UIButton {
    
    var didAnimate = false
    
    
    
    override open var isHighlighted: Bool {
        didSet {
//            isHighlighted 가 연속으로 불리면 들어오지 못하게 해야한다.. true로 계속 들어오니까.
            
            guard didAnimate == false else { return }
            
            print(didAnimate, "d")
            self.backgroundColor = isHighlighted ? UIColor.systemPink : UIColor.systemYellow
            self.tintColor = isHighlighted ? UIColor.white : UIColor.systemBlue
            self.frame.origin.y = isHighlighted ? self.frame.origin.y + 2 : self.frame.origin.y - 2
//            self.transform = isHighlighted ? transform.scaledBy(x: 1.1, y: 1.1) : CGAffineTransform.identity
            addShadow()
            
            didAnimate = true
            
        }
    }
    
    
}

extension myButton {
    
    func addShadow() {
        if self.isHighlighted {
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
            self.layer.masksToBounds = false
        } else {
            self.layer.shadowColor = UIColor.clear.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.layer.shadowOpacity = 0.0
            self.layer.shadowRadius = 0.0
            self.layer.masksToBounds = false
        }
    }
}

class BlockItemCell: UITableViewCell {
    
    
    

    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blackButton: myButton!
    
    @IBOutlet weak var profileImageViewHeight: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
        configureStackViewAccessibility()
    }

    
    func configure() {
        profileImageView.layer.cornerRadius = (profileImageViewHeight.constant/2) // 이미지 가로세로 60, 마진 각 5씩인데 반으로 계산
        profileImageView.clipsToBounds = true
        
        blackButton.layer.cornerRadius = 8
        blackButton.addTarget(self, action: #selector(blackButtonDidTap), for: .touchUpInside)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    @objc func blackButtonDidTap() {
//        print("pre: \(blackButton.didAnimate)")
        
        blackButton.didAnimate = false
        
//        print("after: \(blackButton.didAnimate)")
        
        

        
    }
    
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

extension BlockItemCell {
    private func configureStackViewAccessibility() {
        if traitCollection.preferredContentSizeCategory < .accessibilityLarge {
            stackView.axis = .horizontal
            stackView.alignment = .center
        } else {
            stackView.axis = .vertical
            stackView.alignment = .leading
        }
    }
}
